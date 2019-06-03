package com.plzdaeng.user.service;

import com.plzdaeng.user.dao.PetDao;

public class PetService {
	private PetDao dao;
	
	public void PetService() {
		dao = new PetDao();
	}
	
	public int petNameCheck(String petName, String userId) {
		return dao.selectByPetName(petName, userId);
	}

}
