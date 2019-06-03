package com.plzdaeng.user.dao;

import java.sql.*;

import com.plzdaeng.util.DBClose;
import com.plzdaeng.util.DBConnection;

public class PetDao {

	public int selectByPetName(String petName, String userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = -1;
		String selectByPetNameSQL = 
				"select count(pet_name) count\r\n" + 
				"from plz_pet\r\n" + 
				"where \r\n" + 
				"    user_id = ? 	\r\n" + 
				"    and pet_name = ?	";
		
		try {
			conn = DBConnection.makeConnection();
			pstmt = conn.prepareStatement(selectByPetNameSQL);
			int index = 0;
			pstmt.setString(++index, userId);
			pstmt.setString(++index, petName);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("count");
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}
		return result;
	}

}
