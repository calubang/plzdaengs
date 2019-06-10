package com.plzdaeng.chat.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/chatserver")
public class ChatServerServlet{
	private static final long serialVersionUID = 1L;

    public ChatServerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	
	@OnMessage
	public void onMessage(String msg) {
		System.out.println(msg);
	}
	
	@OnOpen
	public void handleOpen() {
		System.out.println("Client 연결됨");
	}
	
	
}
