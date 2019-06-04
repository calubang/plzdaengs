package com.plzdaeng.user.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.plzdaeng.dto.UserDetailDto;
import com.plzdaeng.dto.UserDto;
import com.plzdaeng.user.service.UserService;
import com.plzdaeng.util.*;

@WebServlet("/userupdate")
public class UserUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService service;
	
	public UserUpdateServlet() {
		service = new UserService();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("userupdate : ");
		response.getWriter().append("Served at: ").append(request.getContextPath());
		UserDto user = (UserDto)request.getSession().getAttribute("userInfo");
		//System.out.println("기존 데이터 : "+user);
		
		//String saveDirectory = request.getServletContext().getRealPath("\\img\\user");
		String saveDirectory = SiteConstance.IMG_PATH;
		
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, "utf-8");
		
		String id = mr.getParameter("id");
		String password = mr.getParameter("password");
		String emailid = mr.getParameter("emailid");
		String emaildomain = mr.getParameter("emaildomain");
		String nickname = mr.getParameter("nickname");
		String tel = mr.getParameter("tel");
		String gender = mr.getParameter("gender");
		String zipcode = mr.getParameter("zipcode");
		String address = mr.getParameter("address");
		String addressdetail = mr.getParameter("addressdetail");
		
		UserDto userDto = new UserDto();
		userDto.setUser_id(id);
		userDto.setPassword(password);
		userDto.setEmailid(emailid);
		userDto.setEmaildomain(emaildomain);
		userDto.setNickname(nickname);
		
		//상세정보
		UserDetailDto userDetailDto = new UserDetailDto();
		userDto.setUserDetailDto(userDetailDto);
		userDetailDto.setTel(tel);
		userDetailDto.setGender(gender);
		userDetailDto.setZipcode(zipcode);
		userDetailDto.setAddress(address);
		userDetailDto.setAddress_detail(addressdetail);
				
		//등록한 파일이 없으면 기본 이미지 사용
		File profileFile = mr.getFile("imgdata");
		
		if(profileFile  == null) {
			userDto.setUser_img(user.getUser_img());
		}else {
			userDto.setUser_img("/plzdaengs/img/user/"+userDto.getUser_id()+"/user_profile.jpg");
			String path = request.getServletContext().getRealPath("/img");
			//System.out.println(path);
			ProfileCreate.profileRegister(profileFile, path , userDto.getUser_id() , "user");
		}
		//프로필 등록시작
		int result = service.userUpdate(userDto);
		if(result == 1) {
			//세션 변경
			request.getSession().removeAttribute("userInfo");
			request.getSession().setAttribute("userInfo", userDto);
		}
		
		request.setAttribute("userupdateresult", result);
		MoveUrl.forward(request, response, "/user/result/userupdateresult.jsp");
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);		
	}

}