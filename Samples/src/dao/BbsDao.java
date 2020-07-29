package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;
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
			
			psmt = conn.prepareStatement(sql);
			
			rs = psmt.executeQuery();
			
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
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getEmail());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			
			count = psmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {
			ConnectionClass.close(conn, psmt, null);
		}
		return count > 0 ? true : false;
	}
	
	// TODO : Select Detail
	public BbsDto getBbs(int _seq){
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
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {
			ConnectionClass.close(conn, psmt, rs);
		}
		
		return dto;
	}
	public void readCount(int _seq) {
		String sql = " UPDATE BBS "
				+ " SET READCOUNT = NVL(READCOUNT, 0) + 1 "
				+ " WHERE SEQ = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
			conn = ConnectionClass.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, _seq);		
			psmt.executeUpdate(); // 업데이트
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {
			ConnectionClass.close(conn, psmt, null);
		}
	}
	
	// TO DO : 답변 추가하기 -> 댓글의 핵심 쿼리
	public boolean answer(int seq, BbsDto bbs) {
		// update
		// 스텝의 값만 늘려주기
		String sqlToUpdate = " UPDATE BBS "
							+ " SET STEP = STEP + 1 "
							+ " WHERE REF = ( SELECT REF FROM BBS WHERE SEQ = ? ) "  // 현재 시퀀스 번호와 동일한 놈들이면서, 
							+ " AND STEP > ( SELECT STEP FROM BBS WHERE SEQ = ? ) " ;  // 현재 STEP 번호보다 큰 놈들을 선택해서 STEP을 늘려라. 
		
		// insert
		String sqlToInsert = " INSERT INTO BBS "	// 추가 하는 쿼리문 시작
							+ " (SEQ, EMAIL, "		// 추가할 요소들
							+ " REF, STEP, DEPTH, "
							+ " TITLE, CONTENT, WDATE, DEL, READCOUNT ) " 
							+ " VALUES	(SEQ_BBS.NEXTVAL, ?, "	// 추가할 값 영역
							+ " 		(SELECT REF FROM BBS WHERE SEQ = ? ), "	// 현재 SEQ와 동일한 SEQ를 기준으로  REF 요소 선택 -> 대입
							+ " 		(SELECT STEP FROM BBS WHERE SEQ = ? ) + 1, " // 현재 SEQ와 동일한 SEQ 기준으로 STEP 요소 선택 -> 대입
							+ "			(SELECT DEPTH FROM BBS WHERE SEQ = ?) + 1, " // 현재 SEQ와 동일한 SEQ 기준으로 DEPTH 요소 선택 -> 대입
							+ "			?, ?, SYSDATE, 0, 0 )";

	
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = ConnectionClass.getConnection();
			conn.setAutoCommit(false);
			
			// update
			psmt = conn.prepareStatement(sqlToUpdate);
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			
			count = psmt.executeUpdate();
			
			// update 후 insert를 위해 psmt 초기화 필요함!
			psmt.clearParameters(); // 초기화
			
			// insert
			psmt = conn.prepareStatement(sqlToInsert);
			psmt.setString(1, bbs.getEmail());
			psmt.setInt(2, seq);
			psmt.setInt(3, seq);
			psmt.setInt(4, seq);
			psmt.setString(5, bbs.getTitle());
			psmt.setString(6, bbs.getContent());
			
			count = psmt.executeUpdate();
			
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			ConnectionClass.close(conn, psmt, null);
		}
		
		return count > 0 ? true : false;
	}
	
	//TODO : Delete 
	public boolean bbsDelete(int seq) {
		//select
		// 삭제 버튼이 눌러진 위치 파악을 위해 step 번호 불러오기
		// step 0번이 지워지면 관련 댓글을 한번에 삭제하기 위해
		// 지워지는 대상 글의 REF 번호도 함께 불러온다.
		String sqlSelect = " SELECT REF, STEP "
							+ " FROM BBS "
							+ " WHERE SEQ = ? ";
		
		
		// updateAll
		// step 0번 이면 같은 REF를 가진 요소를 전체 삭제한다.
		String sqlAllUpdate = " UPDATE BBS "
							+ " SET DEL = 1 "
							+ " WHERE REF = ?";
		
		String sqlDelete = " DELETE FROM BBS "
							+ " WHERE STEP > 0 AND DEL = 1 AND REF = ?";

		// update
		// step 0이 아니면 삭제 대상만 지우기
		String sqlUpdate = " UPDATE BBS "
							+ " SET DEL = 1 "
							+ " WHERE SEQ = ?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		BbsDto dto = null;
		int refValue = -1; // REF의 숫자
		int stepValue = -1; // STEP의 숫자
		int count = 0;
		
		try {
			conn = ConnectionClass.getConnection();
			conn.setAutoCommit(false);
			
			// Select
			psmt = conn.prepareStatement(sqlSelect);
			psmt.setInt(1, seq);			
			rs = psmt.executeQuery();			
			
			while(rs.next()) {
				refValue = rs.getInt("REF"); // Select을 통해 REF의 숫자 얻어오기 
				stepValue = rs.getInt("STEP"); // Select을 통해 STEP의 숫자 얻어오기 
			}
			psmt.clearParameters(); // 초기화
			
			// UpdateAll
			if(stepValue == 0) {
				psmt = conn.prepareStatement(sqlAllUpdate);
				psmt.setInt(1, refValue);
				count = psmt.executeUpdate();
				System.out.println("sqlAllUpdate : " + count);
				
				psmt.clearParameters(); // 초기화
				psmt = conn.prepareStatement(sqlDelete);
				psmt.setInt(1, refValue);
				count = psmt.executeUpdate();
				System.out.println("sqlDelete : " + count);
			
			// Update
			} else if (stepValue > 0){
				psmt = conn.prepareStatement(sqlUpdate);
				psmt.setInt(1, seq);
				count = psmt.executeUpdate();
				System.out.println("sqlUpdate : " + count);
			}
			
			conn.commit(); // Select, Update 수행 완료 후 커밋 진행
			
		} catch (SQLException e) {
			try {
				conn.rollback(); // 실패시 롤백
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			
		} finally {
			try {
				conn.setAutoCommit(true); // 완료되면, 자동 커밋 기능 복원
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			ConnectionClass.close(conn, psmt, rs);
		}
		
		return count > 0 ? true : false;
	}
	
	public List<BbsDto> bbsSearch(String searchingText, String category) {
		String strArr[] = searchingText.split(" ");
		System.out.println(strArr.length);
		
		String sql = " SELECT * FROM BBS "
					+ " WHERE " + category + " "
					+ " LIKE '%' || '" + strArr[0] + "' || '%' ";
		
		if(strArr.length > 1) {
			for (int i = 1; i < strArr.length; i++) {
				sql += " OR " + category + " LIKE '%' || '" + strArr[i] + "' || '%' ";
			}
		}
		
		sql += " ORDER BY REF DESC, STEP ASC ";
		
		System.out.println(sql);
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		List<BbsDto> list = new LinkedList<BbsDto>();
		
		
		// Select
		try {
			conn = ConnectionClass.getConnection();
			psmt = conn.prepareStatement(sql);
			
			rs = psmt.executeQuery();
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
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClass.close(conn, psmt, rs);
		}
		
		return list;
	}
}
