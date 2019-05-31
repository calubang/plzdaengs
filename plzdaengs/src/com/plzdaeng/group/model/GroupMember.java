package com.plzdaeng.group.model;

public class GroupMember {


	private int group_id;
	private String user_id;
	private String member_status;
	
	public GroupMember() {
	}

	public GroupMember(int group_id, String user_id, String member_status) {
		super();
		this.group_id = group_id;
		this.user_id = user_id;
		this.member_status = member_status;
	}
	
	public int getGroup_id() {
		return group_id;
	}



	public void setGroup_id(int group_id) {
		this.group_id = group_id;
	}



	public String getUser_id() {
		return user_id;
	}



	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}



	public String getMember_status() {
		return member_status;
	}



	public void setMember_status(String member_status) {
		this.member_status = member_status;
	}



	
	
	
	
}
