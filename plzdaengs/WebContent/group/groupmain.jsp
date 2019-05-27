<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/template/default_link.jsp" %>
  <style>
    .card-header{
    padding: 10px;
    }
    .card-body{
    padding: 10px;
    }
    </style>
<script>
$(function(){
	
	var createBtn = $("input[name=creategroup]");
	$(createBtn).click(function(){
		alert("소모임생성");
		$.ajax({
			url:"",
			method:"get",
			success:function(result){
				alert("생성완료");
				
			}
		});
		
		
		
		
	});
	
	
});


</script>
</head>
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
			<div class="container-fluid" id="contents">

				<section class="py-5">
	
	 <div class="row mb-4">
              <div class="col-lg-8 mb-4 mb-lg-0">
              <!-- 소모임검색창 -->
             	 <div class="searchgroup">
	             	 <form>
		             	 <select name="searchoption">
		             	 <option>소모임 이름</option>
		             	 <option>소모임 지역</option>
		             	 <option>키워드</option>
		             	 </select>
		             	 <input type="text" name="searchword" size="50"><button type="submit" class="btn btn-secondary">검색</button>
		             	 <button type="button" data-toggle="modal" data-target="#myModal" class="btn btn-primary">소모임생성</button>
	             	 </form>
	             	 </div>
		             	 <!-- creategroup(modal) -->
		             	 <div id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" class="modal fade text-left">
                      <div role="document" class="modal-dialog">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h4 id="exampleModalLabel" class="modal-title">소모임 생성</h4>
                            <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
                          </div>
                          <div class="modal-body">
                            <p>다른 사람들과 함께하고싶은 소모임을 만들어보세요.</p>
                            <form>
                              <div class="form-group">
                                <label>소모임 이름</label>
                                <input type="text" placeholder="소모임 이름을 입력하세요." class="form-control">
                              </div>
                              <div class="line"></div>
		                      <div class="form-group">
		                        <label class="col-md-3 form-control-label">소모임 키워드</label>
		                        <div class="col-md-9">
		                          <label class="checkbox-inline">
		                            <input id="inlineCheckbox1" type="checkbox" value="option1"> 산책
		                          </label>
		                          <label class="checkbox-inline">
		                            <input id="inlineCheckbox2" type="checkbox" value="option2"> 지식공유
		                          </label>
		                          <label class="checkbox-inline">
		                            <input id="inlineCheckbox3" type="checkbox" value="option3"> 모임
		                          </label>
		                          <label class="checkbox-inline">
		                            <input id="inlineCheckbox4" type="checkbox" value="option4"> 기타
		                            <input id="inlinecheckbox5" type="text"value="">
		                          </label>
		                        </div>
                   			   </div>
                              <div class="line"></div>
                              <div class="form-group">       
                                <label>소모임 소개</label>
                                <input type="text" placeholder="소모임을 소개하세요." class="form-control"><br>
                                <textarea class="form-control" rows="3" cols="3" placeholder="소모임을 소개하세요."></textarea>
                              </div>
                              <div class="line"></div>
                              <div class="form-group">       
                                <div ><label>지역</label></div>
                                <div style="inline:right;">
                                <select>
                             		<option>서울</option>
                             		<option>경기</option>
                             		<option>부산</option>
                             		<option>대구</option>
                                </select>
                                <select>
                             		<option>강북구</option>
                             		<option>중구</option>
                             		<option>강서구</option>
                             		<option>구로구</option>
                                </select>
                                <label><input type="checkbox">지역무관</label>
                                </div>
                                
                              </div>
                               <div class="line"></div>
                            </form>
                          </div>
                          <div class="modal-footer">
                                     
                            <input name="creategroup" type="submit" value="소모임생성" class="btn btn-primary">
                            <input type="button" value="취소" class="btn btn-primary">
                                                         
                          
                            
                          </div>
                        </div>
                      </div>
                    </div>
             	 
             	 <!-- 가입한소모임 -->
             	 <div><label style="text-align:center">내가 가입한 소모임</label>
             	 </div>
               	 <div class="card">
                 	<div class="card-header">
                  <h2 class="h6 text-uppercase mb-0" style="font-size: large;">펫과 함께하는 한강산책</h2>
                  	</div>
                  	<div class="card-body" style="padding: 10;">
                  	<img style="display:inline;float:left;" src="/plzdaengs/group/img/001.jpg" width="80" height="80" >
                    <p class="mb-5 text-gray" style="display:inline;float:left">매주 목요일 펫들과 함께 즐거운 한강산책, 같이하실분들 모여요!</p>
                    <div style="display:inline;float:right">
                    <div><label>지역 : </label>동대문구</div>
                    <div><label>인원 : </label>100명</div>
                    <div><label>키워드 : </label>산책</div>
               		</div>
                	</div>
            	 </div>
            	  <div class="card">
                 	<div class="card-header">
                    <h2 class="h6 text-uppercase mb-0" style="font-size: large;">집사들의 지식공유커뮤니티</h2>
                  	</div>
                  	<div class="card-body">
                  	<img style="display:inline;float:left;" src="plzdaengs/group/img/001.jpg" width="80" height="80">
                    <p class="mb-5 text-gray" style="display:inline;float:left">집사들이 똑똑해야 내 주인이 건강하다<br>집사들이여 모여라</p>
                    <div style="display:inline;float:right">
                    <div><label>지역 : </label>동대문구</div>
                    <div><label>인원 : </label>100명</div>
                    <div><label>키워드 : </label>지식공유</div>
               		</div>
               		</div>
           		 </div>
           		 <div>페이징처리를 위한 공간1</div>
            	 <!-- 추천소모임 -->
              	 <div><label >회원님께 추천하는 소모임</label>
           		 </div> 

				 <div class="card">
                 	<div class="card-header">
                    <h2 class="h6 text-uppercase mb-0" style="font-size: large;">집사들의 지식공유커뮤니티</h2>
                  	</div>
                  	<div class="card-body">
                  	<img style="display:inline;float:left;" src="plzdaengs/group/img/001.jpg" width="80" height="80">
                    <p class="mb-5 text-gray" style="display:inline;float:left">집사들이 똑똑해야 내 주인이 건강하다<br>집사들이여 모여라</p>
                    <div style="display:inline;float:right">
                    <div><label>지역 : </label>동대문구</div>
                    <div><label>인원 : </label>100명</div>
                    <div><label>키워드 : </label>지식공유</div>
               		</div>
               		</div>
           		 </div>
           		  <div class="card">
                 	<div class="card-header">
                    <h2 class="h6 text-uppercase mb-0" style="font-size: large;">집사들의 지식공유커뮤니티</h2>
                  	</div>
                  	<div class="card-body">
                  	<img style="display:inline;float:left;" src="plzdaengs/group/img/001.jpg" width="80" height="80">
                    <p class="mb-5 text-gray" style="display:inline;float:left">집사들이 똑똑해야 내 주인이 건강하다<br>집사들이여 모여라</p>
                    <div style="display:inline;float:right">
                    <div><label>지역 : </label>동대문구</div>
                    <div><label>인원 : </label>100명</div>
                    <div><label>키워드 : </label>지식공유</div>
               		</div>
               		</div>
           		 </div>
        		</div>
       		 </div>
       		 <div>페이징처리를 위한 공간2</div>
	
				</section>
			</div>
			<%@ include file="/template/footer.jsp" %>
		</div>
	</div>
	<%@ include file="/template/default_js_link.jsp" %>
</body>
</html>