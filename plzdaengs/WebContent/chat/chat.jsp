<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/template/default_link.jsp" %>
<style type="text/css">
/* chatting */
.chat{
	position: absolute;
	height: 93vh;
	top : 0px;
	right : 0px;
	width : 15rem;
}

.chatSmall{
	position: absolute;
	height: 93vh;
	top : 0px;
	right : 0px;
	width : 5rem;
}

#chat>.chatheader{
	height: 4vh;
	width: 100%;
	padding: 3%;
}
#chat>.chatheader a{
	height: 100%;
}
#chat>.chatheader label{
	height: 100%;
	font-size: 1rem;
}
#chat>.chatMsgArea{
	position : relative;
	height : 90%;
	width: 100%;
	resize: none;
}

#chat>.chatfooter{
	height: 4vh;
	width: 100%;
}

#chat>.chatfooter>input{
	height : 100%;
	width: 70%;
}
#chat>.chatfooter>button{
	height : 100%;
	width: 25%;
}

#chat>.chat-toggle{
}
</style>
<script type="text/javascript">
var groupId = "1";
var userId = "calubang";
var serverUrl = "ws://192.168.14.53:80/plzdaengs/chatserver?groupid="+groupId;
var websocket = new WebSocket(serverUrl);

websocket.onopen = function(message) {
	console.log("서버와 연결됨 : " + message);
}

websocket.onclose = function(message) {
	console.log("서버와 연결 끊김 : " + message);
}

websocket.onerror = function(message) {
	console.log("에러남 : " + message);
}

websocket.onmessage = function(message) {
	//console.log("메시지 옴 :" + message.data);
	//JSON으로 변환
	var msgJSON = JSON.parse(message.data);
	var userid = msgJSON.user_id;
	var groupid = msgJSON.group_id;
	var nickname = msgJSON.nickname;
	var chatContents = msgJSON.chat_contents;
	var chatDate = msgJSON.chat_date;
	
	var result = nickname + "(" + userid + ")" + charDate + " : <br>" + chatContents;
	//console.log(chatDate);
	var chatTextArea = $("#chat .chatMsgArea");
	chatTextArea.append(result);
	
}

$(function() {
	//클릭시 메시지 전송
	$(".sendBtn").click(msgSend);
});
function msgSend(){
	var input = $(".chat .msgInput").val();
	
	if(input == null || input.length == 0){
		alert("입력해주세요.");
		return;
	}
	
	//JSON 형태로 변형
	var type = "message";
	var groupid = parseInt(groupId);
	var userid = userId;
	var nickname = "댕댕이주인";
	var msg = makeMsg(type, userid, nickname, groupid, input);
	
	websocket.send(JSON.stringify(msg));
}

function makeMsg(type, userid, nickname, groupid, text) {
	var nowdate = nowDate();
	//console.log(nowdate);
	var msg = {
		type : type
		, group_id : groupid
		, user_id : userid
		, nickname : nickname
		, chat_contents : text
		, chat_date : nowdate
	};
	return msg;
}

function nowDate(){
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	var day = date.getDay();
	var hour = date.getHours();
	var minute = date.getMinutes();
	var second = date.getSeconds();
	var miliSecond = date.getMilliseconds();
	
	//변환
	month = (month < 10 ? "0" + month : month);
	day = (day < 10 ? "0" + day : day);
	hour = (hour < 10 ? "0" + hour : hour);
	minute = (minute < 10 ? "0" + minute : minute);
	second = (second < 10 ? "0" + second : second);
	
	return year + "/" + month + "/" + day + " " + hour + ":" + minute + ":" + second + ":" + miliSecond;
	
}
</script>
</head>
<body>
	<div id="chat" class="chat">
		<div class="chatheader">
			<a href="#" class="text-gray-500 mr-4 mr-lg-5 lead chat-toggle">
				<i class="fas fa-align-left" id="togglechat"></i>
			</a>
			<label>채팅창</label>
		</div>
		<textarea class="chatMsgArea" readonly="readonly"></textarea>
		<div class="chatfooter">
			<input class="msgInput" type="text">
			<button class="sendBtn">전송</button>
		</div>
	</div>
</body>
</html>