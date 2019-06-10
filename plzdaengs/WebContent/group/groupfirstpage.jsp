<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/template/default_link.jsp"%>
<%
	String level = (String) request.getAttribute("authority");
	int group_id = Integer.parseInt(request.getParameter("group"));
	String group_name = "한강산책 가즈아!";
	String authority = "";
	if (level == "L") {
		authority = "소모임관리";
	} else if (level == "M") {
		authority = "소모임탈퇴";
	} else if (level == "A") {
		authority = "가입요청중";
	} else if (level == "X") {
		authority = "소모임가입";
	}
%>
<script>
	$(function() {

		var authority = $("#groupoptbtn").text();
		var Obtn = $("#groupoptbtn");
		$(Obtn).click(function() {
			alert('<%=level%>');
			if ('<%=level%>' == 'A') {
				alert("가입 승인대기중입니다.");
			} else if ('<%=level%>' == 'X') {
				alert("가입하세요~");
				$("#joingroupmodal").modal('show');
			}else if('<%=level%>' == 'M'){
				alert("탈퇴할꺼야?");
				$("#leavegroupmodal").modal('show');
			} else {
				$.ajax({
					url : '/plzdaengs/groupfront',
					method : 'POST',
					data : {act : 'groupmanage',
						group_id : '<%=group_id%>' },
					success : function(groupdetail) {
						alert("Option resultpage");
						$("section").html(groupdetail);
					}

				});
			}
		});
		
		var join = $('#joingroup');
		$(join).click(function(){
			$.ajax({
				url : '/plzdaengs/groupfront',
				method : 'GET',
				data : {group_id : '<%=group_id%>'},
				success : function(result) {
					var resultB = request.getAttribute('result');
					if(resultB == 1){
					alert("succeed to request join");
					$("section").html();
					//authority = "가입요청중"
					}else{
						alert("fail to join group")
						$("section").html();
					}
				}
			});
			
			
			
			
			
		});
		
	});
</script>
</head>
<body>
<!-- 그룹가입 -->
	<div id="joingroupmodal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true"
		class="modal fade text-left">
		<div role="document" class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 id="exampleModalLabel" class="modal-title">소모임을 가입하시겠습니까?</h4>
					<button type="button" data-dismiss="modal" aria-label="Close"
						class="close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					
				
						<input type="hidden" name="act" value="joingroup">
						<div class="form-group">
							<label><%=group_name%></label> 
						</div>
						<div class="line"></div>

						<div class="form-group">
							<label>소모임 소개</label>
						</div>
				</div>
				<div class="modal-footer">
					<input name="joingroup" type="submit" value="가입신청"
						class="btn btn-primary"> <input name="modalcancel"
						type="button" data-dismiss="modal" value="취소"
						class="btn btn-primary">
				</div>
			</div>
		</div>
	</div>
	<!-- 그룹탈퇴 -->
<!-- 	<div id="leavegroupmodal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true"
		class="modal fade text-left">
		<div role="document" class="modal-dialog">
			<div class="modal-content">
				<div class="modal-footer">
					<input name="leavegroup" type="submit" value="소모임 탈퇴"
						class="btn btn-primary"> <input name="modalcancel"
						type="button" data-dismiss="modal" value="취소"
						class="btn btn-primary">
				</div>
			</div>
		</div>
	</div> -->

	<!-- navbar-->
	<header class="header">
		<nav class="navbar navbar-expand-lg px-4 py-2 bg-white shadow">
			<a href="#" class="sidebar-toggler text-gray-500 mr-4 mr-lg-5 lead"><i
				class="fas fa-align-left"></i></a><a href="index.html"
				class="navbar-brand font-weight-bold text-uppercase"></a>
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
						<a href="/plzdaengs/login.html" class="dropdown-item">Logout</a>
					</div></li>
			</ul>
		</nav>
	</header>

	<div class="d-flex align-items-stretch" id="document">
		<!-- 사이드 sidebar -->
		<%@ include file="/template/sidebar.jsp"%>
		<!-- 사이드 sidebar -->

		<div class="page-holder w-100 d-flex flex-wrap">
			<div class="container-fluid" id="contents">

				<section class="py-5">
					<div name="title">
						<h2 style="display: inline;"><%=group_name%></h2>
						<Button id="groupoptbtn"><%=authority%></Button>
					</div>
					<div class="row">
						<div class="col-lg-8 mb-4 mb-lg-0">
							<div class="card">
								<div class="card-header">
									<h5 class="text-uppercase mb-0">사진 게시판</h5>
								</div>
								<div class="card-body">
									<table class="table card-text">
										<thead>
											<tr>
												<th>#</th>
												<th>제목</th>
												<th>작성자</th>
												<th>작성일자</th>
												<th>조회수</th>
												<th>추천수</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th scope="row">1</th>
												<td>우리 댕댕이가 아파요ㅜㅜ</td>
												<td>댕맘</td>
												<td>2019.05.19</td>
												<td>40</td>
												<td>20</td>
											</tr>
											<tr>
												<th scope="row">2</th>
												<td>우리 댕댕이가 아파요ㅜㅜ</td>
												<td>댕맘</td>
												<td>2019.05.19</td>
												<td>40</td>
												<td>20</td>
											</tr>
											<tr>
												<th scope="row">3</th>
												<td>우리 댕댕이가 아파요ㅜㅜ</td>
												<td>댕맘</td>
												<td>2019.05.19</td>
												<td>40</td>
												<td>20</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div style="text-align: center;">더보기</div>
							</div>
							<div class="card">
								<div class="card-header">
									<h5 class="text-uppercase mb-0">일반 게시판</h5>
								</div>
								<div class="card-body">
									<table class="table card-text">
										<thead>
											<tr>
												<th>#</th>
												<th>제목</th>
												<th>작성자</th>
												<th>작성일자</th>
												<th>조회수</th>
												<th>추천수</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th scope="row">1</th>
												<td>우리 댕댕이가 아파요ㅜㅜ</td>
												<td>댕맘</td>
												<td>2019.05.19</td>
												<td>40</td>
												<td>20</td>
											</tr>
											<tr>
												<th scope="row">2</th>
												<td>우리 댕댕이가 아파요ㅜㅜ</td>
												<td>댕맘</td>
												<td>2019.05.19</td>
												<td>40</td>
												<td>20</td>
											</tr>
											<tr>
												<th scope="row">3</th>
												<td>우리 댕댕이가 아파요ㅜㅜ</td>
												<td>댕맘</td>
												<td>2019.05.19</td>
												<td>40</td>
												<td>20</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div style="text-align: center;">더보기</div>
							</div>
						</div>
					</div>

				</section>
			</div>
			<%@ include file="/template/footer.jsp"%>
		</div>
	</div>
	<%@ include file="/template/default_js_link.jsp"%>
</body>
</html>