package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.ConnectionClass;
import dto.PdsDto;

public class PdsDao {
	private static PdsDao dao = new PdsDao();
	
	private PdsDao() {
	}
	
	public static PdsDao getInstance() {
		return dao;
	}
	
	public List<PdsDto> getPdsList(){
		String sql = " SELECT SEQ, EMAIL, TITLE, CONTENTS, FILENAME,  "
				+ " READCOUNT, DOWNCOUNT, REGDATE "
				+ " FROM PDS "
				+ " ORDER BY SEQ DESC ";
		
		Connection conn = ConnectionClass.getConnection();
		PreparedStatement psmt = null;
		ResultSet rs = null;
		List<PdsDto> list = new ArrayList<PdsDto>();
		
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				int i = 1;
				PdsDto dto = new PdsDto(rs.getInt(i++), //seq, 
										rs.getString(i++), // id, 
										rs.getString(i++),//title, 
										rs.getString(i++),//contents, 
										rs.getString(i++), //fileName, 
										rs.getInt(i++), //readcount, 
										rs.getInt(i++), //downcount, 
										rs.getString(i++)); //regdate);
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClass.close(conn, psmt, rs);
		}
		return list;
	}
	
	public boolean writePds(PdsDto pds) {
		String sql = " INSERT INTO PDS( SEQ, EMAIL, TITLE, CONTENTS, FILENAME, "
				+ " READCOUNT, DOWNCOUNT, REGDATE ) "
				+ " VALUES( SEQ_PDS.NEXTVAL, ?, ?, ?, ?, "
				+ " 0, 0, SYSDATE ) ";
		
		System.out.println(pds.getEmail());
		System.out.println(pds.getTitle());
		System.out.println(pds.getContents());
		
		Connection conn = ConnectionClass.getConnection();
		PreparedStatement psmt = null;
		
		int count = 0; 
		
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, pds.getEmail());
			psmt.setString(2, pds.getTitle());
			psmt.setString(3, pds.getContents());
			psmt.setString(4, pds.getFileName());
			
			count = psmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClass.close(conn, psmt, null);
		}
		return count > 0 ? true : false;
	}
}
