package com.plzdaeng.group.controller;

import java.util.List;

import javax.servlet.http.*;

import com.plzdaeng.dto.UserDto;
import com.plzdaeng.group.model.GroupCategory;
import com.plzdaeng.group.model.GroupDto;
import com.plzdaeng.group.model.dao.GroupDaoImpl;

public class GroupController {

	private static GroupController groupController;

	static {
		groupController = new GroupController();
	}

	public static GroupController getCreateGroup() {
		return groupController;
	}

	
	
	
	public String pageLoaing(HttpServletRequest request, HttpServletResponse response, UserDto user) {
		// path = "/plzdaengs/template/alert_danger.jsp";
		String id = user.getUser_id();
		String type = request.getParameter("type");
		System.out.println(type);
		List<GroupDto> list = null;
		if (type != null && type.equals("mine")) {
			System.out.println("if type mine");
			list = GroupDaoImpl.getGroupDaoImpl().myGroup(id);
		} else if (type != null && type.equals("recommend")) {
			System.out.println("if type recommend");
			list = GroupDaoImpl.getGroupDaoImpl().recommendGroup(id);
		} else {
			String key = request.getParameter("searchoption");
			String word = request.getParameter("searchword");
			System.out.println(key + word);
			list = GroupDaoImpl.getGroupDaoImpl().searchGroup(key, word);
		}
		request.setAttribute("grouplist", list);
		String path = "/group/result/grouplistresult.jsp";
		return path;
	}

	public String create(HttpServletRequest request, HttpServletResponse response, UserDto user) {
		String path = "/group/groupmain.jsp";
		String id = user.getUser_id();
		String name = request.getParameter("groupname");
		String desc = request.getParameter("groupdescription");
		String keyword = request.getParameter("groupkeyword");
		String groupdontselect = request.getParameter("groupdontselect");
		System.out.println(groupdontselect);

		System.out.println(name + keyword + desc);
		// 소모임 정보set

		GroupCategory cate = new GroupCategory();
		cate.setGroup_category_id(keyword);
		GroupDto dto = new GroupDto();
		dto.setGroup_leader(id);
		dto.setGroup_name(name);
		dto.setGroup_description(desc);
		if (groupdontselect != "on") {
			String groupsido = request.getParameter("groupsido");
			String groupsigungu = request.getParameter("groupsigungu");
			dto.setAddress_sido(groupsido);
			dto.setAddress_sigungu(groupsigungu);
		}
		dto.setGroupCategory(cate);
//		group.setGroup_img(group_img);

		int result = GroupDaoImpl.getGroupDaoImpl().createGroup(dto);
		System.out.println("dao 결과 result : " + result);
		request.setAttribute("result", result);
		return path;
	}

	public String enterorsingup(HttpServletRequest request, HttpServletResponse response, UserDto user) {
		String path = "";
		String id = user.getUser_id();
		int group_id = Integer.parseInt(request.getParameter("group"));
		System.out.println(group_id);
		int result = GroupDaoImpl.getGroupDaoImpl().inquiry(group_id, id);
		if(result == 1) {
			//grouppage loading
			GroupDaoImpl.getGroupDaoImpl().firstpage(group_id);
			
		}else if(result == -1) {
			//소모임 그룹 가입 모달창으로
			
			//return;
		}
		
		
		
		
		
		return path;
	}

}
