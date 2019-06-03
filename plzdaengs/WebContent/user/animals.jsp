<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/template/default_link.jsp"%>
<script src="/plzdaengs/template/airdatepicker/js/datepicker.js"></script>
<script src="/plzdaengs/template/airdatepicker/js/i18n/datepicker.kr.js"></script>

<!-- datepicker -->
<link href="/plzdaengs/template/airdatepicker/css/datepicker.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
$(function () {
	//애완동물 표시하는 로직
	//initAnimals();
	
	//추가버튼 이벤트
	$(".plusimg").click(registerAnimal);
});

function registerAnimal() {
	$.ajax({
		url : "/plzdaengs/animal"
		, data: {
			act : "animalregister"
		}
		, success: function(result){
			$("#contents").html(result);
		}
	});
}

function initAnimals() {
	//animal 정보를 받아오기..
	
	//var animals = 
}
</script>
<style type="text/css">
.plusimg{
	background-image: url("/plzdaengs/template/img/plus.png");
	background-position: center;
	background-repeat: no-repeat;
	background-size: inherit;
	width: 100%;
	height: 100%;
	opacity: 0.5;
}
.plusimg:hover{
	opacity: 1;
	border-color: #c6d8ff;
	box-shadow: 0 0 0 0.2rem rgba(70, 128, 255, 0.25);
}
.animals .card{
	min-height: 15rem;
	max-height: 20rem;	
}

.animals .card .card-header{
	text-align: center;
}

</style>
</head>
<body>
	<!-- 경고창 모달 -->
	<%@ include file="/template/alert_danger.jsp"%>
	<!-- 강아지 기타 눌렸을 때 모달 -->
	<div id="kindothermodal" class="modal fade" role="dialog">
		<h5 class="modal-title" id="myModalLabel">강아지 품종 검색</h5>
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header text-center">
					<label style="margin-left: auto; margin-bottom:auto; margin-top:auto; font-size: 1.5rem">강아지 품종 검색</label>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">X</span>
					</button>
				</div>
				<div class="modal-body text-center">
					
					<div class="input-group" align="left">
						<input type="text" class="form-control" id="doro" name="doro"
							placeholder="검색 할 품종명"> <span
							class="input-group-btn"> <input type="button"
							class="btn btn-warning" value="검색" id="searchBtn">
						</span>
					</div>
					<div style="width: 100%; height: 500px; overflow: auto; margin-top: 1%;">
		
					</div>
				</div>
			</div>
		</div>
	</div>
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
				<!-- section 1 -->
				<section class="py-5 animals">
					<div class="row">
						<div class="col-lg-6 mb-4">
							<div class="card">
								<div class="card-header">
									<h3 class="h6 text-uppercase mb-0">강아지1</h3>
								</div>
								<div class="card-body">
								</div>
							</div>
						</div>
						<div class="col-lg-6 mb-4">
							<div class="card">
								<div class="card-header">
									<h3 class="h6 text-uppercase mb-0">강아지1</h3>
								</div>
								<div class="card-body">
								</div>
							</div>
						</div>
						<div class="col-lg-6 mb-4">
							<div class="card">
								<div class="card-header">
									<h3 class="h6 text-uppercase mb-0">강아지1</h3>
								</div>
								<div class="card-body">
								</div>
							</div>
						</div>
						<div class="col-lg-6 mb-4">
							<div class="card plusimg">
							</div>
						</div>
					</div>
				</section>
			</div>
			<%@ include file="/template/footer.jsp"%>
		</div>
	</div>
	<%@ include file="/template/default_js_link.jsp"%>
	<script src="/plzdaengs/template/airdatepicker/js/datepicker.js"></script>
	<script src="/plzdaengs/template/airdatepicker/js/i18n/datepicker.kr.js"></script>
</body>
</html>