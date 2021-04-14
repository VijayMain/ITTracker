package it.muthagroup.connectionUtility;

import java.sql.Connection;
import java.sql.DriverManager;

// Connection Model For Database Connection
public class Connection_Utility { 
	static Connection con = null; 
	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/complaintzilla", "root","root");  
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return con; // returns Connection 
	}
	public static Connection getLocalDatabase() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp_database", "root","root"); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	} 
}
