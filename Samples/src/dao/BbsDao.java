package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import database.ConnectionClass;
import dto.BbsDto;

public class BbsDao {
	private static BbsDao dao = new BbsDao();
	
	public BbsDao() {
	}
	
	public static BbsDao getInstance() {
		return dao;
	}
	
	public List<BbsDto> getBbsList(){
		String sql = " SELECT SEQ, EMAIL, REF, STEP, DEPTH, "
				+ " TITLE, CONTENT, WDATE, "
				+ " DEL, READCOUNT "
				+ " FROM BBS "
				+ " ORDER BY REF DESC, STEP ASC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		List<BbsDto> list = new ArrayList<BbsDto>();
		
		try {
			conn = ConnectionClass.getConnection();
			System.out.println("1/6 success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 success");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 success");
			
			while(rs.next()) {
				int i = 1;
				BbsDto dto = new BbsDto(rs.getInt(i++), 	// seq
										rs.getString(i++), 	// email, 
										rs.getInt(i++), 	// ref, 
										rs.getInt(i++), 	// step, 
										rs.getInt(i++), 	// depth, 
										rs.getString(i++), 	// title, 
										rs.getString(i++), 	// content, 
										rs.getString(i++), 	// wdate, 
										rs.getInt(i++), 	// del, 
										rs.getInt(i++) 		// readcount
										);
				list.add(dto);
			}
			System.out.println("4/6 success");
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {
			ConnectionClass.close(conn, psmt, rs);
		}
		
		return list;
	}
	
	//TODO : insert
	public boolean writeBbs(BbsDto dto) {
		String sql = " INSERT INTO BBS "
				+ " (SEQ, EMAIL, REF, STEP, DEPTH, "
				+ " TITLE, CONTENT, WDATE, DEL, READCOUNT) "
				+ " VALUES( SEQ_BBS.NEXTVAL, ?, "
				+ " (SELECT NVL(MAX(REF), 0) + 1 FROM BBS ), 0, 0,"
				+ "	?, ?, SYSDATE, 0, 0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = ConnectionClass.getConnection();
			System.out.println("1/6 success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getEmail());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			System.out.println("2/6 success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 success");
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {
			ConnectionClass.close(conn, psmt, null);
		}
		return count > 0 ? true : false;
	}
	
	// TODO : Select Detail
	public BbsDto getDetail(int _seq){
		String sql = " SELECT SEQ, EMAIL, REF, STEP, DEPTH, "
				+ " TITLE, CONTENT, WDATE, "
				+ " DEL, READCOUNT "
				+ " FROM BBS "
				+ " WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		BbsDto dto = null;
		
		try {
			conn = ConnectionClass.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, _seq);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				dto = new BbsDto(rs.getInt("SEQ"), 		// seq
								rs.getString("EMAIL"), 	// email, 
								rs.getInt("REF"), 		// ref, 
								rs.getInt("STEP"), 		// step, 
								rs.getInt("DEPTH"), 	// depth, 
								rs.getString("TITLE"), 	// title, 
								rs.getString("CONTENT"), // content, 
								rs.getString("WDATE"), 	// wdate, 
								rs.getInt("DEL"), 		// del, 
								rs.getInt("READCOUNT") 	// readcount
								);
			}
			System.out.println("4/6 success");
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {
			ConnectionClass.close(conn, psmt, rs);
		}
		
		return dto;
	}
}
