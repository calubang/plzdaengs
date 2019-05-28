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
		
		System.out.println("menu : " + act);
		
		if(act == null)
			return;
		
		switch (act) {
		case "animals":
			path = "/animal";
			break;
		case "membermodify":
			path = "/member/membermodify.jsp";
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
