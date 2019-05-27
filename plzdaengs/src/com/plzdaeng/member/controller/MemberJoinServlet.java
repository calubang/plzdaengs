package com.plzdaeng.member.controller;

import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.plaf.metal.MetalIconFactory.FolderIcon16;

import com.oreilly.servlet.MultipartRequest;
import com.plzdaeng.dto.UserDetailDto;
import com.plzdaeng.dto.UserDto;
import com.plzdaeng.member.model.MemberService;
import com.plzdaeng.util.ProfileCreate;
import com.plzdaeng.util.SiteConstance;

@WebServlet("/memberjoin")
public class MemberJoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService service;
       
    public MemberJoinServlet() {
        super();
        service = new MemberService();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("memberjoin");
	
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
		userDto.setEmail(emailid);
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
		
		System.out.println(userDto);
		
		service.memberJoin(userDto, mr.getFile("imgdata"));
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
