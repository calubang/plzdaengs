package com.plzdaeng.member.model;

import java.io.File;

import org.apache.tomcat.jdbc.pool.ConnectionPool;

import com.plzdaeng.dto.UserDto;
import com.plzdaeng.member.controller.MemberDao;

public class MemberService {
	private MemberDao dao;
	
	public MemberService(){
		dao = new MemberDao();
	}
	
	public void memberJoin(UserDto userDto, File inputFile) {
		
		String authority = userDto.getAuthority();
		String userImg = userDto.getUser_img();
		
		//유저로 세팅
		if(authority == null) {
			userDto.setAuthority("U");
		}
		//등록한 파일이 없으면 기본 이미지 사용
		if(inputFile  == null) {
			userDto.setUser_img("/template/img/basic_user_profile.png");
		}
		//디비에 데이터 입력
		dao.insert(userDto);
		
	}
}
