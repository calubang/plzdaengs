<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/template/default_link.jsp" %>
<script type="text/javascript">
var serverUrl = "ws://localhost:80/plzdaengs/chatserver";
var websocket = new WebSocket(serverUrl);

websocket.onopen = function(message) {
	alert("서버와 연결됨 : " + message);
}

websocket.onclose = function(message) {
	alert("서버와 연결 끊김 : " + message);
}

websocket.onerror = function(message) {
	alert("에러남 : " + message );
}

websocket.onmessage = function(message) {
	alert("메시지 옴 :" + message)
}

$(function() {
	$(".sendBtn").click(function() {
		alert("눌림");
		var input = $(".msginput").val();
		if(input == null || input.length == 0){
			alert("입력해주세요.");
			return;
		}
		var date = new Date();
		var nowDate = date.getYear() + "/" + date.get
		console.log(nowDate);
		var msg = {
				type : "message"
				, protocol : "protocol"
				, text : input
				, date : Date.now().toString()
		};
		websocket.send(JSON.stringify(msg));
	});
});
</script>
</head>
<body>
	<input class="msginput" type="text">
	<button class="sendBtn">전송</button>
</body>
</html>