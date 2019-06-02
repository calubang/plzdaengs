package com.plzdaeng.board.controller;

import java.io.IOException;
import java.sql.Clob;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.plzdaeng.board.dao.PlzBoardDaoImpl;
import com.plzdaeng.board.model.BoardPage;
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
			request.setAttribute("updateView", new PlzBoard());
			request.setAttribute("mode", "regist");
			MoveUrl.forward(request, response, path);
		}else if("regist".equals(cmd)) {
			path = "/board/totalboardview.jsp";
			HttpSession session = request.getSession();
			UserDto userDto = (UserDto)session.getAttribute("userInfo");
//			getPostId
			int post_id = PlzBoardDaoImpl.getPlzBoardDao().getPostId();
			PlzBoard board = new PlzBoard();
			board.setPost_id(post_id);
			board.setBoard_category_id(request.getParameter("board_category_id"));
			board.setPost_subject(request.getParameter("post_subject"));
			//board.setUser_id(userDto.getUser_id());
			board.setUser_id("yaho");
			board.setPost_contents(request.getParameter("post_contents"));
			
			PlzBoardDaoImpl.getPlzBoardDao().insertBoard(board);
			 
			 
			 PlzBoard detailBoard = PlzBoardDaoImpl.getPlzBoardDao().getBoardDetail(post_id);	//게시물 상세조회
			 System.out.println(path);
			 //리플 리스트 조회 
			 request.setAttribute("detailView", detailBoard);
			 MoveUrl.forward(request, response, path);
			 
		}else if("boardList".equals(cmd)) {
			int curPage = 1;
			int ttlCnt = 0;
			path = "/board/totalboard.jsp";
			
			
			if(! "".equals(request.getParameter("curPage"))) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
			}
			
			ttlCnt = PlzBoardDaoImpl.getPlzBoardDao().getBoardTotalCnt();
			BoardPage page = new BoardPage(ttlCnt, curPage);
			
			String searchValue = "";
			String searchGubun = "";
			
			searchValue = request.getParameter("searchValue");
			searchGubun = request.getParameter("searchGubun");
			PlzBoard board = new PlzBoard();
			board.setCurPage(curPage);
			board.setPagescale(10);
			board.setSearchValue(searchValue);
			board.setSearchGubun(searchGubun);
			
			System.out.println(board.toString());
			
			List<PlzBoard> list = PlzBoardDaoImpl.getPlzBoardDao().getBoardList(board);
			
			
			request.setAttribute("boardList",list);
			request.setAttribute("boardPage",page);
			request.setAttribute("searchValue", searchValue);
			request.setAttribute("searchGubun", searchGubun);
			
			
			MoveUrl.forward(request, response, path);
		}else if("detail".equals(cmd)) {
			path = "/board/totalboardview.jsp";
			int post_id = Integer.parseInt(request.getParameter("post_id"));
			 PlzBoardDaoImpl.getPlzBoardDao().updateViews(post_id); //조회수 증가
			 
			 PlzBoard board = PlzBoardDaoImpl.getPlzBoardDao().getBoardDetail(post_id);	//게시물 상세조회
			 
			 //리플 리스트 조회 
			 request.setAttribute("detailView", board);
			 MoveUrl.forward(request, response, path);
		}else if("modify".equals(cmd)) {
			path = "/board/totalboardwrite.jsp";
			int post_id = Integer.parseInt(request.getParameter("post_id"));
			PlzBoard board = PlzBoardDaoImpl.getPlzBoardDao().getBoardDetail(post_id);	//게시물 상세조회
			
			 request.setAttribute("updateView", board);
			 request.setAttribute("mode", "update");
			 request.setAttribute("category", PlzBoardDaoImpl.getPlzBoardDao().getCategoryList());
			 MoveUrl.forward(request, response, path);
		}else if("update".equals(cmd)) {
			System.out.println("update ininin");
			//수정하기
			path = "/board/totalboardview.jsp";
			HttpSession session = request.getSession();
			UserDto userDto = (UserDto)session.getAttribute("userInfo");
			
			PlzBoard board = new PlzBoard();
			board.setBoard_category_id(request.getParameter("board_category_id"));
			board.setPost_subject(request.getParameter("post_subject"));
			//board.setUser_id(userDto.getUser_id());
			board.setUser_id("yaho");
			board.setPost_contents(request.getParameter("post_contents"));
			board.setPost_id(Integer.parseInt(request.getParameter("post_id")));
			
			PlzBoardDaoImpl.getPlzBoardDao().updateBoard(board);
			
			PlzBoard boardDetail = PlzBoardDaoImpl.getPlzBoardDao().getBoardDetail(board.getPost_id());	//게시물 상세조회
			 
			 //리플 리스트 조회 
			 request.setAttribute("detailView", boardDetail);
			 
			MoveUrl.forward(request, response, path);
			
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
