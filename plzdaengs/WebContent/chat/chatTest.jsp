<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="userInfo" value="${sessionScope.userInfo}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/template/default_link.jsp" %>
<c:if test="${!empty userInfo}">
<script>
$(function(){
	//로그인 한 유저에 대해서 반영할 내용
	loginSuccessProcess();
});

function loginSuccessProcess(){
	var profilePath = "${userInfo.user_img}";
	$("#profile").css("background-image", "url('"+profilePath + "')");
	mainSectionChange();
}
function mainSectionChange() {
	$("#contents").html("<h3>여기에 다이어리 들어가야함.</h3>");
}
</script>
</c:if>
<script type="text/javascript">
$(function() {
	$("#loginbtn").click(loginModalShow);
	$("#loginmodal .modal-success").click(login);
	//$("#loginmodal .kakao-login").click(loginWithKakao);
	//회원가입
	$("#registerbtn").click(registerbtnClick);
	
	$(".modal-cancel").click(function() {
		var name = $(this).attr("name");
		$("#"+name).modal("hide");
		return false;
	});
	
	//2중모달 처리
	$("#alert").on('hidden.bs.modal', function(){
		$("body").prop("class", "modal-open");
	  });
	
});

function registerbtnClick() {
	$.ajax({
		url : "user"
		, data : {
			act : "userjoin"
		}
		, success : function (result) {
			$("#contents").html(result);
		}
	});
	return false;
}

function loginAlertBtnClick() {
	$("#alert").modal("hide");
	$("body").prop("class", "modal-open");
	return false;
}

function loginProcess() {
	$("#profile").css("background-image", "url('/plzdaengs/template/img/profile.jpg')");
}
function loginModalShow() {
	$("#loginmodal").modal("show");
}

function login(){
	var id = $("#loginmodal input[name=id]").val();
	var password = $("#loginmodal input[name=password]").val();
	
	var idPattern = /^[A-Za-z]{1}[A-Za-z0-9]{3,10}$/;
	
	if(id == null || id.length == 0){
		showAlertModal("로그인 경고", "아이디를 입력하세요");
		return;
	}
	if(password == null || password.length == 0){
		showAlertModal("로그인 경고", "비밀번호를 입력하세요");
		return;
	}
	
	//로그인 실패를 위해 ajax
	$.ajax({
		url : "userlogin"
		, method : "post"
		, data : $("#loginmodal form").serialize()
		, success : function(result){
			if(result.trim() != "1"){
				//$("#loginalert p").html(result);
				showAlertModal("로그인 경고", result);
			}else{
				location.href = "/plzdaengs/menu?act=main";
			}
		}
	});
}
</script>
<style type="text/css">
#loginmodal .modal-lg{
	width: 50%;
}
#loginmodal .modal-content{
	border-radius: 5%;
}
#loginmodal .form-control-label{
	font-size: 1.2rem;
}
#loginmodal .form-group input{
	height: 3rem;
	font-size: 1.2rem;
}
#loginmodal .btn-group button{
	height: 3rem
}
#loginmodal h5{
	font-size: 1.7rem;	
}
</style>
</head>
<body>
	<!-- navbar-->	
	<%@ include file="/template/header.jsp" %>
	<div class="d-flex align-items-stretch" id ="document">
		<!-- 사이드 sidebar -->
		<%@ include file="/template/sidebar.jsp" %>
		<!-- 사이드 sidebar -->
		<div class="page-holder w-100 d-flex flex-wrap">
			<div class="container-fluid" id="contents">
				<%@ include file="/template/alert_danger.jsp" %>
				<!-- section 1 -->
				<section class="py-5" id="mainSection">
					
				</section>
				
			</div>
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
			<%@ include file="/template/footer.jsp" %>
		</div>
	</div>
	<%@ include file="/template/default_js_link.jsp" %>
</body>
</html>