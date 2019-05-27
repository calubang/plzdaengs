package com.plzdaeng.member.controller;

import java.sql.*;

import com.plzdaeng.dto.UserDetailDto;
import com.plzdaeng.dto.UserDto;
import com.plzdaeng.util.DBClose;
import com.plzdaeng.util.DBConnection;

public class MemberDao {

	public void insert(UserDto userDto) {
		Connection con = null;
		
		try {
			con = DBConnection.makeConnection();
			con.setAutoCommit(false);
			insertUser(con, userDto);
			insertUserDetail(con, userDto);
		
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
		
	}
	
	private void insertUserDetail(Connection con, UserDto userDto) throws SQLException {
		PreparedStatement pstmt = null;
		StringBuffer inserUserDetailSQL = new StringBuffer();
		inserUserDetailSQL.append("insert into plz_user_detail(\n");
		inserUserDetailSQL.append("    user_id\n");
		inserUserDetailSQL.append("    , tel1\n");
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
		//전화번호 수정 필요
		pstmt.setString(++index, "");
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

}
