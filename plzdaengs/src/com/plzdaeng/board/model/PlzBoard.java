package com.plzdaeng.board.model;

import java.sql.Clob;
import java.sql.Date;


public class PlzBoard {
	int post_id ; /* 글번호 */
	String board_category_id; /* 보드카테고리ID */
	String board_category_name;
	String user_id ; /* 유저ID */
	String post_subject;/* 글제목 */
	String post_contents ; /* 글본문 */
	Date creat_date; /* 생성일 */
	String img_id ; /* 이미지ID */
	int views ; /* 조회수 */
	String group_id ; /* 그룹ID */
	
	

	public PlzBoard(int post_id, String board_category_id, String board_category_name, String user_id,
			String post_subject, String post_contents, Date creat_date, String img_id, int views, String group_id) {
		super();
		this.post_id = post_id;
		this.board_category_id = board_category_id;
		this.board_category_name = board_category_name;
		this.user_id = user_id;
		this.post_subject = post_subject;
		this.post_contents = post_contents;
		this.creat_date = creat_date;
		this.img_id = img_id;
		this.views = views;
		this.group_id = group_id;
	}
	public PlzBoard() {
		super();
	}
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public String getBoard_category_id() {
		return board_category_id;
	}
	public void setBoard_category_id(String board_category_id) {
		this.board_category_id = board_category_id;
	}
	public String getBoard_category_name() {
		return board_category_name;
	}
	public void setBoard_category_name(String board_category_name) {
		this.board_category_name = board_category_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPost_subject() {
		return post_subject;
	}
	public void setPost_subject(String post_subject) {
		this.post_subject = post_subject;
	}
	
	
	public String getPost_contents() {
		return post_contents;
	}
	public void setPost_contents(String post_contents) {
		this.post_contents = post_contents;
	}
	public Date getCreat_date() {
		return creat_date;
	}
	public void setCreat_date(Date creat_date) {
		this.creat_date = creat_date;
	}
	public String getImg_id() {
		return img_id;
	}
	public void setImg_id(String img_id) {
		this.img_id = img_id;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	@Override
	public String toString() {
		return "PlzBoard [post_id=" + post_id + ", board_category_id=" + board_category_id + ", board_category_name="
				+ board_category_name + ", user_id=" + user_id + ", post_subject=" + post_subject + ", post_contents="
				+ post_contents + ", creat_date=" + creat_date + ", img_id=" + img_id + ", views=" + views
				+ ", group_id=" + group_id + "]";
	}
	
	
	
	
	

}
