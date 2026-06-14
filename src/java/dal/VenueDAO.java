package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Venue;

public class VenueDAO extends DBContext {
    public Venue getVenueById(int id) {
        String sql = "SELECT * FROM Venues WHERE VenueId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Venue v = new Venue();
                v.setVenueId(rs.getInt("VenueId"));
                v.setVenueName(rs.getString("VenueName"));
                v.setAddress(rs.getString("Address"));
                v.setCapacity(rs.getInt("Capacity"));
                return v;
            }
        } catch (SQLException ex) {
            Logger.getLogger(VenueDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<Venue> getAllVenues() {
        List<Venue> list = new ArrayList<>();
        String sql = "SELECT * FROM Venues";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Venue v = new Venue();
                v.setVenueId(rs.getInt("VenueId"));
                v.setVenueName(rs.getString("VenueName"));
                v.setAddress(rs.getString("Address"));
                v.setCapacity(rs.getInt("Capacity"));
                list.add(v);
            }
        } catch (SQLException ex) {
            Logger.getLogger(VenueDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public void addVenue(Venue v) {
        String sql = "INSERT INTO Venues (VenueName, Address, Capacity) VALUES (?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, v.getVenueName());
            st.setString(2, v.getAddress());
            st.setInt(3, v.getCapacity());
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(VenueDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateVenue(Venue v) {
        String sql = "UPDATE Venues SET VenueName = ?, Address = ?, Capacity = ? WHERE VenueId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, v.getVenueName());
            st.setString(2, v.getAddress());
            st.setInt(3, v.getCapacity());
            st.setInt(4, v.getVenueId());
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(VenueDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteVenue(int venueId) {
        String sql = "DELETE FROM Venues WHERE VenueId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, venueId);
            st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(VenueDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
