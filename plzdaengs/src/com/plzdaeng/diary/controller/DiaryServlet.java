package com.plzdaeng.diary.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

/**
 * Servlet implementation class DiaryServlet
 */
@WebServlet("/diary")
public class DiaryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DiaryServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("넘어오니?");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/diary Servlet으로 이동 >>");
		
		//String val = request.getParameter("val");
		//String num = request.getParameter("num");
		  
		  String title = request.getParameter("title");
		  String description = request.getParameter("description");

		  System.out.print("DIARY[제목 : " + title + ", ");
		  System.out.println("내용 : " + description + "]");
		  // 아직 img는 못넘어왔음

		  // return type은 json으로
		  JSONObject obj = new JSONObject();
		  obj.put("result", "OK");

		  response.setContentType("application/x-json; charset=UTF-8");
		  response.getWriter().print(obj);
	}

}
