package com.plzdaeng.chat.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.plzdaeng.dto.ChatDto;
import com.plzdaeng.util.DBClose;
import com.plzdaeng.util.DBConnection;

public class ChatDao {

	public int insert(ChatDto chatDto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = -1;
		String insertSQL = 
				"insert into plz_group_chat(\r\n" + 
				"    group_id\r\n" + 
				"    , user_id\r\n" + 
				"    , chat_date\r\n" + 
				"    , chat_contents\r\n" + 
				")values(\r\n" + 
				"    ?	\r\n" + 
				"    , ?	\r\n" + 
				"    , to_timestamp(? , 'yyyy/mm/dd hh24:mi:ss:ff3')\r\n" + 
				"    , ?	\r\n" + 
				")";
		try {
			conn = DBConnection.makeConnection();
			pstmt = conn.prepareStatement(insertSQL);
			int index = 0;
			pstmt.setInt(++index, chatDto.getGroup_id());
			pstmt.setString(++index, chatDto.getUser_id());
			pstmt.setString(++index, chatDto.getChat_date());
			pstmt.setString(++index, chatDto.getChat_contents());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, pstmt);
		}
		
		return result;
	}
	
}
