package com.plzdaeng.group.controller;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.plzdaeng.dto.UserDto;
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
		//String path = "/group/index.jsp";
		System.out.println(act);
		HttpSession session = request.getSession();
		UserDto user = (UserDto)session.getAttribute("userInfo");
		System.out.println(user);
		String path = "";
		if("creategroup".equals(act)) {
			System.out.println("front create");
			path = GroupController.getCreateGroup().create(request, response, user);
			MoveUrl.forward(request, response, path);
		}else if("loading".equals(act)) {
			System.out.println("front loading");
			path = GroupController.getCreateGroup().pageLoaing(request, response, user);
			MoveUrl.forward(request, response, path);
			System.out.println(path);
		}else if("enter".equals(act)) {
			System.out.println("front enter");
			path = GroupController.getCreateGroup().enterorsingup(request, response, user);
			MoveUrl.forward(request, response, path);
		}else if("groupmanage".equals(act)) {
			System.out.println("front enter");
			path = GroupController.getCreateGroup().entermanege(request, response);
			MoveUrl.forward(request, response, path);
			System.out.println("go to the groupdetail");
		}else if("changedetail".equals(act)) {
			System.out.println("front enter");
			path = GroupController.getCreateGroup().changeDetail(request, response);
			MoveUrl.forward(request, response, path);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding(SiteConstance.ENCODE);
		doGet(request, response);
	}


}
