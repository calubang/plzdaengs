package com.plzdaeng.user.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.plzdaeng.dto.BreedDto;
import com.plzdaeng.dto.PetDto;
import com.plzdaeng.dto.TakeVaccinDto;
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

	public int insert(PetDto pet) {
		Connection conn = null;
		int result = -1;
		
		try {
			conn = DBConnection.makeConnection();
			conn.setAutoCommit(false);
			insertPet(conn, pet);
			insertTakeVaccin(conn, pet);
			
			conn.commit();
			result = 1;
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			DBClose.close(conn, null);
		}
		
		return result;
	}

	private void insertTakeVaccin(Connection conn, PetDto pet) throws SQLException {
		List<TakeVaccinDto> list = pet.getTakeVaccinList();
		PreparedStatement pstmt = null;
		String insertTakeVaccinSQL = 
				"insert into plz_takevaccin(	\r\n" + 
				"    user_id	\r\n" + 
				"    , pet_name	\r\n" + 
				"    , vaccin_code	\r\n" + 
				"    , take_vaccin_date	\r\n" + 
				")values(	\r\n" + 
				"    ?	\r\n" + 
				"    , ?	\r\n" + 
				"    , ?	\r\n" + 
				"    , to_date(?, 'YYYY/MM/DD')\r\n" + 
				")";
		
		pstmt = conn.prepareStatement(insertTakeVaccinSQL);
		for(TakeVaccinDto take : list) {
			int index = 0;
			pstmt.setString(++index, pet.getUserDto().getUser_id());
			pstmt.setString(++index, pet.getPet_name());
			pstmt.setString(++index, take.getVaccinationDto().getVaccin_code());
			pstmt.setString(++index, take.getTakeVaccinDate());
			
			pstmt.executeUpdate();
		}
	}

	private void insertPet(Connection conn, PetDto pet) throws SQLException {
		PreparedStatement pstmt = null;
		String insertPetSQL = 
				"insert into plz_pet(	\r\n" + 
				"    user_id	\r\n" + 
				"    , pet_name	\r\n" + 
				"    , animal_code	\r\n" + 
				"    , breed_code	\r\n" + 
				"    , pet_gender	\r\n" + 
				"    , birth_date	\r\n" + 
				"    , pet_type	\r\n" + 
				"    , pet_img	\r\n" + 
				")values(	\r\n" + 
				"    ?	\r\n" + 
				"    , ?	\r\n" + 
				"    , ?	\r\n" + 
				"    , ?	\r\n" + 
				"    , ?	\r\n" + 
				"    , to_date(?, 'YYYY/MM/DD')\r\n" + 
				"    , ?	\r\n" + 
				"    , ?	\r\n" + 
				")";
		
		pstmt = conn.prepareStatement(insertPetSQL);
		int index = 0;
		pstmt.setString(++index, pet.getUserDto().getUser_id());
		pstmt.setString(++index, pet.getPet_name());
		pstmt.setString(++index, pet.getBreedDto().getAnimalDto().getAnimal_code());
		pstmt.setString(++index, pet.getBreedDto().getBreed_code());
		pstmt.setString(++index, pet.getPet_gender());
		pstmt.setString(++index, pet.getBirth_date());
		pstmt.setString(++index, pet.getPet_type());
		pstmt.setString(++index, pet.getPet_img());
		pstmt.executeUpdate();
	}

}
