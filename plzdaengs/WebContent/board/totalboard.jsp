<%@page import="com.plzdaeng.dto.UserDto"%>
<%@page import="com.plzdaeng.board.model.BoardPage"%>
<%@page import="com.plzdaeng.board.model.PlzBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	List<PlzBoard> board = (List) request.getAttribute("boardList");
	BoardPage pageInfo = (BoardPage) request.getAttribute("boardPage");
	UserDto userDto = (UserDto)request.getSession().getAttribute("userInfo");
%>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Bubbly - Boootstrap 4 Admin template by Bootstrapious.com</title>
    <%@ include file="/template/default_link.jsp" %>
    <script src="/plzdaengs/board/js/httpRequest.js"></script>
  </head>
  <script type="text/javascript">
  	function searchList(){
		
  		$("#searchGubun").val($("#searchGubun2 option:selected").val());
  		$("#searchValue").val($("#searchValue2").val());
  		$("#curPage").val("1");
  		
  		
		document.getElementById("search").action = "/plzdaengs/plzBoard";
		document.getElementById("search").submit();
  	}
  	
  	function goDetail(post_id){
  		$("#post_id").val(post_id);
  		document.getElementById("detail").action = "/plzdaengs/plzBoard";
		document.getElementById("detail").submit();
  	}
  	
  
  </script>
<body>
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
					class="nav-link dropdown-toggle"><img src="/plzdaengs/template/img/avatar-6.jpg"
						alt="Jason Doe" style="max-width: 2.5rem;"
						class="img-fluid rounded-circle shadow"></a>
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

	<div class="d-flex align-items-stretch" id ="document">
		<!-- 사이드 sidebar -->
		<%@ include file="/template/sidebar.jsp" %>
		<!-- 사이드 sidebar -->
      
      <div class="page-holder w-100 d-flex flex-wrap">
        <div class="container-fluid px-xl-5" id="contents">
          <section class="py-5" style="max-height: none;">
            <div class="row"><!-- 여기 밑에 페이징 -->
              <div class=" col-lg-12 mb-4">
                <div class="card" style="min-width:40rem"><!-- 여기 끝에 글쓰기버튼 -->
                  <div class="card-header">
                    <h6 class="text-uppercase mb-0">게시판</h6>
                  </div>
                  <div class="card-body">
                    <table class="table table-hover card-text">
                      <thead>
                        <tr>
                          <th>No</th>
                          <th>카테고리</th>
                          <th colspan="5">제목</th>
                          <th>작성자</th>
                          <th>조회수</th>
                          <th>작성일</th>
                        </tr>
                      </thead>
                      <!--게시물 목록 반복문 실행될 곳-->
                      <tbody>
                        <%
                        	for(int i=0; i<board.size();i++){
                        %>
	                        <tr onclick="goDetail(<%=board.get(i).getPost_id() %>)">
	                          <th scope="row"><%=board.get(i).getNo() %></th>
	                          <td><%=board.get(i).getBoard_category_descripton() %></td>
	                          <td colspan="5"><%=board.get(i).getPost_subject() %></td>
	                          <td><%=board.get(i).getNickname() %></td>
	                          <td><%=board.get(i).getViews() %></td>
	                          <td><%=board.get(i).getCreat_date() %></td>
                        </tr>
                        <%} %>
                      </tbody>
                    </table>
                  </div>
                </div><!-- 여기 끝에 글쓰기버튼 -->
                <%if(userDto != null){ %>
                <button class="btn btn-primary" type="button" style="background-color: #dc3545; float: right; padding: 0.2rem 0.8rem;">
                	<a href="/plzdaengs/plzBoard?cmd=boardWrite">글쓰기</a>
                </button>
                <%} %>
              </div>
              <!-- 사용할 게시판 끝과 사용안할것  -->
            </div><!-- 여기 끝에 페이징처리 -->
            <div class="form-group row mb-4" style="margin-left: 10%;">
              <select id="searchGubun2" class="form-control col-md-1">
                    <option value="1">제목</option>
                    <option value="2">작성자</option>
              </select>
              <input type="text" id="searchValue2" class="form-control col-md-7" style="margin-left:1rem;margin-right:4rem;">
              <button type="button" class="btn btn-primary" onclick="searchList()">검색하기</button>
            </div>
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"><!-- 페이징 -->
			<nav>
				<ul class="pagination" style="margin-left: 30%;">
					<% if(pageInfo.getCurBlock() > 1 ){ %>
					<li class="page-item">
						<a class="page-link" href="#">Previous</a>
					</li>
					<%} 
					
						for(int i = pageInfo.getBlockBegin(); i <=pageInfo.getBlockEnd() ; i++){
							if(i == pageInfo.getCurPage()){
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
						
						if(pageInfo.getCurBlock() <= pageInfo.getTotalBlock()){ %>
					<li class="page-item">
						<a class="page-link" href="#">Next</a>
					</li>
					<%} %>
				</ul>
			</nav>
		</div>
		<form id="search" method="get" action="">
			<input type="hidden" name="searchValue" id="searchValue" value="">
			<input type="hidden" name="searchGubun" id="searchGubun" value="">
			<input type="hidden" name="curPage" id="curPage" value="">
			<input type="hidden" name="cmd" id="cmd" value="boardList">
		</form>
		
		<form id="detail" method="post" action="">
			<input type="hidden" name="post_id" id="post_id" value="">
			<input type="hidden" name="cmd" id="cmd" value="detail">
		</form>
            
          </section>
        </div>
        <%@ include file="/template/footer.jsp" %>
      </div>
    </div>
    <%@ include file="/template/default_js_link.jsp" %>
  </body>
</html>