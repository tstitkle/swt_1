
import org.junit.Test;
import org.junit.Before;
import org.junit.Assert;
import static org.mockito.Mockito.*;

import dal.BookingDAO;
import model.Booking;

import java.sql.*;

public class BookingDAOTest {

    private BookingDAO dao;
    private Connection mockConn;
    private PreparedStatement mockStmtBooking;
    private PreparedStatement mockStmtTicket;
    private ResultSet mockGeneratedKeys;

    @Before
    public void setUp() throws Exception {
        mockConn = mock(Connection.class);
        mockStmt = mock(PreparedStatement.class);
        mockRs = mock(ResultSet.class);

        doNothing().when(mockStmt).close();
        doNothing().when(mockRs).close();

        // default behavior for executeQuery — return mockRs
        when(mockStmt.executeQuery()).thenReturn(mockRs);
        when(mockConn.prepareStatement(anyString())).thenReturn(mockStmt);

        dao = new UserDAO(mockConn);
    }

    // --- createBooking() tests ---
    @Test
    public void testCreateBooking_Success_ReturnsTrue() throws Exception {
        when(mockConn.prepareStatement(contains("INSERT INTO Bookings"), anyInt()))
                .thenReturn(mockStmtBooking);
        when(mockConn.prepareStatement(contains("INSERT INTO TicketDetails")))
                .thenReturn(mockStmtTicket);
        when(mockStmtBooking.getGeneratedKeys()).thenReturn(mockGeneratedKeys);
        when(mockGeneratedKeys.next()).thenReturn(true);
        when(mockGeneratedKeys.getInt(1)).thenReturn(42); // generated bookingId

        Booking b = new Booking();
        b.setUserId(1);
        b.setTotalAmount(1500000);

        boolean result = dao.createBooking(b, 1, 2, 750000);

        Assert.assertTrue(result);
        verify(mockConn).commit();
    }

    @Test
    public void testCreateBooking_NoGeneratedKey_ReturnsFalse() throws Exception {
        when(mockConn.prepareStatement(contains("INSERT INTO Bookings"), anyInt()))
                .thenReturn(mockStmtBooking);
        when(mockStmtBooking.getGeneratedKeys()).thenReturn(mockGeneratedKeys);
        when(mockGeneratedKeys.next()).thenReturn(false); // no key returned

        Booking b = new Booking();
        b.setUserId(1);
        b.setTotalAmount(1500000);

        boolean result = dao.createBooking(b, 1, 2, 750000);

        Assert.assertFalse(result);
        verify(mockConn).rollback();
    }

    @Test
    public void testCreateBooking_SQLExceptionOnInsert_ReturnsFalse() throws Exception {
        when(mockConn.prepareStatement(anyString(), anyInt()))
                .thenThrow(new SQLException("DB error"));

        Booking b = new Booking();
        b.setUserId(1);
        b.setTotalAmount(1500000);

        boolean result = dao.createBooking(b, 1, 2, 750000);

        Assert.assertFalse(result);
        verify(mockConn).rollback();
    }

    @Test
    public void testCreateBooking_SQLExceptionOnTicket_ReturnsFalse() throws Exception {
        when(mockConn.prepareStatement(contains("INSERT INTO Bookings"), anyInt()))
                .thenReturn(mockStmtBooking);
        when(mockConn.prepareStatement(contains("INSERT INTO TicketDetails")))
                .thenThrow(new SQLException("Ticket insert failed"));
        when(mockStmtBooking.getGeneratedKeys()).thenReturn(mockGeneratedKeys);
        when(mockGeneratedKeys.next()).thenReturn(true);
        when(mockGeneratedKeys.getInt(1)).thenReturn(42);

        Booking b = new Booking();
        b.setUserId(1);
        b.setTotalAmount(1500000);

        boolean result = dao.createBooking(b, 1, 2, 750000);

        Assert.assertFalse(result);
        verify(mockConn).rollback();
    }

    @Test
    public void testCreateBooking_ZeroQuantity_StillProcesses() throws Exception {
        when(mockConn.prepareStatement(contains("INSERT INTO Bookings"), anyInt()))
                .thenReturn(mockStmtBooking);
        when(mockConn.prepareStatement(contains("INSERT INTO TicketDetails")))
                .thenReturn(mockStmtTicket);
        when(mockStmtBooking.getGeneratedKeys()).thenReturn(mockGeneratedKeys);
        when(mockGeneratedKeys.next()).thenReturn(true);
        when(mockGeneratedKeys.getInt(1)).thenReturn(43);

        Booking b = new Booking();
        b.setUserId(1);
        b.setTotalAmount(0);

        boolean result = dao.createBooking(b, 1, 0, 0);

        // method doesn't validate quantity, so it still returns true
        Assert.assertTrue(result);
    }
}
