<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Bubbly - Boootstrap 4 Admin template by Bootstrapious.com</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="all,follow">
	<!-- JavaScript files-->
	<script src="/plzdaengs/template/vendor/jquery/jquery.min.js"></script>
	<script src="/plzdaengs/template/vendor/popper.js/umd/popper.min.js">
		
	</script>
	<script src="/plzdaengs/board/js/httpRequest.js"></script>
	<script src="/plzdaengs/template/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="/plzdaengs/template/vendor/jquery.cookie/jquery.cookie.js">
		
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
	<script src="/plzdaengs/template/js/front.js"></script>
<!-- Bootstrap CSS-->
<link rel="stylesheet"
	href="/plzdaengs/template/vendor/bootstrap/css/bootstrap.min.css">
<!-- Font Awesome CSS-->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
	integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
	crossorigin="anonymous">
<!-- Google fonts - Popppins for copy-->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Poppins:300,400,800">
<!-- orion icons-->
<link rel="stylesheet" href="/plzdaengs/template/css/orionicons.css">
<!-- theme stylesheet-->
<link rel="stylesheet" href="/plzdaengs/template/css/style.default.css"
	id="theme-stylesheet">
<!-- Custom stylesheet - for your changes-->
<link rel="stylesheet" href="/plzdaengs/template/css/custom.css">
<!-- Favicon-->
<link rel="shortcut icon" href="/plzdaengs/template/img/favicon.png?3">

<script src="/plzdaengs/board/js/bootstrap-datepicker.js"></script>
<script src="/plzdaengs/board/js/bootstrap-datepicker.kr.js"></script>
<link rel="stylesheet"	href="/plzdaengs/board/css/datepicker3.css">
<!-- Tweaks for older IEs-->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
</head>
<script type="text/javascript">
$(document).ready(function() {//
	
	var params = "cmd=sido";
	sendRequest("/plzdaengs/yugi",params,sidoResult,"GET");
	
	$("#bgnde").datepicker({
		format : "yyyy-mm-dd",
		calendarWeeks : false,
		autoclose : true,
		todayHighlight : false,
		language : "kr",
		useCurrent : false,
		endDate : new Date()
		});
	
	$("#endde").datepicker({
		format : "yyyy-mm-dd",
		calendarWeeks : false,
		autoclose : true,
		todayHighlight : false,
		language : "kr",
		useCurrent : false,
		endDate : new Date()
		})
	
	$(".calendar-icon").click(function(){
		var target = $(this).attr("target");
		$("#"+target).datepicker().focus();
	});
	
	
	$("#bgnde").datepicker('setDate','-1m');
	
	$("#endde").datepicker('setDate','today');
	
	searchList();
	
});

function getRecentDate(){
    var dt = new Date();
 
    var recentYear = dt.getFullYear();
    var recentMonth = dt.getMonth() + 1;
    var recentDay = dt.getDate();
 
    if(recentMonth < 10) recentMonth = "0" + recentMonth;
    if(recentDay < 10) recentDay = "0" + recentDay;
 
    return recentYear + "-" + recentMonth + "-" + recentDay;
}

function sidoResult(){
	if(httpRequest.readyState == 4){
		if(httpRequest.status == 200){
			
			var result = httpRequest.responseXML;
			var item = result.getElementsByTagName("item");
			
			for(var i = 0; i < item.length; i++) {
				var option = $("<option value='"+item[i].getElementsByTagName("orgCd")[0].firstChild.data+"'>"+item[i].getElementsByTagName("orgdownNm")[0].firstChild.data+"</option>");
                $('#sido').append(option);
			}			
		}
	}
}


function sidochage(){
	if(httpRequest.readyState == 4){
		if(httpRequest.status == 200){
			
			var result = httpRequest.responseXML;
			var item = result.getElementsByTagName("item");
			
			$("select[id='sigungu'] option").remove();
			$('#sigungu').append("<option value=''>시군구</option>");
			
			for(var i = 0; i < item.length; i++) {
				var option = $("<option value='"+item[i].getElementsByTagName("orgCd")[0].firstChild.data+"'>"+item[i].getElementsByTagName("orgdownNm")[0].firstChild.data+"</option>");
                $('#sigungu').append(option);
			}	
			
		}
	}
}

function sigunguchage(){
	if(httpRequest.readyState == 4){
		if(httpRequest.status == 200){
			
			var result = httpRequest.responseXML;
			var item = result.getElementsByTagName("item");
			$("select[id='shelter'] option").remove();
			$('#shelter').append("<option value=''>보호센터</option>");
			
			for(var i = 0; i < item.length; i++) {
				var option = $("<option value='"+item[i].getElementsByTagName("careRegNo")[0].firstChild.data+"'>"+item[i].getElementsByTagName("careNm")[0].firstChild.data+"</option>");
                $('#shelter').append(option);
			}	
			
		}
	}
}

function kinduchage(){
	if(httpRequest.readyState == 4){
		if(httpRequest.status == 200){
			var result = httpRequest.responseXML;
			var item = result.getElementsByTagName("item");
			$("select[id='kindDetail'] option").remove();
			$('#kindDetail').append("<option value=''>품종(중)</option>");
			
			for(var i = 0; i < item.length; i++) {
				var option = $("<option value='"+item[i].getElementsByTagName("kindCd")[0].firstChild.data+"'>"+item[i].getElementsByTagName("KNm")[0].firstChild.data+"</option>");
                $('#kindDetail').append(option);
			}	
			
		}
	}
}

function serchResult(){
	if(httpRequest.readyState == 4){
		if(httpRequest.status == 200){
			var result = httpRequest.responseXML;
			var item = result.getElementsByTagName("item");
			//yugiList
			$("#yugiList").html('');
			
			for(var i = 0; i < item.length; i++) {
			
				var option = "<tr>";
					option += "		<th>";
					option += "			<img src='"+item[i].getElementsByTagName("filename")[0].firstChild.data+"' style='widows: 100%; max-height:10rem; max-width:7rem; height: 10rem; width:7rem; float: left; padding: 10px;'>";
					option += "			<li>공고번호 : "+item[i].getElementsByTagName("noticeNo")[0].firstChild.data+"</li>";
					option += "			<li>접 수 일  : "+item[i].getElementsByTagName("happenDt")[0].firstChild.data+"</li>";
					option += "			<li>품     종  : "+item[i].getElementsByTagName("kindCd")[0].firstChild.data+"</li>";
					option += "			<li>상     태  : "+item[i].getElementsByTagName("processState")[0].firstChild.data+"</li>";
					option += "		</th>";
					option += "		<th>";
					option += "			<img src='"+item[i+1].getElementsByTagName("filename")[0].firstChild.data+"' style='widows: 100%; max-height:10rem; max-width:7rem; height: 10rem; width:7rem; float: left; padding: 10px;'>";
					option += "			<li>공고번호 : "+item[i+1].getElementsByTagName("noticeNo")[0].firstChild.data+"</li>";
					option += "			<li>접 수 일  : "+item[i+1].getElementsByTagName("happenDt")[0].firstChild.data+"</li>";
					option += "			<li>품     종  : "+item[i+1].getElementsByTagName("kindCd")[0].firstChild.data+"</li>";
					option += "			<li>상     태  : "+item[i+1].getElementsByTagName("processState")[0].firstChild.data+"</li>";
					option += "		</th>";
					option += "</tr>"
					
					i = i + 1;
				
				$("#yugiList").append(option);
				
			}	
			
		}
	}
}

function searchList(){
	var params = "cmd=abandonmentPublic&bgnde="+$("#bgnde").val().replace(/-/g,"");
	params += "&endde="+$("#endde").val().replace(/-/g,"");		//검색일자
	params += "&upkind="+$("#kind option:selected").val();	//축종코드 품종(대)
	params += "&kind="+$("#kindDetail option:selected").val(); //품종(중)
	params += "&upr_cd="+$("#sido option:selected").val(); //시도
	params += "&org_cd="+$("#sigungu option:selected").val(); ///시군구
	params += "&care_reg_no="+$("#shelter option:selected").val(); //보호센터
	params += "&pageNo=1";
	
	
	sendRequest("/plzdaengs/yugi",params,serchResult,"GET");
	
}

$(function(){
	$('#sido').change(function(){
		var params = "cmd=sigungu&upr_cd="+this.value;
		sendRequest("/plzdaengs/yugi",params,sidochage,"GET");
	});
	
	$('#sigungu').change(function(){
		var params = "cmd=shelter&upr_cd="+$('#sido option:selected').val()+"&org_cd="+this.value;
		sendRequest("/plzdaengs/yugi",params,sigunguchage,"GET");
	});
	
	$('#kind').change(function(){
		var params = "cmd=kind&up_kind_cd="+this.value;
		sendRequest("/plzdaengs/yugi",params,kinduchage,"GET");
	});
	
	$('#btnSearch').click(function(){
		searchList();
	});
});

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
				<!-- 게시판뷰시작 -->
				<section class="py-5" style="max-height: none;">
					<div class="row">
						<div class="col-xl-12 col-lg-auto">
							<div class="card">
								<div class="card-header">
									<h6 class="text-uppercase mb-0">유기견 정보 게시판</h6>
								</div>
								<div class="card-body">
									<form class="form-horizontal">
										<!-- 날짜 -->
										<div class="form-group row">
												<label class="col-md-1 form-control-label">날짜</label>
												<div class="col-md-3">
													<input type='text' class="form-control datePicker" id="bgnde" name="bgnde" required="required"/>
													<label class="calendar-icon" target="bgnde"></label>
													
												</div>
												
												<div class="col-md-2">
													<label class="col-md-1 form-control-label">   ~  </label>
												</div>
												
												<div class="col-md-3">
													<input type='text' class="form-control datePicker" id="endde" name="endde" required="required"/>
													<label class="calendar-icon" target="endde"></label>
												</div>
										</div>
										<!-- 시도 -->
										<div class="form-group row">
											<label class="col-md-1 form-control-label">시도</label>
											<div class="col-md-2">
												<select id="sido" class="form-control" >
													<option value="">시도</option>
												</select>
											</div>
											<label class="col-md-1 form-control-label">시군구</label>
											<div class="col-md-2">
												<select id="sigungu" class="form-control">
													<option value="">시군구</option>
												</select>
											</div>

											<label class="col-md-2 form-control-label">보호센터</label>
											<div class="col-md-3">
												<select id="shelter" class="form-control">
													<option value="">보호센터</option>
												</select>
											</div>
										</div>

										<!-- 날짜 -->
										<div class="form-group row">
											<label class="col-md-1 form-control-label">품종</label>
											<div class="col-md-2">
												<select id="kind" class="form-control">
													<option value="">품종(대)</option>
													<option value="417000">개</option>
													<option value="422400">고양이</option>
													<option value="42990">기타</option>
												</select>
											</div>

											<div class="col-md-2">
												<select id="kindDetail" class="form-control">
													<option value="">품중(중)</option>
												</select>
											</div>
											<div class="col-md-3"></div>
											<button id="btnSearch" type="button" class="btn btn-primary">검색</button>

										</div>

										<div class="line"></div>
									</form>
								</div>
								<div class="card-body">
									<table class="table card-text col-xl-auto">
										<tbody id="yugiList">
										</tbody>
										<!-- 게시글목록끝 -->
									</table>
								</div>
							</div>
						</div>
					</div>
				</section>
				<!-- 게시판 뷰 끝 -->
			</div>
			<footer
				class="footer bg-white shadow align-self-end py-3 px-xl-5 w-100">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-6 text-center text-md-left text-primary">
							<p class="mb-2 mb-md-0">Your company &copy; 2018-2020</p>
						</div>
						<div class="col-md-6 text-center text-md-right text-gray-400">
							<p class="mb-0">
								Design by <a href="https://bootstrapious.com/admin-templates"
									class="external text-gray-400">Bootstrapious</a>
							</p>
							<!-- Please do not remove the backlink to us unless you support further theme's development at https://bootstrapious.com/donate. It is part of the license conditions. Thank you for understanding :)-->
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>
</body>
</html>