package com.plzdaeng.diary.service;

import java.util.List;

import com.plzdaeng.diary.dao.diaryDao;
import com.plzdaeng.dto.DiaryDto;
import com.plzdaeng.dto.UserDto;

public class DiaryService {
	private diaryDao dao;
	
	public DiaryService() {
		dao = new diaryDao();
	}

	public List<DiaryDto> initDataByMonth(String date, UserDto user) {
		return dao.selectAllByMonth(date, user);
	}
}
