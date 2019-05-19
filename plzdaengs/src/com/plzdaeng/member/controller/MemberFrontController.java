package com.plzdaeng.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.plzdaeng.util.MoveUrl;

@WebServlet("/member")
public class MemberFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("member front 입장");
		String act = request.getParameter("act");
		String path = "index.jsp";
		if(act == null) {
			return;
		}
		
		switch (act) {
		case "login":
			HttpSession session = request.getSession();
			session.setAttribute("userInfo", "login");
			//path = "/member/loginfail.jsp";
			path = "/member/loginsuccess.jsp";
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
