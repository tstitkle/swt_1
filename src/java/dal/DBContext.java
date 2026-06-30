package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {

    public Connection connection;

    public DBContext() {
        try {
            String user = "sa";
            String pass = "123";
            String url = "jdbc:sqlserver://localhost:1433;databaseName=TicketSystemDB;encrypt=false";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE,
                    "DATABASE CONNECTION FAILED. Check: "
                    + "(1) SQL Server is running on localhost:1433, "
                    + "(2) database 'TicketSystemDB' exists, "
                    + "(3) login 'sa' with password '123' is enabled, "
                    + "(4) SQL Server Authentication mode is enabled.", ex);
            throw new RuntimeException(
                    "Cannot connect to database. Please check SQL Server is running and credentials are correct. "
                    + "Details: " + ex.getMessage(), ex);
        }
    }

    protected DBContext(Connection conn) {
        this.connection = conn;
    }
}
