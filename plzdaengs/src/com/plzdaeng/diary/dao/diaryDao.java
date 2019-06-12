package com.plzdaeng.diary.dao;

import java.sql.*;
import java.text.*;
import java.util.ArrayList;
import java.util.List;

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
	
	//다이어리에 일정 등록하는 부분
	public int insertDiary(DiaryDto dto) {
		/*
		 * insert into plz_diary(diary_number, user_id, diary_date, diary_subject, diary_contents, diary_img, create_Date)
		 * VALUES (SEQ_PLZ_DIARY.nextval,'meme',sysdate, '오늘 댕댕이랑','댕이이','5.jpg',sysdate);
		 */
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = -1;
		String insertDiarySQL = 
				"insert into plz_diary(	\r\n" + 
				"    diary_number	\r\n" + 
				"    , user_id	\r\n" + 
				"    , category_id	\r\n" + 
				"    , diary_date	\r\n" + 
				"    , diary_subject	\r\n" + 
				"    , hashtag	\r\n" + 
				"    , diary_contents	\r\n" + 
				"    , diary_img	\r\n" + 
				"    , create_date	\r\n" + 
				")values(	\r\n" + 
				"    diary_number_seq.nextval	\r\n" + 
				"    , ?	\r\n" + 
				"    , ?	\r\n" + 
				"    , ?	\r\n" + 
				"    , ?	\r\n" + 
				"    , ?	\r\n" + 
				"    , ?	\r\n" + 
				"    , ?	\r\n" + 
				"    , sysdate\r\n" + 
				")";
		
		try {
			conn = DBConnection.makeConnection();
			pstmt = conn.prepareStatement(insertDiarySQL);
			int index = 0;
			pstmt.setString(++index, dto.getUser_id());
			pstmt.setString(++index, dto.getCategory_id());
			Date date = new Date(dto.getDiary_date().getTime());
			pstmt.setDate(++index, date);;
			pstmt.setString(++index, dto.getDiary_subject());
			pstmt.setString(++index, dto.getHashtag());
			pstmt.setString(++index, dto.getDiary_contents());
			pstmt.setString(++index, dto.getDiary_img());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, null);
		}
		
		return result;
	}
	
	//월이 바뀌면 호출되는 메소드
	//yyyy/mm 형태로 온다고 생각하겠음
	public List<DiaryDto> selectAllByMonth(String date, UserDto user) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<DiaryDto> list = new ArrayList<DiaryDto>();
		String selectAllByMonthSQL = 
				"select\r\n" + 
				"    diary.diary_number	\r\n" + 
				"    , diary.user_id	\r\n" + 
				"    , diary.category_id	\r\n" + 
				"    , category.category_name	\r\n" + 
				"    , diary.diary_date	\r\n" + 
				"    , diary.diary_subject	\r\n" + 
				"    , diary.hashtag	\r\n" + 
				"    , diary.diary_contents	\r\n" + 
				"    , diary.diary_img	\r\n" + 
				"from \r\n" + 
				"    plz_diary diary	\r\n" + 
				"    inner join plz_diary_category category	\r\n" + 
				"        on diary.category_id = category.category_id	\r\n" + 
				"where \r\n" + 
				"    diary.user_id = ?	\r\n" + 
				"    and diary.diary_date BETWEEN to_date(?, 'yyyy/mm') and add_months(to_date(?, 'yyyy/mm'), 1)";
		
		try {
			conn = DBConnection.makeConnection();
			pstmt = conn.prepareStatement(selectAllByMonthSQL);
			int index = 0;
			pstmt.setString(++index, user.getUser_id());
			pstmt.setString(++index, date);
			pstmt.setString(++index, date);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				DiaryDto dto = new DiaryDto();
				dto.setDiary_number(rs.getInt("diary_number"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setCategory_id(rs.getString("category_id"));
				dto.setCategory_name(rs.getString("category_name"));
				dto.setDiary_date(rs.getDate("diary_date"));
				dto.setDiary_subject(rs.getString("diary_subject"));
				dto.setHashtag(rs.getString("hashtag"));
				dto.setDiary_contents(rs.getString("diary_contents"));
				dto.setDiary_img(rs.getString("diary_img"));
				
				list.add(dto);
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt, rs);
		}
		
		return list;
	}
	
	public static void main(String[] args) throws ParseException {
		DiaryDto dto = new DiaryDto();
		UserDto user = new UserDto();
		user.setUser_id("mnmm97");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		
		dto.setCategory_id("1");
		dto.setDiary_contents("오늘은 댕댕이랑 산책을 했다.");
		dto.setDiary_date(sdf.parse("2019/06/12 16:24:33"));
		dto.setDiary_subject("오늘의 댕댕이 산책");
		dto.setHashtag("#산책#개꿀");
		dto.setUser_id("calubang");
		
		diaryDao dao = new diaryDao();
		//dao.insertDiary(dto);
		List<DiaryDto>list = dao.selectAllByMonth("2019/06", user);
		System.out.println(list);
		
	}
}
