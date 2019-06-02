package com.plzdaeng.group.model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.plzdaeng.group.model.*;
import com.plzdaeng.util.DBClose;
import com.plzdaeng.util.DBConnection;

public class GroupDaoImpl implements GroupDao {

	private static GroupDaoImpl groupDaoImpl;

	static {
		groupDaoImpl = new GroupDaoImpl();
	}

	private GroupDaoImpl() {
	}

	public static GroupDaoImpl getGroupDaoImpl() {
		return groupDaoImpl;
	}

	@Override
	public int createGroup(GroupDto dto) {
		System.out.println("Dao메소드입장");
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;

		StringBuffer creatGroupSql = new StringBuffer();

		creatGroupSql.append("insert into PLZ_GROUP(\r\n");
		creatGroupSql.append("GROUP_ID\r\n");
		creatGroupSql.append(",GROUP_CATEGORY_ID\r\n");
		creatGroupSql.append(",GROUP_NAME\r\n");
		creatGroupSql.append(",DESCRIPTION\r\n");
		creatGroupSql.append(",GROUP_IMG\r\n");
		creatGroupSql.append(",ADDRESS_SIDO\r\n");
		creatGroupSql.append(",ADDRESS_SIGUNGU)\r\n");
		creatGroupSql.append("values(\r\n");
		creatGroupSql.append("group_id_seq.NEXTVAL\r\n");
		creatGroupSql.append(", ?\r\n");
		creatGroupSql.append(", ?\r\n");
		creatGroupSql.append(", ?\r\n");
		creatGroupSql.append(", null\r\n");
		creatGroupSql.append(", ?\r\n");
		creatGroupSql.append(", ?)\r\n");

		try {
			System.out.println("sql문실행전");
			conn = DBConnection.makeConnectplzdb();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(creatGroupSql.toString());
			pstmt.setString(1, dto.getGroupCategory().getGroup_category_id());
			pstmt.setString(2, dto.getGroup_name());
			pstmt.setString(3, dto.getGroup_description());
//			pstmt.setString(4, dto.getGroup_img());
			pstmt.setString(4, dto.getAddress_sido());
			pstmt.setString(5, dto.getAddress_sigungu());
			int r = pstmt.executeUpdate();
			System.out.println("sql문실행후");

			System.out.println(r);
			DBClose.close(null, pstmt);

			applyGroupCategory(conn, dto);

			conn.commit();
			result = 1;
		} catch (SQLException e) {
			try {
				System.out.println("rollback 실행");
				conn.rollback();
			} catch (SQLException e1) {
				System.out.println("rollback fail..관리자에게 문의하세요.");
				e1.printStackTrace();
				result = -2;
				return result;
			}
			e.printStackTrace();
		} finally {
			DBClose.close(conn, null);
		}

		return result;
	}

	@Override
	public void applyGroupCategory(Connection conn, GroupDto dto) throws SQLException {
		PreparedStatement pstmt = null;
		StringBuffer applyCategorySql = new StringBuffer("");
		applyCategorySql.append("insert into PLZ_GROUP_MEMBER values(group_id_seq.CURRVAL, ?, 'L')");
		try {
			pstmt = conn.prepareStatement(applyCategorySql.toString());
			pstmt.setString(1, dto.getGroup_leader());
			int r = pstmt.executeUpdate();
			System.out.println(r);
		} finally {
			DBClose.close(null, pstmt);
		}
	}

	@Override
	public int changeGroup(GroupDto dto) {
		int result = -1;

		return result;
	}

	@Override
	public int deleteGroup(GroupDto dto) {
		int result = -1;

		return result;
	}

	@Override
	public List<GroupDto> myGroup(String user_id) {

		List<GroupDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String inGourpSQL = "SELECT g.group_id , g.group_name, g.description "
				+ ", t.group_category_id, t.group_category_name, g.group_img "
				+ ", g.address_sido, g.address_sigungu, m.user_id \r\n"
				+ "FROM plz_group g inner join plz_group_type t \r\n"
				+ "on g.group_category_id = t.group_category_id \r\n" + "inner join plz_group_member m \r\n"
				+ "on g.group_id = m.group_id \r\n" + "WHERE m.user_id = ? and m.member_status != all('X', 'A')"
				+ "ORDER BY g.group_id, m.user_id DESC";

		try {
			conn = DBConnection.makeConnectplzdb();
			pstmt = conn.prepareStatement(inGourpSQL.toString());
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			GroupDto dto = null;
			GroupCategory cate = null;
			GroupMember member = null;
			List<GroupMember> memberList = null;
			int old_group_id = -1;
			int group_id = 0;
			while (rs.next()) {
				group_id = rs.getInt("group_id");
				if (old_group_id != group_id) {

					cate = new GroupCategory();
					cate.setGroup_category_id(rs.getString("group_category_id"));
					cate.setGroup_category_name(rs.getString("group_category_name"));

					dto = new GroupDto();
					list.add(dto);
					dto.setGroupCategory(cate);
					dto.setGroup_id(rs.getInt("group_id"));
					dto.setGroup_name(rs.getString("group_name"));
					dto.setGroup_description(rs.getString("description"));
//				dto.setGroup_leader(group_leader);
					dto.setGroup_img(rs.getString("group_img"));
					dto.setAddress_sido(rs.getString("address_sido"));
					dto.setAddress_sigungu(rs.getString("address_sigungu"));

					memberList = new ArrayList<GroupMember>();
					dto.setGroupMembers(memberList);

				}

				member = new GroupMember();
				member.setUser_id(rs.getString("user_id"));
				// member.setMember_status(rs.getString("member_status"));
				memberList.add(member);

			}

		} catch (SQLException e) {
			System.out.println("myGroup() error");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}

		return list;
	}

	@Override
	public List<GroupDto> recommendGroup(String user_id) {

		List<GroupDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String inGourpSQL = "SELECT g.group_id , g.group_name, g.description \r\n"
				+ ", t.group_category_id, t.group_category_name, g.group_img \r\n"
				+ ", g.address_sido, g.address_sigungu, m.user_id \r\n"
				+ "FROM plz_group g inner join plz_group_type t \r\n"
				+ "on g.group_category_id = t.group_category_id \r\n" + "inner join plz_group_member m \r\n"
				+ "on g.group_id = m.group_id \r\n" + "WHERE m.user_id != ? and m.member_status != 'A' \r\n"
				+ "ORDER BY g.group_id, m.user_id DESC";

		try {
			conn = DBConnection.makeConnectplzdb();
			pstmt = conn.prepareStatement(inGourpSQL.toString());
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			GroupDto dto = null;
			GroupCategory cate = null;
			GroupMember member = null;
			List<GroupMember> memberList = null;
			int old_group_id = -1;
			int group_id = 0;
			while (rs.next()) {
				group_id = rs.getInt("group_id");
				if (old_group_id != group_id) {

					cate = new GroupCategory();
					cate.setGroup_category_id(rs.getString("group_category_id"));
					cate.setGroup_category_name(rs.getString("group_category_name"));

					dto = new GroupDto();
					list.add(dto);
					dto.setGroupCategory(cate);
					dto.setGroup_id(rs.getInt("group_id"));
					dto.setGroup_name(rs.getString("group_name"));
					dto.setGroup_description(rs.getString("description"));
//				dto.setGroup_leader(group_leader);
					dto.setGroup_img(rs.getString("group_img"));
					dto.setAddress_sido(rs.getString("address_sido"));
					dto.setAddress_sigungu(rs.getString("address_sigungu"));

					memberList = new ArrayList<GroupMember>();
					dto.setGroupMembers(memberList);

				}

				member = new GroupMember();
				member.setUser_id(rs.getString("user_id"));
				// member.setMember_status(rs.getString("member_status"));
				memberList.add(member);
			}

		} catch (SQLException e) {
			System.out.println("recommendGroup() error");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}

		return list;
	}

	@Override
	public List<GroupDto> searchGroup(String key, String word) {

		List<GroupDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBConnection.makeConnectplzdb();

			String inGroupSQL = "SELECT g.group_id , g.group_name, g.description \r\n"
					+ ", t.group_category_id, t.group_category_name, g.group_img \r\n"
					+ ", g.address_sido, g.address_sigungu, m.user_id \r\n"
					+ "FROM plz_group g inner join plz_group_type t \r\n"
					+ "on g.group_category_id = t.group_category_id \r\n" + "inner join plz_group_member m \r\n"
					+ "on g.group_id = m.group_id \r\n";

			if (key.equals("1")) {
				inGroupSQL += "WHERE g.group_name like '%" + word + "%' \r\n";
				// pstmt = conn.prepareStatement(inGourpSQL);
//				pstmt.setString(1, word);
			} else if (key.equals("2")) {
				inGroupSQL += "WHERE g.address_sido like '%" + word + "%' or g.address_sigungu like '%" + word
						+ "%' \r\n";
				// pstmt = conn.prepareStatement(inGourpSQL);
//				pstmt.setString(1, word);
//				pstmt.setString(2, word);
			} else if (key.equals("3")) {
				inGroupSQL += "WHERE t.group_category_name like '%" + word + "%' \r\n";
				// pstmt = conn.prepareStatement(inGourpSQL);
//				pstmt.setString(1, word);
			}
			inGroupSQL += "ORDER BY g.group_id, m.user_id DESC";
			pstmt = conn.prepareStatement(inGroupSQL);
			rs = pstmt.executeQuery();
			GroupDto dto = null;
			GroupCategory cate = null;
			GroupMember member = null;
			List<GroupMember> memberList = null;
			int old_group_id = -1;
			int group_id = 0;
			while (rs.next()) {
				group_id = rs.getInt("group_id");
				if (old_group_id != group_id) {

					cate = new GroupCategory();
					cate.setGroup_category_id(rs.getString("group_category_id"));
					cate.setGroup_category_name(rs.getString("group_category_name"));

					dto = new GroupDto();
					list.add(dto);
					dto.setGroupCategory(cate);
					dto.setGroup_id(rs.getInt("group_id"));
					dto.setGroup_name(rs.getString("group_name"));
					dto.setGroup_description(rs.getString("description"));
//				dto.setGroup_leader(group_leader);
					dto.setGroup_img(rs.getString("group_img"));
					dto.setAddress_sido(rs.getString("address_sido"));
					dto.setAddress_sigungu(rs.getString("address_sigungu"));

					memberList = new ArrayList<GroupMember>();
					dto.setGroupMembers(memberList);

				}

				member = new GroupMember();
				member.setUser_id(rs.getString("user_id"));
				// member.setMember_status(rs.getString("member_status"));
				memberList.add(member);
			}

		} catch (SQLException e) {
			System.out.println("searchGroup() error");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}

		return list;
	}

	@Override
	public String inquiry(int group_id, String user_id) {
		String result = "X";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBConnection.makeConnectplzdb();

			String checkSQL = "SELECT group_id, user_id, member_status" + "FROM plz_group_member"
					+ "WHERE group_id = ? and user_id =? and member_status = 'X'";

			pstmt = conn.prepareStatement(checkSQL);
			pstmt.setInt(1, group_id);
			pstmt.setString(2, user_id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				
				result = rs.getString("member_status");
			}else {
				
				
			}

		} catch (SQLException e) {
			System.out.println("searchGroup() error");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}

		return result;
	}

	// 그룹 첫페이지 게시판 로딩 ( 게시판 or 사진 게시판 )
	@Override
	public List<GroupBoard> boardLoading(int group_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBConnection.makeConnectplzdb();

			String boradLoadingSQL = "SELECT post_id, user_id, post_subject, post_contents, creat_date, img_id, views, group_id\r\n" + 
					"FROM plz_board b\r\n" + 
					"WHERE group_id = 20;";

			pstmt = conn.prepareStatement(boradLoadingSQL);
			pstmt.setInt(1, group_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				
		
				
			}

		} catch (SQLException e) {
			System.out.println("boardLoading() error");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}
		return null;
	}

}
