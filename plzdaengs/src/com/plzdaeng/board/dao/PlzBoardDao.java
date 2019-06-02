package com.plzdaeng.board.dao;

import java.util.List;

import com.plzdaeng.board.model.PlzBoard;
import com.plzdaeng.board.model.PlzBoardCategory;

public interface PlzBoardDao {
	
	List<PlzBoardCategory> getCategoryList();
	int insertBoard(PlzBoard board);

}
