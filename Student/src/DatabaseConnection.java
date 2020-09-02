import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Sourabh
 */
public class DatabaseConnection {
//    final static String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    final static String JDBC_DRIVER = "org.sqlite.JDBC";
//    final static String DB_URL = "jdbc:mysql://localhost:3306/student?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
    final static String DB_URL = "jdbc:sqlite:SRS_Project.sqlite";
    //SQLite no need username and password to connect with database.
//    final static String USERNAME = "root";
//    final static String PASSWORD = "";
    
    public static Connection connection() {
        try {
            Class.forName(JDBC_DRIVER);
//            Connection conn = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);//MYSQL DATABASE
            Connection conn = DriverManager.getConnection(DB_URL);//SQLite DATABASE
            return conn;
        }
        catch(ClassNotFoundException | SQLException ex){
            JOptionPane.showMessageDialog(null, ex.getMessage());
        }
        return null;
    }    
}
