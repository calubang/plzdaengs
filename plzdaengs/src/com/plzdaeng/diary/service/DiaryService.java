package com.plzdaeng.diary.service;

import com.plzdaeng.diary.dao.diaryDao;

public class DiaryService {
	private diaryDao dao;
	
	public DiaryService() {
		dao = new diaryDao();
	}
}
