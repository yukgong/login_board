package dao;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.ConnectionClass;
import dto.MemberDto;

public class MemberDao {
	private static MemberDao dao = new MemberDao();
	
	private MemberDao(){
		ConnectionClass.initConnection();
	}
	
	public static MemberDao getInstance() {
		return dao;
	}
	
	// TODO : 회원가입
	// TODO : ID 확인하기
	public boolean getId(String _email) {
		// 들어온 아이디를 확인해서 -> 있으면 true / 아니면 false
		String sql = " SELECT EMAIL "
				+ " FROM MEMBER "
				+ " WHERE EMAIL = '" + _email + "' ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int count = 0;
		
		try {
			conn = ConnectionClass.getConnection();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if (rs.next()) { // id가 있다면
				count++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClass.close(conn, psmt, rs);
		}
		return count > 0 ? true : false;
	}
	
	// TODO : 멤버 insert
	public boolean addMember(MemberDto dto) {
		// 회원가입의 데이터를  -> DB에 넣어주기
		String sql = " INSERT INTO MEMBER ( EMAIL, PWD, NAME, AUTH ) "
				+ " VALUES(?, ?, ?, ?) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;
		
		try {
			conn = ConnectionClass.getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getEmail());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getAuth());
			
			count = psmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClass.close(conn, psmt, null);
		}

		return count > 0 ? true : false;
	}
	
	// TODO : 멤버 Select
	public MemberDto selectMember(String _email) {
		String sql = " SELECT EMAIL, PWD, NAME "
				+ " FROM MEMBER "
				+ " WHERE EMAIL = '" + _email + "' ";
	
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		MemberDto dto = null;
	
		try {
			conn = ConnectionClass.getConnection();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				String email = rs.getString("EMAIL");
				String pwd = rs.getString("PWD");
				String name = rs.getString("NAME");
				String auth = "3";
				
				dto = new MemberDto(email, null, name, auth);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionClass.close(conn, psmt, rs);
		}
		return dto;
	}	
	
	// TODO : ID & 비밀번호 확인하기
		public MemberDto login(String _email, String _pwd) {
			// 들어온 아이디를 확인해서 -> 있으면 true / 아니면 false
			String sql = " SELECT EMAIL, PWD, NAME, AUTH "
					+ " FROM MEMBER "
					+ " WHERE EMAIL = ? AND PWD = ? ";
			
			Connection conn = null;
			PreparedStatement psmt = null;
			ResultSet rs = null;
			MemberDto dto = null;
			
			
			try {
				conn = ConnectionClass.getConnection();
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, _email);
				psmt.setString(2, _pwd);
				
				rs = psmt.executeQuery();
				
				if (rs.next()) { // id가 있다면
					String email = rs.getString("EMAIL");
					System.out.println("DB email : " + email);
					String pwd = rs.getString("PWD");
					System.out.println("DB pwd : " + pwd);
					String name = rs.getString("NAME");
					String auth = rs.getString("AUTH");
					
					dto = new MemberDto(email, pwd, name, auth);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			
			return dto;
		}
		
}
