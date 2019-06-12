package com.plzdaeng.diary.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Clob;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.plzdaeng.dto.DiaryDto;
import com.plzdaeng.util.ProfileCreate;
import com.plzdaeng.util.SiteConstance;



@WebServlet("/diary")
public class DiaryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DiaryServlet() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 * 1. servlet 들어왔는지 확인
		 * 2. dto에 넘어온 정보 set > img also > userjoinservlet 참고
		 */
		
		System.out.println("/diary Servlet으로 이동 >>");
		
		String saveDirectory = SiteConstance.IMG_PATH;
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, "utf-8");
		
		String title = mr.getParameter("title");
		String description = mr.getParameter("description");
		File imgdata = mr.getFile("imgdata");
		
		System.out.println(title + "/"+ description + imgdata);
		
		System.out.println(UUID.randomUUID());
		String filename = UUID.randomUUID().toString();
		String path = request.getServletContext().getRealPath("/img");
		System.out.println(path);
		
		DiaryDto dto = new DiaryDto();
		dto.setDiary_img("/plzdaengs/img/"+filename + "." + imgdata.getName().split("\\.")[1]);
		System.out.println(dto);
		
		if(imgdata !=  null) {
			ProfileCreate.profileRegister(imgdata, path, filename , null, "diary");
		}
		
		
		//db 저장하는 로직
		//성공 : 1
		//실패 : -1
		
		
		
		
		
		
		
		
		
		/*
		// return type은 json으로
		JSONObject obj = new JSONObject();
		obj.put("result", "OK");
		
		response.setContentType("application/x-json; charset=UTF-8");
		response.getWriter().print(obj);
		
		System.out.println("/diary Servlet으로 이동 >>");
		
		//String val = request.getParameter("val");
		//String num = request.getParameter("num");
		
		String diary_subject = request.getParameter("title");
		String diary_contents = request.getParameter("description");
				System.out.print("DIARY[제목 : " + diary_subject + ", ");
		System.out.println("내용 : " + diary_contents + "]");
		// 아직 img는 못넘어왔음
		
		DiaryDto dto = new DiaryDto();
		dto.setDiary_subject(diary_subject);
		dto.setDiary_contents(diary_contents);
		**/
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
