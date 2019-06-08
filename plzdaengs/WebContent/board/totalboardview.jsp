<%@page import="java.util.List"%>
<%@page import="com.plzdaeng.board.model.BoardPage"%>
<%@page import="com.plzdaeng.board.model.PlzReply"%>
<%@page import="com.plzdaeng.board.model.PlzBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	PlzBoard board = (PlzBoard) request.getAttribute("detailView");
	List<PlzReply> reply = (List) request.getAttribute("reply");
	BoardPage rPage = (BoardPage) request.getAttribute("replyPage");
%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Bubbly - Boootstrap 4 Admin template by Bootstrapious.com</title>
<%@ include file="/template/default_link.jsp"%>
<!-- include summernote css/js -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script> 
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>
<!-- 서머노트 -->
<script src="/plzdaengs/board/js/httpRequest.js"></script>
</head>
<script type="text/javascript">
	function goModify(post_id){
		$("#post_id").val(post_id);
		document.getElementById("modify").action = "/plzdaengs/plzBoard";
		document.getElementById("modify").submit();
	}
	
	function insertReply(){
		var textReply = $("#textReply").val();
		var params = "cmd=reply";
			params += "&reply_contents="+textReply;
			params += "&post_id="+<%=board.getPost_id()%>;
			params += "&board_category_id="+<%=board.getBoard_category_id()%>;
			
		sendRequest("/plzdaengs/plzBoard",params,replyResult,"GET");
	}
	
	function replyResult(){
		if(httpRequest.readyState == 4){
			if(httpRequest.status == 200){
				$("#textReply").val('');
				var result = httpRequest.responseXML;
				var reply = result.getElementsByTagName("reply");
				var page = result.getElementsByTagName("page");
				
				$("#replyArea").html('');
				console.log(result);
				for(var i = 0; i < reply.length; i++) {
					var option = "<div class='form-group row'>";
						option += "		<label class='col-md-1 form-control-label'>"+reply[i].getElementsByTagName("user_name")[0].firstChild.data+"</label>";
						option += "		<label class='col-md-10 form-control-label'>"+reply[i].getElementsByTagName("reply_contents")[0].firstChild.data+"</label>";
						option += "		<label class='col-md-1 form-control-label'>"+reply[i].getElementsByTagName("create_date")[0].firstChild.data+"</label>";
						option += "</div>";
					
					$("#replyArea").append(option);
				}
			}
		}
	}
	
	function goMovePage(pageNo){
		var params = "cmd=getReply";
			params += "&post_id="+<%=board.getPost_id()%>;
			params += "&curPage="+pageNo;
			
		sendRequest("/plzdaengs/plzBoard",params,replyResult,"GET");
	}
	
</script>
<body>
	<!-- navbar-->
	<header class="header">
		<nav class="navbar navbar-expand-lg px-4 py-2 bg-white shadow">
			<a href="#" class="sidebar-toggler text-gray-500 mr-4 mr-lg-5 lead"><i
				class="fas fa-align-left"></i></a><a href="index.jsp"
				class="navbar-brand font-weight-bold text-uppercase text-base">Bubbly
				Dashboard</a>
			<ul class="ml-auto d-flex align-items-center list-unstyled mb-0">
				<li class="nav-item">
					<form id="searchForm" class="ml-auto d-none d-lg-block">
						<div class="form-group position-relative mb-0">
							<button type="submit" style="top: -3px; left: 0;"
								class="position-absolute bg-white border-0 p-0">
								<i class="o-search-magnify-1 text-gray text-lg"></i>
							</button>
							<input type="search" placeholder="Search ..."
								class="form-control form-control-sm border-0 no-shadow pl-4">
						</div>
					</form>
				</li>
				<li class="nav-item dropdown mr-3"><a id="notifications"
					href="http://example.com" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false"
					class="nav-link dropdown-toggle text-gray-400 px-1"><i
						class="fa fa-bell"></i><span class="notification-icon"></span></a>
					<div aria-labelledby="notifications" class="dropdown-menu">
						<a href="#" class="dropdown-item">
							<div class="d-flex align-items-center">
								<div class="icon icon-sm bg-violet text-white">
									<i class="fab fa-twitter"></i>
								</div>
								<div class="text ml-2">
									<p class="mb-0">You have 2 followers</p>
								</div>
							</div>
						</a><a href="#" class="dropdown-item">
							<div class="d-flex align-items-center">
								<div class="icon icon-sm bg-green text-white">
									<i class="fas fa-envelope"></i>
								</div>
								<div class="text ml-2">
									<p class="mb-0">You have 6 new messages</p>
								</div>
							</div>
						</a><a href="#" class="dropdown-item">
							<div class="d-flex align-items-center">
								<div class="icon icon-sm bg-blue text-white">
									<i class="fas fa-upload"></i>
								</div>
								<div class="text ml-2">
									<p class="mb-0">Server rebooted</p>
								</div>
							</div>
						</a><a href="#" class="dropdown-item">
							<div class="d-flex align-items-center">
								<div class="icon icon-sm bg-violet text-white">
									<i class="fab fa-twitter"></i>
								</div>
								<div class="text ml-2">
									<p class="mb-0">You have 2 followers</p>
								</div>
							</div>
						</a>
						<div class="dropdown-divider"></div>
						<a href="#" class="dropdown-item text-center"><small
							class="font-weight-bold headings-font-family text-uppercase">View
								all notifications</small></a>
					</div></li>
				<li class="nav-item dropdown ml-auto"><a id="userInfo"
					href="http://example.com" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false"
					class="nav-link dropdown-toggle"><img
						src="/plzdaengs/template/img/avatar-6.jpg" alt="Jason Doe"
						style="max-width: 2.5rem;" class="img-fluid rounded-circle shadow"></a>
					<div aria-labelledby="userInfo" class="dropdown-menu">
						<a href="#" class="dropdown-item"><strong
							class="d-block text-uppercase headings-font-family">Mark
								Stephen</strong><small>Web Developer</small></a>
						<div class="dropdown-divider"></div>
						<a href="#" class="dropdown-item">Settings</a><a href="#"
							class="dropdown-item">Activity log </a>
						<div class="dropdown-divider"></div>
						<a href="login.html" class="dropdown-item">Logout</a>
					</div></li>
			</ul>
		</nav>
	</header>
	<div class="d-flex align-items-stretch" id="document">
		<div id="sidebar" class="sidebar py-3">
			<div
				class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family">MAIN</div>
			<ul class="sidebar-menu list-unstyled">
				<li class="sidebar-list-item"><a href="index.html"
					class="sidebar-link text-muted"><i
						class="o-home-1 mr-3 text-gray"></i><span>Home</span></a></li>
				<li class="sidebar-list-item"><a href="charts.html"
					class="sidebar-link text-muted"><i
						class="o-sales-up-1 mr-3 text-gray"></i><span>Charts</span></a></li>
				<li class="sidebar-list-item"><a href="tables.html"
					class="sidebar-link text-muted active"><i
						class="o-table-content-1 mr-3 text-gray"></i><span>Tables</span></a></li>
				<li class="sidebar-list-item"><a href="forms.html"
					class="sidebar-link text-muted"><i
						class="o-survey-1 mr-3 text-gray"></i><span>Forms</span></a></li>
				<li class="sidebar-list-item"><a href="#"
					data-toggle="collapse" data-target="#pages" aria-expanded="false"
					aria-controls="pages" class="sidebar-link text-muted"><i
						class="o-wireframe-1 mr-3 text-gray"></i><span>Pages</span></a>
					<div id="pages" class="collapse">
						<ul
							class="sidebar-menu list-unstyled border-left border-primary border-thick">
							<li class="sidebar-list-item"><a href="#"
								class="sidebar-link text-muted pl-lg-5">Page one</a></li>
							<li class="sidebar-list-item"><a href="#"
								class="sidebar-link text-muted pl-lg-5">Page two</a></li>
							<li class="sidebar-list-item"><a href="#"
								class="sidebar-link text-muted pl-lg-5">Page three</a></li>
							<li class="sidebar-list-item"><a href="#"
								class="sidebar-link text-muted pl-lg-5">Page four</a></li>
						</ul>
					</div></li>
				<li class="sidebar-list-item"><a href="login.html"
					class="sidebar-link text-muted"><i
						class="o-exit-1 mr-3 text-gray"></i><span>Login</span></a></li>
			</ul>
			<div
				class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family">EXTRAS</div>
			<ul class="sidebar-menu list-unstyled">
				<li class="sidebar-list-item"><a href="#"
					class="sidebar-link text-muted"><i
						class="o-database-1 mr-3 text-gray"></i><span>Demo</span></a></li>
				<li class="sidebar-list-item"><a href="#"
					class="sidebar-link text-muted"><i
						class="o-imac-screen-1 mr-3 text-gray"></i><span>Demo</span></a></li>
				<li class="sidebar-list-item"><a href="#"
					class="sidebar-link text-muted"><i
						class="o-paperwork-1 mr-3 text-gray"></i><span>Demo</span></a></li>
				<li class="sidebar-list-item"><a href="#"
					class="sidebar-link text-muted"><i
						class="o-wireframe-1 mr-3 text-gray"></i><span>Demo</span></a></li>
			</ul>
		</div>
		<div class="page-holder w-100 d-flex flex-wrap">
			<div class="container-fluid px-xl-5" id="contents">
				<section class="py-5" style="max-height: none;">
					<div class="row">
						<div class=" col-lg-12 mb-4">
							<div class="card" style="min-width: 40rem">
								<!-- 여기 끝에 글쓰기버튼 -->
								<div class="card-header">
									<div class="form-group row">
										<label class="col-md-1 form-control-label">카테고리 : <%=board.getBoard_category_descripton() %></label> 
										<label class="col-md-1 form-control-label">제 목 : <%=board.getPost_subject() %></label> 
										<label class="col-md-10 form-control-label">조회수 : <%=board.getViews() %></label>
										<label class="col-md-10 form-control-label">등록일 : <%=board.getCreat_date() %></label>
									</div>
								</div>
								<div class="card-body">
									<%=board.getPost_contents() %>
								</div>
								<div class="card-footer" id="replyArea">
									<%
										for(int i=0;i<reply.size();i++){
									%>
									<!-- 댓글 내용 들어갈 곳 -->
									 <div class="form-group row">
										<label class="col-md-1 form-control-label"><%=reply.get(i).getUser_name() %></label> <label
											class="col-md-10 form-control-label"><%=reply.get(i).getReply_contents() %></label> <label
											class="col-md-1 form-control-label"><%=reply.get(i).getCreat_date() %></label>
									</div>
									<%} %>
									
								</div>
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" id="pageArea"><!-- 페이징 -->
									<nav>
										<ul class="pagination" style="margin-left: 30%;">
											<% if(rPage.getCurBlock() > 1 ){ %>
											<li class="page-item">
												<a class="page-link" href="#">Previous</a>
											</li>
											<%} 
											
												for(int i = rPage.getBlockBegin(); i <=rPage.getBlockEnd() ; i++){
													if(i == rPage.getCurPage()){
											%>
												<li class="page-item" onclick="goMovePage(<%=i%>)">
													<a class="page-link"><%=i %></a>
												</li>
											<%}else{ %>
												<li class="page-item" onclick="goMovePage(<%=i%>)">
													<a class="page-link" href="#"><%=i %></a>
												</li>
											<% 
											}
												}
												
												if(rPage.getCurBlock() <= rPage.getTotalBlock()){ %>
											<li class="page-item">
												<a class="page-link" href="#">Next</a>
											</li>
											<%} %>
										</ul>
									</nav>
								</div>
								<!-- 덧글입력란  -->
								<div class="card-footer">
									<input type="text" class="form-control col-md-9" id="textReply">
									<button class="btn btn-primary " type="button"
								style="background-color: #dc3545; float: right; padding: 0.2rem 0.8rem;" id="reply" onclick="insertReply()">댓글등록버튼</button>
								</div>
							</div>
							<!-- 여기 끝에 글쓰기버튼 -->
							<button class="btn btn-primary " type="button"
								style="background-color: #dc3545; float: left; padding: 0.2rem 0.8rem;">목록가기</button>
							<button class="btn btn-primary " type="button"
								style="background-color: #dc3545; float: right; padding: 0.2rem 0.8rem;" onclick="goModify(<%=board.getPost_id()%>)">수정하기</button>
							<button class="btn btn-primary " type="button"
								style="background-color: #dc3545; float: right; padding: 0.2rem 0.8rem;">등록하기</button>
						</div>
					</div>
					
					<form id="modify" method="post" action="">
						<input type="hidden" name="post_id" id="post_id" value="">
						<input type="hidden" name="cmd" id="cmd" value="modify">
					</form>
				</section>
			</div>
			<%@ include file="/template/footer.jsp"%>
		</div>
	</div>
	<%@ include file="/template/default_js_link.jsp"%>
</body>
</html>