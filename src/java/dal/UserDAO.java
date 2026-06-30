package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

public class UserDAO extends DBContext {

    public UserDAO() {
        super(); // calls the real DB connection constructor
    }

    public UserDAO(Connection conn) {
        super(conn);
    }

    public User login(String user, String pass) {
        String sql = "SELECT * FROM Users WHERE Username = ? AND Password = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, user);
            st.setString(2, pass);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setUserId(rs.getInt("UserId"));
                    u.setUsername(rs.getString("Username"));
                    u.setFullName(rs.getString("FullName"));
                    u.setEmail(rs.getString("Email"));
                    u.setRoleId(rs.getInt("RoleId"));
                    u.setActive(rs.getBoolean("IsActive"));
                    return u;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void updateUser(User u) {
        String sql = "UPDATE Users SET FullName = ?, Email = ? WHERE UserId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, u.getFullName());
            st.setString(2, u.getEmail());
            st.setInt(3, u.getUserId());
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public User getUserById(int id) {
        String sql = "SELECT * FROM Users WHERE UserId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setUserId(rs.getInt("UserId"));
                    u.setUsername(rs.getString("Username"));
                    u.setFullName(rs.getString("FullName"));
                    u.setEmail(rs.getString("Email"));
                    u.setRoleId(rs.getInt("RoleId"));
                    u.setActive(rs.getBoolean("IsActive"));
                    return u;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean register(String username, String password, String fullName, String email) {
        String sql = "INSERT INTO Users (Username, Password, FullName, Email, RoleId, IsActive) VALUES (?, ?, ?, ?, 2, 1)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            st.setString(2, password);
            st.setString(3, fullName);
            st.setString(4, email);
            int rows = st.executeUpdate();
            return rows > 0;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean checkExists(String username) {
        String sql = "SELECT * FROM Users WHERE Username = ?";
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            st.setString(1, username);
            return rs.next();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM Users";
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT UserId, Username, FullName, Email, RoleId, IsActive FROM Users ORDER BY UserId DESC";
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("UserId"));
                u.setUsername(rs.getString("Username"));
                u.setFullName(rs.getString("FullName"));
                u.setEmail(rs.getString("Email"));
                u.setRoleId(rs.getInt("RoleId"));
                u.setActive(rs.getBoolean("IsActive"));
                users.add(u);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return users;
    }

    public void addUser(User u) {
        String sql = "INSERT INTO Users (Username, Password, FullName, Email, RoleId, IsActive) VALUES (?, ?, ?, ?, ?, 1)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, u.getUsername());
            st.setString(2, u.getPassword());
            st.setString(3, u.getFullName());
            st.setString(4, u.getEmail());
            st.setInt(5, u.getRoleId());
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateUserByAdmin(User u) {
        String sql = "UPDATE Users SET FullName = ?, Email = ?, RoleId = ? WHERE UserId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, u.getFullName());
            st.setString(2, u.getEmail());
            st.setInt(3, u.getRoleId());
            st.setInt(4, u.getUserId());
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void setUserActive(int userId, boolean active) {
        String sql = "UPDATE Users SET IsActive = ? WHERE UserId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setBoolean(1, active);
            st.setInt(2, userId);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
