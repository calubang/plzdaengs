package com.plzdaeng.chat.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONObject;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.plzdaeng.chat.service.ChatService;
import com.plzdaeng.dto.ChatDto;

@ServerEndpoint("/chatserver")
public class ChatServerServlet{
	private List<Session> list = new ArrayList<Session>();
	private Map<Integer, List<Session>> chatMap = new HashMap<Integer, List<Session>>();
	private ChatService service;
	
    public ChatServerServlet() {
        super();
        service = new ChatService();
    }
	
	@OnMessage
	public void onMessage(String msg, Session session) {
		System.out.println(msg);
		ObjectMapper mapper = new ObjectMapper();
		try {
			ChatDto chatDto = mapper.readValue(msg, ChatDto.class);
			//System.out.println(chatDto);
			int result = service.insertMsg(chatDto);
			if(result == 1) {
				//정상작동
				List<Session> list = chatMap.get(chatDto.getGroup_id());
				for(Session client : list) {
					client.getBasicRemote().sendText("아항");
				}	
			} else {
				//비정상
			}
		} catch (JsonParseException e1) {
			e1.printStackTrace();
		} catch (JsonMappingException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
	}
	
	@OnOpen
	public void handleOpen(Session session) {
		System.out.println("클라이언트 입장 : " + session);
		String groupId = session.getRequestParameterMap().get("groupid").get(0);
		List<Session> sessionList = chatMap.get(groupId);
		if(sessionList == null) {
			sessionList = new ArrayList<Session>();
			sessionList.add(session);
			chatMap.put(Integer.parseInt(groupId), sessionList);
		}
		
		System.out.println("chatMap : " + chatMap);
		
		//System.out.println("session groupid : " + session.getQueryString());
		
	}
	
	
}
