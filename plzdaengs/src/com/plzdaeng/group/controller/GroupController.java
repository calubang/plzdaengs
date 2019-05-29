package com.plzdaeng.group.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

	public String pageLoaing(HttpServletRequest request, HttpServletResponse response) {
		// path = "/plzdaengs/template/alert_danger.jsp";
//		String id = reqeust.getParameter("logininfo");
		int id = 1;
		String type = request.getParameter("type");
		System.out.println(type);
		List<GroupDto> list = null;
		if (type != null && type.equals("mine")) {
			System.out.println("if type mine");
			list = GroupDaoImpl.getGroupDaoImpl().myGroup(id);
		} else if (type != null && type.equals("recommend")) {
			System.out.println("if type recommend");
			list = GroupDaoImpl.getGroupDaoImpl().recommendGroup();
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

	public String create(HttpServletRequest request, HttpServletResponse response) {
		String path = "/group/groupmain.jsp";
//		String id = reqeust.getParameter("logininfo");
		String id = "1";
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

}
