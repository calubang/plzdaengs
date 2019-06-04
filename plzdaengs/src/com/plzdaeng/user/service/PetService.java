package com.plzdaeng.user.service;

import java.util.List;

import com.plzdaeng.dto.BreedDto;
import com.plzdaeng.user.dao.PetDao;

public class PetService {
	private PetDao dao;
	
	public PetService() {
		dao = new PetDao();
	}
	
	public int petNameCheck(String petName, String userId) {
		return dao.selectByPetName(petName, userId);
	}

	public List<BreedDto> selectKind(String name, String animalCode) {
		
		return dao.selectKindByName(name, animalCode);
	}

}
