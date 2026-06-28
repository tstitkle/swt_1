package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Booking;
import model.BookingDetailItem;

public class BookingDAO extends DBContext {
    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM Bookings WHERE UserId = ? ORDER BY BookingDate DESC";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Booking b = new Booking();
                    b.setBookingId(rs.getInt("BookingId"));
                    b.setUserId(rs.getInt("UserId"));
                    b.setBookingDate(rs.getTimestamp("BookingDate"));
                    b.setTotalAmount(rs.getDouble("TotalAmount"));
                    b.setStatus(rs.getString("Status"));
                    list.add(b);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getTotalBookings() {
        String sql = "SELECT COUNT(*) FROM Bookings";
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Booking> getRecentBookings(int count) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Bookings ORDER BY BookingDate DESC";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, count);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Booking b = new Booking();
                    b.setBookingId(rs.getInt("BookingId"));
                    b.setUserId(rs.getInt("UserId"));
                    b.setBookingDate(rs.getTimestamp("BookingDate"));
                    b.setTotalAmount(rs.getDouble("TotalAmount"));
                    b.setStatus(rs.getString("Status"));
                    list.add(b);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM Bookings ORDER BY BookingDate DESC";
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getInt("BookingId"));
                b.setUserId(rs.getInt("UserId"));
                b.setBookingDate(rs.getTimestamp("BookingDate"));
                b.setTotalAmount(rs.getDouble("TotalAmount"));
                b.setStatus(rs.getString("Status"));
                list.add(b);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Booking getBookingByIdAndUserId(int bookingId, int userId) {
        String sql = "SELECT * FROM Bookings WHERE BookingId = ? AND UserId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, bookingId);
            st.setInt(2, userId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Booking b = new Booking();
                    b.setBookingId(rs.getInt("BookingId"));
                    b.setUserId(rs.getInt("UserId"));
                    b.setBookingDate(rs.getTimestamp("BookingDate"));
                    b.setTotalAmount(rs.getDouble("TotalAmount"));
                    b.setStatus(rs.getString("Status"));
                    return b;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<BookingDetailItem> getBookingDetailItems(int bookingId, int userId) {
        List<BookingDetailItem> items = new ArrayList<>();
        String sql = "SELECT td.TicketId, td.EventId, td.Quantity, td.UnitPrice, e.Title, e.EventDate "
                + "FROM TicketDetails td "
                + "INNER JOIN Events e ON td.EventId = e.EventId "
                + "INNER JOIN Bookings b ON td.BookingId = b.BookingId "
                + "WHERE td.BookingId = ? AND b.UserId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, bookingId);
            st.setInt(2, userId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    BookingDetailItem item = new BookingDetailItem();
                    item.setTicketId(rs.getInt("TicketId"));
                    item.setEventId(rs.getInt("EventId"));
                    item.setQuantity(rs.getInt("Quantity"));
                    item.setUnitPrice(rs.getDouble("UnitPrice"));
                    item.setEventTitle(rs.getString("Title"));
                    item.setEventDate(rs.getTimestamp("EventDate"));
                    items.add(item);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return items;
    }

    public boolean createBooking(Booking b, int eventId, int quantity, double price) {
        String sqlBooking = "INSERT INTO Bookings (UserId, BookingDate, TotalAmount, Status) VALUES (?, GETDATE(), ?, 'COMPLETED')";
        String sqlTicket = "INSERT INTO TicketDetails (BookingId, EventId, Quantity, UnitPrice) VALUES (?, ?, ?, ?)";

        try {
            connection.setAutoCommit(false);

            try (PreparedStatement stB = connection.prepareStatement(sqlBooking, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stB.setInt(1, b.getUserId());
                stB.setDouble(2, b.getTotalAmount());
                stB.executeUpdate();

                try (ResultSet rs = stB.getGeneratedKeys()) {
                    if (rs.next()) {
                        int bookingId = rs.getInt(1);
                        try (PreparedStatement stT = connection.prepareStatement(sqlTicket)) {
                            stT.setInt(1, bookingId);
                            stT.setInt(2, eventId);
                            stT.setInt(3, quantity);
                            stT.setDouble(4, price);
                            stT.executeUpdate();
                        }
                        connection.commit();
                        return true;
                    }
                }
            }
            connection.rollback();
        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException e) {
                Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, e);
            }
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;
    }
}