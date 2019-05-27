<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page session="true"%>
    
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
$(function(){
	
var textarea = document.getElementById("messageWindow");
var webSocket = new WebSocket('ws://localhost:80/plzdaengs/broadcasting');
var inputMessage = document.getElementById('inputMessage');
webSocket.onerror = function(event) {
    onError(event + "Error")
};
webSocket.onopen = function(event) {
    onOpen(event + "Open")
};
webSocket.onmessage = function(event) {
    onMessage(event + "Message")
};

function onOpen(event) {
    $("#messageWindow").html("<p class='chat_content'>채팅에 참여하였습니다.</p>");
}
function onError(event) {
    alert(event.data + "DataError");
}

var inputsend = $("#inputsend");
$(inputsend).click(function(){
	alert("click");
});


function send() {
	var id = $("#chat_id");
	alert(id);
    if (inputMessage.value == "") {
    } else {
        $("#messageWindow").html($("#messageWindow").html()
            + "<p class='chat_content'>나 : " + inputMessage.value + "</p>");
    }
    webSocket.send($("#chat_id").val() + "|" + inputMessage.value);
    inputMessage.value = "";
}
//     엔터키를 통해 send함
/* function enterkey() {
	var id = $("#chat_id");
	alert(id);
    if (window.event.keyCode == 13) {
        send();
    } 
   
}*/
//     채팅이 많아져 스크롤바가 넘어가더라도 자동적으로 스크롤바가 내려가게함
window.setInterval(function() {
    var elem = document.getElementById('messageWindow');
    elem.scrollTop = elem.scrollHeight;
}, 0);
});
</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <div id="_chatbox">
  <input class="chat_id" type="text">
        <fieldset>
            <div id="messageWindow"></div>
           <!--  <textarea rows="3" cols="30" readonly="readonly"></textarea> -->
            <br><input id="inputMessage" type="text" >
            <input id="inputsend" type="submit" value="send">
        </fieldset>
    </div>
</body>
</html>