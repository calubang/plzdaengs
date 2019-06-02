package com.plzdaeng.board.controller;

import java.io.IOException;
import java.sql.Clob;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.plzdaeng.board.dao.PlzBoardDaoImpl;
import com.plzdaeng.board.model.PlzBoard;
import com.plzdaeng.dto.UserDto;
import com.plzdaeng.util.MoveUrl;

/**
 * Servlet implementation class BoardServelet
 */
@WebServlet("/plzBoard")
public class BoardServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardServelet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("게시판서블릿들어옴");
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("UTF-8");
		String cmd = request.getParameter("cmd");
		System.out.println(request.getParameter("board_category_id"));
		String path = "";
		if("boardWrite".equals(cmd)) {
			path = "/board/totalboardwrite.jsp";
			request.setAttribute("category", PlzBoardDaoImpl.getPlzBoardDao().getCategoryList());
			MoveUrl.forward(request, response, path);
		}else if("regist".equals(cmd)) {
			
			HttpSession session = request.getSession();
			UserDto userDto = (UserDto)session.getAttribute("userInfo");
			
			PlzBoard board = new PlzBoard();
			board.setBoard_category_id(request.getParameter("board_category_id"));
			board.setPost_subject(request.getParameter("post_subject"));
			//board.setUser_id(userDto.getUser_id());
			board.setUser_id("twice");
			board.setPost_contents(request.getParameter("post_contents"));
			
			PlzBoardDaoImpl.getPlzBoardDao().insertBoard(board);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
