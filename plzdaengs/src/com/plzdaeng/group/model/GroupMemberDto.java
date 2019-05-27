package com.plzdaeng.group.model;

public class GroupMemberDto {
	
	
	private int group_id;
	private String group_member;
	private String group_member_status;

	
	public GroupMemberDto(int group_id, String group_member, String group_member_status) {
		super();
		this.group_id = group_id;
		this.group_member = group_member;
		this.group_member_status = group_member_status;
	}
	
	
	public int getGroup_id() {
		return group_id;
	}
	public void setGroup_id(int group_id) {
		this.group_id = group_id;
	}
	public String getGroup_member() {
		return group_member;
	}
	public void setGroup_member(String group_member) {
		this.group_member = group_member;
	}
	public String getGroup_member_status() {
		return group_member_status;
	}
	public void setGroup_member_status(String group_member_status) {
		this.group_member_status = group_member_status;
	}
	
	
	
}
