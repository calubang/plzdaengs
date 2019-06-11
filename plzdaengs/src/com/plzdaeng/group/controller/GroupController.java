package com.plzdaeng.group.controller;

import java.util.List;

import javax.servlet.http.*;

import com.plzdaeng.dto.UserDto;
import com.plzdaeng.group.model.*;
import com.plzdaeng.group.model.dao.GroupDaoImpl;

public class GroupController {

	private static GroupController groupController;

	static {
		groupController = new GroupController();
		
	}

	public static GroupController getGroupController() {
		return groupController;
	}

	
	String path = "";
	
	public String pageLoaing(HttpServletRequest request, HttpServletResponse response, UserDto user) {
		// path = "/plzdaengs/template/alert_danger.jsp";
		String id = user.getUser_id();
		System.out.println(id);
		//user.setUser_id("qwer");
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
		
		//차후 로그인에서 넣어주면 지워도 되는 부분.
		//HttpSession session = request.getSession();
		//session.setAttribute("mygrouplist", list); 
		for(GroupDto dto : list) {
			System.out.println(dto.toString());
		}
		System.out.println(list.size());
		path = "/group/result/grouplistresult.jsp";
		return path;
	}

	public String create(HttpServletRequest request, HttpServletResponse response, UserDto user) {
		path = "/group/groupmain.jsp";
		String id = user.getUser_id();
		//user.setUser_id("qwer");
		String name = request.getParameter("groupname");
		String desc = request.getParameter("groupdescription");
		String keyword = request.getParameter("groupkeyword");
		String groupdontselect = request.getParameter("groupdontselect");//지역무관
		System.out.println(groupdontselect);

		System.out.println(name + keyword + desc);
		// 소모임 정보set

		GroupCategory cate = new GroupCategory();
		cate.setGroup_category_id(keyword);
		GroupDto dto = new GroupDto();
		dto.setGroup_leader(id);
		dto.setGroup_name(name);
		dto.setGroup_description(desc);
		if (groupdontselect == null || !groupdontselect.equals("on") ){
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
		response.setContentType("text/html;charset=UTF-8");
		path = "";
		String id = user.getUser_id();
		String result = "";
		//user.setUser_id("qwer");
		int group_id = Integer.parseInt(request.getParameter("group"));
		String group_name = request.getParameter("group_name");
		System.out.println(group_id + group_name);
		//1 입장
		//GroupDaoImpl.getGroupDaoImpl().firstpage(group_id);
		
		
		//HttpSession session = request.getSession();
		//List<GroupDto> list = (List)session.getAttribute("grouplist");
		
//		for(GroupDto group : list) {
//			if(group_id == group.getGroup_id()) {
//				System.out.println("그룹입장");
//				result = group.
//				return
//			}
//		}
		
		//2 권한에 따라 버튼이 바뀜 ( 리더 : 관리, 일반 : 탈퇴, 요청중 : 대기, 비회원 : 가입 )
		result = GroupDaoImpl.getGroupDaoImpl().inquiry(group_id, id);
		request.setAttribute("authority", result);
		request.setAttribute("group_name", group_name);
		
		System.out.println(result);
		
		//3.그룹 홈페이지 로딩
		//GroupDaoImpl.getGroupDaoImpl().boardLoading(group_id);
		path = "/group/groupfirstpage.jsp";

		
		
		
		
		
		return path;
	}




	public String entermanege(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		int group_id = Integer.parseInt(request.getParameter("group_id"));
		session.setAttribute("group_id", group_id);
		GroupDto dto = new GroupDto();
		dto = GroupDaoImpl.getGroupDaoImpl().groupDetail(group_id);
		request.setAttribute("groupdetail", dto);
		path = "/group/managegroupinfo.jsp";
		return path;
	}

	public String changeDetail(HttpServletRequest request, HttpServletResponse response) {
		path = "/group/managegroupinfo.jsp";
		int group_id = Integer.parseInt(request.getParameter("group_id"));
		String name = request.getParameter("groupname");
		String desc = request.getParameter("group_description");
		String keyword = request.getParameter("groupkeyword");
		String groupdontselect = request.getParameter("groupdontselect");//지역무관
		String img = request.getParameter("groupimg");
		String groupsido = request.getParameter("groupsido");
		String groupsigungu = request.getParameter("groupsigungu");
		//String groupCategory = 
		
		System.out.println(name + "/" +keyword  + "/" + desc + "/" + groupdontselect);
		// 소모임 정보set
		GroupDto dto = new GroupDto();
		dto.setGroup_id(group_id);
		//dto.setGroup_leader(id);
		dto.setGroup_name(name);
		dto.setGroup_description(desc);
		dto.setGroup_img(img);
		dto.setAddress_sido(groupsido);
		dto.setAddress_sigungu(groupsigungu);
		
//		if (!groupdontselect.equals("on")){
//			System.out.println("지역무관 판단");
//			String groupsido = request.getParameter("groupsido");
//			String groupsigungu = request.getParameter("groupsigungu");
//			dto.setAddress_sido(groupsido);
//			dto.setAddress_sigungu(groupsigungu);
//		}
		int result = GroupDaoImpl.getGroupDaoImpl().changeGroup(dto);
		//entermanege(request, response);
		request.setAttribute("group_id", group_id);
		entermanege(request, response);
//		request.setAttribute("groupdetail", dto);
		return path;
	}

	public String joinGroup(HttpServletRequest request, HttpServletResponse response, UserDto user) {
		path = "/group/groupfirstpage.jsp";
		int group_id = Integer.parseInt(request.getParameter("group_id"));
		String id = user.getUser_id();
		
		int result = GroupDaoImpl.getGroupDaoImpl().joinGroup(group_id, id);
		request.setAttribute("result", result);
		return path;
	}

	public String memberlist(HttpServletRequest request, HttpServletResponse response) {
		path = "/group/result/memberlistresult.jsp";
		HttpSession session = request.getSession();
		List<GroupMember> list = null;
		int group_id = Integer.parseInt(String.valueOf(session.getAttribute("group_id")));
		System.out.println(group_id);
		list = GroupDaoImpl.getGroupDaoImpl().memberlist(group_id);
		request.setAttribute("memberlist", list);
		
		return path;
	}

	public String managemember(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("들어는오나?");
		path = "/group/result/memberlistresult.jsp";
		HttpSession session = request.getSession();
		int group_id = Integer.parseInt(String.valueOf(session.getAttribute("group_id")));
		String user_id = request.getParameter("member_id");
		String member_status = request.getParameter("member_status");
		System.out.println(user_id +"/" + member_status);
		GroupMember member = new GroupMember();
		member.setGroup_id(group_id);
		member.setUser_id(user_id);
		member.setMember_status(member_status);
		System.out.println(member);
		int result = -1;
		if(member_status.equals("A")) {
			result = GroupDaoImpl.getGroupDaoImpl().permitMember(member);
		}else if(member_status.equals("M")) {
			result = GroupDaoImpl.getGroupDaoImpl().kickMember(member);
		}else if(member_status.equals("L")){
			result = GroupDaoImpl.getGroupDaoImpl().removeAuthority(member);
		}
		request.setAttribute("result", result);
		return path;
	}





	
	

}
