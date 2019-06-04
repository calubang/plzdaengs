package com.plzdaeng.user.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.plzdaeng.dto.BreedDto;
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

	public List<BreedDto> selectKindByName(String name, String animalCode) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BreedDto> list = new ArrayList<BreedDto>();
		String selectKindByNameSQL = 
				"select \r\n" + 
				"    animal_code\r\n" + 
				"    , breed_code\r\n" + 
				"    , breed_name\r\n" + 
				"from plz_breed\r\n" + 
				"where \r\n" + 
				"    animal_code = ? 	\r\n" + 
				"    and breed_name like '%' || ? || '%'";
		
		try {
			conn = DBConnection.makeConnection();
			pstmt = conn.prepareStatement(selectKindByNameSQL);
			int index = 0;
			pstmt.setString(++index, animalCode);
			pstmt.setString(++index, name);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BreedDto breed = new BreedDto();
				breed.setBreed_code(rs.getString("breed_code"));
				breed.setBreed_name(rs.getString("breed_name"));
				list.add(breed);
			}
			
			//System.out.println(list.size());
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}
		
		return list;
	}

}
