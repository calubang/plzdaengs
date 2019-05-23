package com.plzdaeng.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.plzdaeng.util.MoveUrl;

@WebServlet("/animal")
public class AnimalFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public AnimalFrontController() {
       
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String act = request.getParameter("act");
		String path = "/index.jsp";
		
		System.out.println("animal : " + act);
		
		if(act == null)
			return;
		
		switch (act) {
		case "animalregister":
			path = "/member/animalregister.jsp";
			break;
		case "animals":
			path = "/member/animals.jsp";
			break;
			
		default:
			break;
		}
		
		MoveUrl.forward(request, response, path);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
