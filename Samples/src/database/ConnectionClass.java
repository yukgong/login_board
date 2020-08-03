package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConnectionClass {

	static public void initConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Driver Loading Success");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("Driver Loading Faile");
		}
	}

	static public Connection getConnection() {
		Connection conn = null;
		ConnectionClass.initConnection();

		String url = "jdbc:oracle:thin:@192.168.7.60:1521:xe";
		String name = "hr";
		String pw = "hr";

		try {
			conn = DriverManager.getConnection(url, name, pw);
			System.out.println("Driver Loading Success");

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}

	static public void close(Connection conn, PreparedStatement psmt, ResultSet rs) {
		try {
			if(conn != null) {
				conn.close();
			}
			if(psmt != null) {
				psmt.close();
			}
			if(rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

