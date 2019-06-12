package com.plzdaeng.diary.service;

<<<<<<< HEAD
import java.util.Date;
=======
import java.util.List;
>>>>>>> refs/remotes/origin/master

import com.plzdaeng.diary.dao.diaryDao;
import com.plzdaeng.dto.DiaryDto;
<<<<<<< HEAD
=======
import com.plzdaeng.dto.UserDto;
>>>>>>> refs/remotes/origin/master

public class DiaryService {
	private diaryDao dao;
	Date date;
	
	public DiaryService() {
		dao = new diaryDao();
		date = new Date();
	}
	
	public int enrollDiary(DiaryDto dto) {
		System.out.println();
		System.out.println("★ DiaryService 이동OK");
		
		String id = dto.getUser_id();
		date = dto.getCreate_date();
		
		System.out.println("	> [Diary Servlet] 과연 userID는? : " + id);
		int result = -1;
		
		if(date == null) {
			System.out.println("	> NULL지옥 퐁당");
			dto.setCreate_date(new Date());
			System.out.println("	> 일단 가상으로 현재시간 넣기 : " + dto.getCreate_date());
			//System.out.println(dto);
		}
		
		result = dao.insertDiary(dto);
		
		System.out.println("	> DB에 등록 완료!!");
		System.out.println("★ DiaryService BYE");
		System.out.println();
		
		return result;
	}

	public List<DiaryDto> initDataByMonth(String date, UserDto user) {
		return dao.selectAllByMonth(date, user);
	}
}
