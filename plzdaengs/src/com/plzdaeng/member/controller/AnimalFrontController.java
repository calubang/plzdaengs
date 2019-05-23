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
		String path = "";

		if(act == null)
			return;
		
		switch (act) {
		case "registeranimal":
			path = "/member/registeranimal2.jsp";
			MoveUrl.forward(request, response, path);
			break;

		default:
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
