package com.plzdaeng.diary.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.plzdaeng.dto.DiaryDto;
import com.plzdaeng.dto.UserDetailDto;
import com.plzdaeng.dto.UserDto;
import com.plzdaeng.util.DBClose;
import com.plzdaeng.util.DBConnection;

/*
 * 1-3. 다이어리 등록/수정/삭제
 * 4-6. 이모티콘 등록/수정/삭제
 */
public class diaryDao {
	

	public void insertDiaryInfo(Connection conn, DiaryDto dto) throws SQLException{
		/*
		 * insert into plz_diary(diary_number, user_id, diary_date, diary_subject, diary_contents, diary_img, create_Date)
		 * VALUES (SEQ_PLZ_DIARY.nextval,'meme',sysdate, '오늘 댕댕이랑','댕이이','5.jpg',sysdate);
		 */
		
		PreparedStatement pstmt = null;
		StringBuffer insertUserSQL = new StringBuffer();
		
		insertUserSQL.append("insert into plz_user(\n");
		insertUserSQL.append("    user_id\n");
		insertUserSQL.append("    , password\n");
		insertUserSQL.append("    , authority\n");
		insertUserSQL.append("    , emailid\n");
		insertUserSQL.append("    , emaildomain\n");
		insertUserSQL.append("    , nickname\n");
		insertUserSQL.append("    , user_img\n");
		insertUserSQL.append(")values(\n");
		insertUserSQL.append("    ?\n");
		insertUserSQL.append("    , ?\n");
		insertUserSQL.append("    , ?\n");
		insertUserSQL.append("    , ?\n");
		insertUserSQL.append("    , ?\n");
		insertUserSQL.append("    , ?\n");
		insertUserSQL.append("    , ?\n");
		insertUserSQL.append(")\n");
		
		pstmt = conn.prepareStatement(insertUserSQL.toString());
		int index = 0;
		pstmt.setString(++index, userDto.getUser_id());
		pstmt.setString(++index, userDto.getPassword());
		pstmt.setString(++index, userDto.getAuthority());
		pstmt.setString(++index, userDto.getEmailid());
		pstmt.setString(++index, userDto.getEmaildomain());
		pstmt.setString(++index, userDto.getNickname());
		pstmt.setString(++index, userDto.getUser_img());
		
		pstmt.executeUpdate();
		
		DBClose.close(null, pstmt);
	}
}
