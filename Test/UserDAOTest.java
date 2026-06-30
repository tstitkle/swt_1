
import org.junit.Test;
import org.junit.Before;
import org.junit.Assert;
import static org.mockito.Mockito.*;

import dal.UserDAO;
import model.User;

import java.sql.*;

public class UserDAOTest {

    private UserDAO dao;
    private Connection mockConn;
    private PreparedStatement mockStmt;
    private ResultSet mockRs;

    @Before
    public void setUp() throws Exception {
        mockConn = mock(Connection.class);
        mockStmt = mock(PreparedStatement.class);
        mockRs = mock(ResultSet.class);

        // stub close() so try-with-resources doesn't fail
        doNothing().when(mockStmt).close();
        doNothing().when(mockRs).close();

        dao = new UserDAO(mockConn);
    }

    @Test
    public void testLogin_ValidCredentials_ReturnsUser() throws Exception {
        when(mockConn.prepareStatement(anyString())).thenReturn(mockStmt);
        when(mockStmt.executeQuery()).thenReturn(mockRs);
        when(mockRs.next()).thenReturn(true);
        when(mockRs.getInt("UserId")).thenReturn(1);
        when(mockRs.getString("Username")).thenReturn("admin");
        when(mockRs.getString("FullName")).thenReturn("Administrator");
        when(mockRs.getString("Email")).thenReturn("admin@ticket.com");
        when(mockRs.getInt("RoleId")).thenReturn(1);
        when(mockRs.getBoolean("IsActive")).thenReturn(true);

        User result = dao.login("admin", "123");

        Assert.assertNotNull(result);
        Assert.assertEquals("admin", result.getUsername());
    }

    @Test
    public void testLogin_WrongCredentials_ReturnsNull() throws Exception {
        when(mockConn.prepareStatement(anyString())).thenReturn(mockStmt);
        when(mockStmt.executeQuery()).thenReturn(mockRs);
        when(mockRs.next()).thenReturn(false); // no user found

        User result = dao.login("admin", "wrongpass");

        Assert.assertNull(result);
    }

    @Test
    public void testLogin_EmptyUsername_ReturnsNull() throws Exception {
        when(mockConn.prepareStatement(anyString())).thenReturn(mockStmt);
        when(mockStmt.executeQuery()).thenReturn(mockRs);
        when(mockRs.next()).thenReturn(false);

        User result = dao.login("", "123");

        Assert.assertNull(result);
    }

    @Test
    public void testLogin_NullUsername_ReturnsNull() throws Exception {
        when(mockConn.prepareStatement(anyString())).thenReturn(mockStmt);
        when(mockStmt.executeQuery()).thenReturn(mockRs);
        when(mockRs.next()).thenReturn(false);

        User result = dao.login(null, "123");

        Assert.assertNull(result);
    }

    @Test
    public void testLogin_DBException_ReturnsNull() throws Exception {
        when(mockConn.prepareStatement(anyString())).thenThrow(new SQLException("DB error"));

        User result = dao.login("admin", "123");

        Assert.assertNull(result);
    }
}
