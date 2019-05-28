package com.plzdaeng.user.dao;

import java.sql.*;

import com.plzdaeng.dto.UserDetailDto;
import com.plzdaeng.dto.UserDto;
import com.plzdaeng.util.DBClose;
import com.plzdaeng.util.DBConnection;

import sun.nio.ch.SelChImpl;

public class UserDao {

	public int insert(UserDto userDto) {
		Connection con = null;
		int result = -1;
		try {
			con = DBConnection.makeConnection();
			con.setAutoCommit(false);
			insertUser(con, userDto);
			insertUserDetail(con, userDto);
			result = 1;
		
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				con.commit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBClose.close(con, null);
		}
		return result;
	}
	
	private void insertUserDetail(Connection con, UserDto userDto) throws SQLException {
		PreparedStatement pstmt = null;
		StringBuffer inserUserDetailSQL = new StringBuffer();
		inserUserDetailSQL.append("insert into plz_user_detail(\n");
		inserUserDetailSQL.append("    user_id\n");
		inserUserDetailSQL.append("    , tel\n");
		inserUserDetailSQL.append("    , gender\n");
		inserUserDetailSQL.append("    , zipcode\n");
		inserUserDetailSQL.append("    , address\n");
		inserUserDetailSQL.append("    , address_detail\n");
		inserUserDetailSQL.append(")values(\n");
		inserUserDetailSQL.append("    ?\n");
		inserUserDetailSQL.append("    , ?\n");
		inserUserDetailSQL.append("    , ?\n");
		inserUserDetailSQL.append("    , ?\n");
		inserUserDetailSQL.append("    , ?\n");
		inserUserDetailSQL.append("    , ?\n");
		inserUserDetailSQL.append(")\n");
		
		pstmt = con.prepareStatement(inserUserDetailSQL.toString());
		int index = 0;
		UserDetailDto userDetailDto = userDto.getUserDetailDto();
		pstmt.setString(++index, userDto.getUser_id());
		pstmt.setString(++index, userDetailDto.getTel());
		pstmt.setString(++index, userDetailDto.getGender());
		pstmt.setString(++index, userDetailDto.getZipcode());
		pstmt.setString(++index, userDetailDto.getAddress());
		pstmt.setString(++index, userDetailDto.getAddress_detail());
		
		pstmt.executeUpdate();
		
		DBClose.close(null, pstmt);
		
	}

	public void insertUser(Connection con, UserDto userDto) throws SQLException {
		PreparedStatement pstmt = null;
			
		StringBuffer insertUserSQL = new StringBuffer();
		insertUserSQL.append("insert into plz_user(\n");
		insertUserSQL.append("    user_id\n");
		insertUserSQL.append("    , password\n");
		insertUserSQL.append("    , authority\n");
		insertUserSQL.append("    , emailid\n");
		insertUserSQL.append("    , emaildomain\n");
		insertUserSQL.append("    , nickname\n");
		insertUserSQL.append("    , user_img\n");
		insertUserSQL.append(")values(\n");
		insertUserSQL.append("    ?\n");
		insertUserSQL.append("    , ?\n");
		insertUserSQL.append("    , ?\n");
		insertUserSQL.append("    , ?\n");
		insertUserSQL.append("    , ?\n");
		insertUserSQL.append("    , ?\n");
		insertUserSQL.append("    , ?\n");
		insertUserSQL.append(")\n");
		
		pstmt = con.prepareStatement(insertUserSQL.toString());
		int index = 0;
		pstmt.setString(++index, userDto.getUser_id());
		pstmt.setString(++index, userDto.getPassword());
		pstmt.setString(++index, userDto.getAuthority());
		pstmt.setString(++index, userDto.getEmail());
		pstmt.setString(++index, userDto.getEmaildomain());
		pstmt.setString(++index, userDto.getNickname());
		pstmt.setString(++index, userDto.getUser_img());
		
		pstmt.executeUpdate();
		
		DBClose.close(null, pstmt);
	}
	
	//id체크용
	public int selectById(String id) {
		int result = 1;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String selectByIdSQL = 
				"select count(user_id) count\r\n" + 
				"from plz_user\r\n" + 
				"where \r\n" + 
				"    user_id = ?";
		
		try {
			con = DBConnection.makeConnection();
			pstmt = con.prepareStatement(selectByIdSQL);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			rs.next();
			result = rs.getInt("count");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return result;
	}
	
	//로그인용
	public UserDto selectById(UserDto userDto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserDto loginUser = null;
		String selectByIdSQL = 
				"select \r\n" + 
				"    user_id\r\n" + 
				"    , password\r\n" + 
				"    , emailid\r\n" + 
				"    , emaildomain\r\n" + 
				"    , nickname\r\n" + 
				"    , user_img\r\n" + 
				"from plz_user\r\n" + 
				"where \r\n" + 
				"    user_id = ?\r\n" + 
				"    and password = ?";
		
		try {
			conn = DBConnection.makeConnection();
			pstmt = conn.prepareStatement(selectByIdSQL);
			int index = 0;
			pstmt.setString(++index, userDto.getUser_id());
			pstmt.setString(++index, userDto.getPassword());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				loginUser = new UserDto();
				loginUser.setUser_id(rs.getString("user_id"));
				loginUser.setPassword(rs.getString("password"));
				loginUser.setEmail(rs.getString("emailid"));
				loginUser.setEmaildomain(rs.getString("emaildomain"));
				loginUser.setNickname(rs.getString("nickname"));
				loginUser.setUser_img(rs.getString("user_img"));
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}
		
		return loginUser;
	}

}
