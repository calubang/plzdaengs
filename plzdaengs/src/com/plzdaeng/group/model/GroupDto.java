package com.plzdaeng.group.model;

public class GroupDto {
	
	
	private int group_id;
	private String group_leader;
	private String group_category_id;
	private String group_category_input;
	private String group_name;
	private String group_description;
	private String group_img;
	private String address_sido;
	private String address_sigungu;

	
	public GroupDto(int group_id, String group_leader, String group_category_id, String group_category_input,
			String group_name, String group_description, String group_img, String address_sido,
			String address_sigungu) {
		super();
		this.group_id = group_id;
		this.group_leader = group_leader;
		this.group_category_id = group_category_id;
		this.group_category_input = group_category_input;
		this.group_name = group_name;
		this.group_description = group_description;
		this.group_img = group_img;
		this.address_sido = address_sido;
		this.address_sigungu = address_sigungu;
	}
	
	
	public int getGroup_id() {
		return group_id;
	}
	public void setGroup_id(int group_id) {
		this.group_id = group_id;
	}
	public String getGroup_leader() {
		return group_leader;
	}
	public void setGroup_leader(String group_leader) {
		this.group_leader = group_leader;
	}
	public String getGroup_category_id() {
		return group_category_id;
	}
	public void setGroup_category_id(String group_category_id) {
		this.group_category_id = group_category_id;
	}
	public String getGroup_category_input() {
		return group_category_input;
	}
	public void setGroup_category_input(String group_category_input) {
		this.group_category_input = group_category_input;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getGroup_description() {
		return group_description;
	}
	public void setGroup_description(String group_description) {
		this.group_description = group_description;
	}
	public String getGroup_img() {
		return group_img;
	}
	public void setGroup_img(String group_img) {
		this.group_img = group_img;
	}
	public String getAddress_sido() {
		return address_sido;
	}
	public void setAddress_sido(String address_sido) {
		this.address_sido = address_sido;
	}
	public String getAddress_sigungu() {
		return address_sigungu;
	}
	public void setAddress_sigungu(String address_sigungu) {
		this.address_sigungu = address_sigungu;
	}

	
}
