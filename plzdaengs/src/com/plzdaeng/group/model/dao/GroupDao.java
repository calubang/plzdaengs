package com.plzdaeng.group.model.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.plzdaeng.group.model.GroupBoard;
import com.plzdaeng.group.model.GroupDto;

public interface GroupDao {

	int createGroup(GroupDto dto);
	
	void applyGroupCategory(Connection con, GroupDto dto) throws SQLException;
	
	int changeGroup(GroupDto dto);
	
	int deleteGroup(GroupDto dto);
	
	List<GroupDto> myGroup(String user_id);
	
	List<GroupDto> recommendGroup(String user_id);
	
	List<GroupDto> searchGroup(String key, String word);
	
	int inquiry(int group_id, String user_id);
	
	List<GroupBoard> firstpage(int group_id);
	
	
}
