<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="user" value="${sessionScope.userInfo}"></c:set>
<div id="sidebar" class="sidebar py-3">
	<a href="#" class="sidebar-toggler text-gray-500 mr-4 mr-lg-5 lead"><i
		class="fas fa-align-left" id="toggle"></i></a>
	<a href="index.html"
		class="navbar-brand font-weight-bold text-uppercase"></a>
	<c:choose>
		<c:when test="${empty user}">
		<div
		class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family"
		id="profile"></div>
		</c:when>
		<c:otherwise>
		<div
		class="text-gray-400 text-uppercase px-3 px-lg-4 py-4 font-weight-bold small headings-font-family"
		id="profile" style="background-image: url('${user.user_img}')"></div>
		</c:otherwise>
	</c:choose>
	<ul class="sidebar-menu list-unstyled">
		<li class="nav-item dropdown mr-3"><a id="notifications"
			href="http://example.com" data-toggle="dropdown" aria-haspopup="true"
			aria-expanded="false"
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
			href="http://example.com" data-toggle="dropdown" aria-haspopup="true"
			aria-expanded="false" class="nav-link dropdown-toggle"><img
				src="/plzdaengs/template/img/avatar-6.jpg" alt="Jason Doe"
				style="max-width: 2.5rem;" class="img-fluid rounded-circle shadow"></a>
			<div aria-labelledby="userInfo" class="dropdown-menu">
				<a href="#" class="dropdown-item"><strong
					class="d-block text-uppercase headings-font-family">이름</strong> <small>반려견
						주인</small></a>
				<div class="dropdown-divider"></div>
				<a href="#" class="dropdown-item">회원 정보</a><a href="#"
					class="dropdown-item"> 활동 내역 </a>
				<div class="dropdown-divider"></div>
				<c:if test="${!empty user}">
				<a href="/plzdaengs/userlogout" class="dropdown-item">로그아웃</a>
				</c:if>
			</div></li>

		<li class="sidebar-list-item"><a href="/plzdaengs/index.jsp"
			class="sidebar-link text-muted active"> <i
				class="o-home-1 mr-3 text-gray"></i> <span>홈으로</span>
		</a></li>
		<c:if test="${!empty user}">
		<li class="sidebar-list-item">
			<a href="#" data-toggle="collapse" data-target="#info" aria-expanded="false" aria-controls="info"
			class="sidebar-link text-muted"><i
				class="far fa-user mr-3 text-gray"></i><span>마이페이지</span></a>
			<div id="info" class="collapse">
				<ul class="sidebar-menu list-unstyled border-left border-primary border-thick">
					<li class="sidebar-list-item">
						<a href="/plzdaengs/menu?act=usermodify" class="sidebar-link pl-lg-5">회원정보</a>
					</li>
					<li class="sidebar-list-item">
						<a href="/plzdaengs/menu?act=animals" class="sidebar-link pl-lg-5">반려동물 정보</a>
					</li>
					<c:if test="${user.authority == 'A'}">
					<li class="sidebar-list-item">
						<a href="/plzdaengs/menu?act=admin" class="sidebar-link pl-lg-5">관리자 페이지</a>
					</li>
					</c:if>
				</ul>
			</div>
		</li>
		</c:if>
			
		<!-- 윤영 PART > 기존의 다이어리 → table 모여있는 화면으로 가려면 tables.html을 보시오 -->
		<li class="sidebar-list-item">
			<a href="/plzdaengs/diary/calendar.jsp" class="sidebar-link text-muted">
				<i class="far fa-calendar-alt mr-3 text-gray"></i>
				<span>다이어리</span>
			</a>
		</li>
				
		<li class="sidebar-list-item"><a href="#" data-toggle="collapse"
			data-target="#group" aria-expanded="false" aria-controls="group"
			class="sidebar-link text-muted"><i
				class="fas fa-child mr-3 text-gray"></i><span>소모임</span></a>
			<div id="group" class="collapse">
				<ul
					class="sidebar-menu list-unstyled border-left border-primary border-thick">
					<li class="sidebar-list-item"><a href="/plzdaengs/group/groupmain.jsp"
						class="sidebar-link pl-lg-5">소모임메인</a></li>
					<li class="sidebar-list-item"><a href="#"
						class="sidebar-link pl-lg-5">소모임일정</a></li>
					<li class="sidebar-list-item"><a href="#"
						class="sidebar-link pl-lg-5">공지?게시판?</a></li>
				</ul>
			</div></li>
		<li class="sidebar-list-item"><a href="/plzdaengs/board/yugi.jsp"
			class="sidebar-link text-muted"><i
				class="far fa-heart mr-3 text-gray"></i><span>유기견</span></a></li>
		<li class="sidebar-list-item"><a href="/plzdaengs/plzBoard?cmd=boardList&curPage=1"
			class="sidebar-link text-muted"><i
		class="far fa-comment-dots mr-3 text-gray"></i><span>게시판</span></a></li>
	
		<c:if test="${!empty user}">
		<li class="sidebar-list-item"><a
			href="/plzdaengs/userlogout" class="sidebar-link text-muted"><i
				class="o-exit-1 mr-3 text-gray"></i><span>로그아웃</span></a></li>
		</c:if>
	</ul>

	<!--
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
			-->
</div>