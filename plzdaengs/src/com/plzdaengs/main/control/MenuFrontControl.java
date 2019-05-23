package com.plzdaengs.main.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.plzdaeng.util.MoveUrl;

@WebServlet("/menu")
public class MenuFrontControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MenuFrontControl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String act = request.getParameter("act");
		String path = "index.jsp";
		
		System.out.println(act);
		
		if(act == null)
			return;
		
		switch (act) {
		case "membermodify":
			path = "/plzdaengs/member/membermodify.jsp";
			MoveUrl.forward(request, response, path);
			break;
		case "animal":
			path = "/plzdaengs/member/animals.jsp";
		default:
			break;
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
