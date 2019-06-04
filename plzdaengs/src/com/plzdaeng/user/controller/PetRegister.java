package com.plzdaeng.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.plzdaeng.dto.*;
import com.plzdaeng.util.SiteConstance;

@WebServlet("/petregister")
public class PetRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public PetRegister() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("petregister");
		String saveDirectory = SiteConstance.IMG_PATH;
		
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, "utf-8");
		
		String petName = mr.getParameter("petname");
		String breedcode = mr.getParameter("breedcode");
		String petgender = mr.getParameter("petgender");
		String birthdate = mr.getParameter("birthdate");
		String pettype = mr.getParameter("pettype");
		String vaccincode = mr.getParameter("vaccincode");
		String vaccindate = mr.getParameter("vaccindate");
		String[] vaccincodes = mr.getParameterValues("vaccincode");
		String[] vaccindates = mr.getParameterValues("vaccindate");
		
		//System.out.println(vaccincodes.length);
		//System.out.println(vaccindates.length);
		
		PetDto pet = new PetDto();
		UserDto user = (UserDto)request.getSession().getAttribute("userInfo");
		// 테스트용
		if(user == null) {
			user = new UserDto();
			user.setUser_id("calubang");
		}
		pet.setUserDto(user);
		pet.setPet_name(petName);
		pet.setBreedDto(new BreedDto(null, breedcode, null));
		pet.setPet_gender(petgender);
		pet.setBirth_date(birthdate);
		pet.setPet_type(pettype);
		TakeVaccinDto takeVaccinDto = new TakeVaccinDto();
		VaccinationDto vaccinationDto = new VaccinationDto();
		//vaccinationDto.set
		
		
		//petgender
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
