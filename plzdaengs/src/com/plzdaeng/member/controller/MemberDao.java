package com.plzdaeng.member.controller;

import java.sql.*;

import com.plzdaeng.dto.UserDto;
import com.plzdaeng.util.DBConnection;

public class MemberDao {

	public void insert(UserDto userDto) {
		Connection con = null;
		
		try {
			con = DBConnection.makeConnection();
			con.setAutoCommit(false);
			insertUser(con, userDto);
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
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
		
	}

}
