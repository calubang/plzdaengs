package com.plzdaeng.board.yugi.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.plzdaeng.board.yugi.service.YugiService;


@WebServlet("/yugi")
public class YugiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public YugiServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("서블릿들어와짐");
		String cmd = request.getParameter("cmd");
		
		if("sido".equals(cmd)) {
			 response.setContentType("text/xml;charset=utf-8");
			
			try {
				
				PrintWriter out = response.getWriter();
				out.print(new YugiService().getSido(cmd));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
