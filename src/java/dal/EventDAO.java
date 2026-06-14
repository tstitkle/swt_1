package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Event;

public class EventDAO extends DBContext {
    public List<Event> getAllEvents() {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT * FROM Events";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Event e = new Event();
                e.setEventId(rs.getInt("EventId"));
                e.setTitle(rs.getString("Title"));
                e.setDescription(rs.getString("Description"));
                e.setEventDate(rs.getTimestamp("EventDate"));
                e.setVenueId(rs.getInt("VenueId"));
                e.setCategoryId(rs.getInt("CategoryId"));
                e.setPrice(rs.getDouble("Price"));
                e.setStatus(rs.getString("Status"));
                list.add(e);
            }
        } catch (SQLException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Event getEventById(int id) {
        String sql = "SELECT * FROM Events WHERE EventId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Event e = new Event();
                e.setEventId(rs.getInt("EventId"));
                e.setTitle(rs.getString("Title"));
                e.setDescription(rs.getString("Description"));
                e.setEventDate(rs.getTimestamp("EventDate"));
                e.setVenueId(rs.getInt("VenueId"));
                e.setCategoryId(rs.getInt("CategoryId"));
                e.setPrice(rs.getDouble("Price"));
                e.setStatus(rs.getString("Status"));
                return e;
            }
        } catch (SQLException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int getTotalEvents() {
        String sql = "SELECT COUNT(*) FROM Events";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public void addEvent(Event e) {
        String sql = "INSERT INTO Events (Title, Description, EventDate, Price, CategoryId, VenueId) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, e.getTitle());
            st.setString(2, e.getDescription());
            st.setTimestamp(3, new java.sql.Timestamp(e.getEventDate().getTime()));
            st.setDouble(4, e.getPrice());
            st.setInt(5, e.getCategoryId());
            st.setInt(6, e.getVenueId());
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateEvent(Event e) {
        String sql = "UPDATE Events SET Title = ?, Description = ?, EventDate = ?, Price = ?, CategoryId = ?, VenueId = ? WHERE EventId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, e.getTitle());
            st.setString(2, e.getDescription());
            st.setTimestamp(3, new java.sql.Timestamp(e.getEventDate().getTime()));
            st.setDouble(4, e.getPrice());
            st.setInt(5, e.getCategoryId());
            st.setInt(6, e.getVenueId());
            st.setInt(7, e.getEventId());
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteEvent(int id) {
        String sql = "DELETE FROM Events WHERE EventId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Event> searchEvents(String keyword) {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT * FROM Events WHERE Title LIKE ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + keyword + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Event e = new Event();
                e.setEventId(rs.getInt("EventId"));
                e.setTitle(rs.getString("Title"));
                e.setDescription(rs.getString("Description"));
                e.setEventDate(rs.getTimestamp("EventDate"));
                e.setPrice(rs.getDouble("Price"));
                e.setCategoryId(rs.getInt("CategoryId"));
                e.setVenueId(rs.getInt("VenueId"));
                list.add(e);
            }
        } catch (SQLException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Event> getEventsByCategory(int catId) {
        List<Event> list = new ArrayList<>();
        String sql = "SELECT * FROM Events WHERE CategoryId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, catId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Event e = new Event();
                e.setEventId(rs.getInt("EventId"));
                e.setTitle(rs.getString("Title"));
                e.setDescription(rs.getString("Description"));
                e.setEventDate(rs.getTimestamp("EventDate"));
                e.setPrice(rs.getDouble("Price"));
                e.setCategoryId(rs.getInt("CategoryId"));
                e.setVenueId(rs.getInt("VenueId"));
                list.add(e);
            }
        } catch (SQLException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
