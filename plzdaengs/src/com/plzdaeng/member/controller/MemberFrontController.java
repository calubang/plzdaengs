package com.plzdaeng.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

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
		String act = request.getParameter("act");
		String path = "index.jsp";
		if(act == null) {
			return;
		}
		System.out.println("member : " + act);
		
		switch (act) {
		case "login":
			HttpSession session = request.getSession();
			session.setAttribute("userInfo", "userInfo 테스트중..");
			//path = "/member/loginfail.jsp";
			path = "/member/loginsuccess.jsp";
			break;
		case "join":
			path = "/member/memberjoin.jsp";
			break;
		case "zipsearchWeb":
			path = "/zipsearch";
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
