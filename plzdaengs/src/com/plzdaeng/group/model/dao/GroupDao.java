package com.plzdaeng.group.model.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.plzdaeng.group.model.GroupDto;

public interface GroupDao {

	int createGroup(GroupDto dto);
	
	void applyGroupCategory(Connection con, GroupDto dto) throws SQLException;
	
	int changeGroup(GroupDto dto);
	
	int deleteGroup(GroupDto dto);
	
	List<GroupDto> inGroup(int id);
	
	List<GroupDto> recommendGroup(int id);
	
	
}
