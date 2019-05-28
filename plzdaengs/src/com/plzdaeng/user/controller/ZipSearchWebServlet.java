package com.plzdaeng.user.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.plzdaeng.user.service.UserService;
import com.plzdaeng.util.MoveUrl;

@WebServlet("/zipsearchweb")
public class ZipSearchWebServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private UserService service;   
	
    public ZipSearchWebServlet() {
        super();
        service = new UserService();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("zipsearch");
		String doro = request.getParameter("doro");
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		System.out.println("doro : " + doro + "// currentPage : " + currentPage);
		
		StringBuffer xml = service.zipSearchWeb(doro, currentPage);
		//request.setAttribute("zipsearchwebresult", xml.toString());
		//MoveUrl.forward(request, response, "/user/zipsearchwebresult.jsp");
		//System.out.println(xml);
		
		response.setContentType("text/xml;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(xml);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
