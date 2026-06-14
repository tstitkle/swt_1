package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Review;

public class ReviewDAO extends DBContext {
    public List<Review> getReviewsByEventId(int eventId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT * FROM Reviews WHERE EventId = ? ORDER BY ReviewDate DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, eventId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Review r = new Review();
                r.setReviewId(rs.getInt("ReviewId"));
                r.setUserId(rs.getInt("UserId"));
                r.setEventId(rs.getInt("EventId"));
                r.setRating(rs.getInt("Rating"));
                r.setComment(rs.getString("Comment"));
                r.setReviewDate(rs.getTimestamp("ReviewDate"));
                list.add(r);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
