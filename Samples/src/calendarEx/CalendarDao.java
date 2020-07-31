package calendarEx;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.ConnectionClass;

public class CalendarDao {
	static private CalendarDao dao = new CalendarDao();
	
	
	private  CalendarDao() {
		ConnectionClass.initConnection();
	}
	
	static public CalendarDao getInstance(){
		return dao;
	}
	
	public List<CalendarDto> getCalendarList(String email, String yyyyMM){
		String sql = " SELECT SEQ, EMAIL, TITLE, CONTENT, RDATE, WDATE " + 
				" FROM ( " + 
				" SELECT ROW_NUMBER()OVER(PARTITION BY SUBSTR(RDATE, 1, 8)" + 
				" ORDER BY RDATE ASC) AS RNUM, " + 
				" SEQ, EMAIL, TITLE, CONTENT, RDATE, WDATE " + 
				" FROM CALENDAR " + 
				" WHERE EMAIL = ? " + 
				" AND SUBSTR(RDATE, 1, 6) = ? ) " + 
				" WHERE RNUM BETWEEN 1 AND 5 ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		try {
			conn = ConnectionClass.getConnection();
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);
			psmt.setString(2, yyyyMM);
			
			rs = psmt.executeQuery();
			
			while(rs.next()){
				int i = 1; 
				CalendarDto dto = new CalendarDto(	rs.getInt(i++), 	// seq
													rs.getString(i++), 	// email, 
													rs.getString(i++),	// title, 
													rs.getString(i++),	// content, 
													rs.getString(i++), 	// rdate, 
													rs.getString(i++) );// wdate
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClass.close(conn, psmt, rs);
		}
		return list;
	}
	
	public boolean addcalendar(CalendarDto cal) {
		String sql = " INSERT INTO CALENDAR(SEQ, EMAIL, TITLE, CONTENT, RDATE, WDATE) "
				+ " VALUES(SEQ_CAL.NEXTVAL, ?, ?, ?, ?, SYSDATE) ";
		
		System.out.println("1");
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0; 
		
		try {
			conn = ConnectionClass.getConnection();
			System.out.println("2");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, cal.getEmail());
			psmt.setString(2, cal.getTitle());
			psmt.setString(3, cal.getContent());
			psmt.setString(4, cal.getRdate());
			System.out.println("3");
			
			count = psmt.executeUpdate();
			System.out.println("4");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionClass.close(conn, psmt, null);
		}
		
		return count > 0 ? true : false;
	}
	
}
