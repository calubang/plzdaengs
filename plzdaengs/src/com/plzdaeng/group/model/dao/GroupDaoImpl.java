package com.plzdaeng.group.model.dao;

import java.sql.*;

import com.plzdaeng.group.model.GroupDto;
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
		creatGroupSql.append(",GROUP_CATEGORY_INPUT\r\n");
		creatGroupSql.append(",GROUP_NAME\r\n");
		creatGroupSql.append(",DESCRIPTION\r\n");
		creatGroupSql.append(",GROUP_IMG\r\n");
		creatGroupSql.append(",ADDRESS_SIDO\r\n");
		creatGroupSql.append(",ADDRESS_SIGUNGU)\r\n");
		creatGroupSql.append("values(\r\n");
		creatGroupSql.append("group_id_seq.NEXTVAL\r\n");
		creatGroupSql.append(", ?\r\n");
		creatGroupSql.append(", null\r\n");
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

}
