package com.plzdaeng.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.plzdaeng.board.model.PlzBoard;
import com.plzdaeng.board.model.PlzBoardCategory;
import com.plzdaeng.util.DBClose;
import com.plzdaeng.util.DBConnection;

public class PlzBoardDaoImpl implements PlzBoardDao{

	private static PlzBoardDao plzBoardDao; //2
	
	static {
		plzBoardDao = new PlzBoardDaoImpl();
	} //3
	
	public static PlzBoardDao getPlzBoardDao() {
		return plzBoardDao;
	} //4
	
	@Override
	public List<PlzBoardCategory> getCategoryList() {
		// TODO Auto-generated method stub
		List<PlzBoardCategory> list = new ArrayList<PlzBoardCategory>();
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		try {
			con = DBConnection.makeConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT BOARD_CATEGORY_ID \n");
			sql.append("	 , BOARD_CATEGORY_NAME \n");
			sql.append("	 , BOARD_CATEGORY_DESCRIPTON \n");
			sql.append("FROM PLZ_BOARD_CATEGORY \n");
			sql.append("ORDER BY BOARD_CATEGORY_ID ASC ");
			pstm = con.prepareStatement(sql.toString());
			rs = pstm.executeQuery();
			while(rs.next()) {
				PlzBoardCategory category = new PlzBoardCategory();
				category.setBoard_category_id(rs.getString("BOARD_CATEGORY_ID"));
				category.setBoard_category_name(rs.getString("BOARD_CATEGORY_NAME"));
				category.setBoard_category_descripton(rs.getString("BOARD_CATEGORY_DESCRIPTON"));
				
				list.add(category);
			}
			
			System.out.println(list.size());
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstm, rs);
		}
		return list;
	}

	@Override
	public int insertBoard(PlzBoard board) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		int result = 0;
		try {
			con = DBConnection.makeConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO PLZ_BOARD \n");
			sql.append("VALUES(SEQ_PLZ_BOARD.NEXTVAL,?,?,?,?,SYSDATE,NULL,0,NULL)");
			
				
			pstm = con.prepareStatement(sql.toString());
			pstm.setString(1, board.getBoard_category_id());
			pstm.setString(2, board.getUser_id());
			pstm.setString(3, board.getPost_subject());
			pstm.setString(4, board.getPost_contents());
			
			result = pstm.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstm, rs);
		}
		
		return result;
	}
	
	
	

}
