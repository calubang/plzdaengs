package com.plzdaeng.board.dao;

import java.util.List;

import com.plzdaeng.board.model.PlzBoard;
import com.plzdaeng.board.model.PlzBoardCategory;

public interface PlzBoardDao {
	
	List<PlzBoardCategory> getCategoryList();
	int insertBoard(PlzBoard board);
	List<PlzBoard> getBoardList(PlzBoard board);
	int getBoardTotalCnt();
	PlzBoard getBoardDetail(int post_id);
	int updateViews(int post_id);
	int updateBoard(PlzBoard board);		//수정하기
	int getPostId();
}
