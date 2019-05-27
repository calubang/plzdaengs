package com.plzdaeng.group.controller;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.plzdaeng.util.MoveUrl;
import com.plzdaeng.util.SiteConstance;


@WebServlet("/groupfront")
public class GroupFrontController extends HttpServlet {
	@Override
	public void init(ServletConfig config) throws ServletException {
	}

	private static final long serialVersionUID = 1L;
       
   
    public GroupFrontController() {
    	
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		System.out.println("front 도착");
		String act = request.getParameter("act");
		String path = "/group/index.jsp";
		System.out.println(act);
		
		if("creategroup".equals(act)) {
			System.out.println("if문 안으로 들어옴");
			GroupController.getCreateGroup().create(request, response);
			MoveUrl.forward(request, response, path);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding(SiteConstance.ENCODE);
		doGet(request, response);
	}


}
