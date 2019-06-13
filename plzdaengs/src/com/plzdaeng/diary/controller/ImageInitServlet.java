package com.plzdaeng.diary.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.plzdaeng.diary.service.DiaryService;

@WebServlet("/imginit")
public class ImageInitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DiaryService service;
	
    public ImageInitServlet() {
        super();
        service = new DiaryService();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("init으로 들어옴!");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
