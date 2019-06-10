<%@page import="com.plzdaeng.group.model.GroupDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/template/default_link.jsp" %>

<% GroupDto dto = (GroupDto)request.getAttribute("groupdetail");
System.out.println(dto);%>
<script>
$(function(){

	var form = $('form');
	form.submit(function(){
		$.ajax({
			url:'/plzdaengs/groupfront',
			method:"POST",
			data:$(this).serialize(),
			success:function(result){
				var result = request.getAttribute("result");
				if(result == 1){
				alert("인포변경");
				$("section").html();
				}
			}
			
			
		});
		return false;
	});


	var deleteBtn = $('#deletegroup');
	$(deleteBtn).click(function(){
		$("#deletegroupmodal").modal('show');
		
	});


});
</script>
</head>
<body>
<!-- <div id="deletegroupmodal" tabindex="-1" role="dialog" 
		aria-labelledby="exampleModalLabel" aria-hidden="true"
		class="modal fade text-left">
		<div role="document" class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					
					<button type="button" data-dismiss="modal" aria-label="Close"
						class="close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
				<h4 id="exampleModalLabel" class="modal-title">소모임을 탈퇴하시겠습니까?</h4>
						<input type="hidden" name="act" value="creategroup">
					
				</div>
				<div class="modal-footer">
					<input name="joingroup" type="submit" value="탈퇴"
						class="btn btn-primary"> <input name="modalcancel"
						type="button" data-dismiss="modal" value="취소"
						class="btn btn-primary">
				</div>
			</div>
		</div>
	</div> -->


          <div>
          <Button onclick="location.href='/plzdaengs/group/managegroupinfo.jsp'">소모임 정보변경</Button>
          <Button onclick="location.href='/plzdaengs/group/managemeeting.jsp'">소모임 일정관리</Button>
          <Button onclick="location.href='/plzdaengs/group/managemember.jsp'">소모임원 관리</Button>
          </div>
            <div class="row">
              <!-- Form Elements -->
              <div class="col-lg-12 mb-5">
                <div class="card">
                  <div class="card-header">
                    <h3 class="h6 text-uppercase mb-0">소모임 정보변경</h3>
                  </div>
                  <div class="card-body">
                    <form class="form-horizontal">
                      <div class="form-group row">
                      <input type="hidden" name="act" value="changedetail"/>
                      <input type="hidden" name="group_id" value="<%= dto.getGroup_id() %>"/>
                        <label class="col-md-3 form-control-label" >소모임 이름</label>
                        <div class="col-md-9">
                        <input name="group_name" type="text" class="form-control" readonly="readonly" style="width: 70%" value="<%= dto.getGroup_name() %>">
                        <div class="invalid-feedback ml-3">소모임 이름은 수정할 수 없습니다.</div>
                        </div>
                      </div>
                      <div class="line"></div>
                     <div class="form-group row">
		                        <label class="col-md-3 form-control-label">소모임 키워드</label>
		                        <div class="col-md-9">
		                          <label class="checkbox-inline">
		                            <input name="group_cate" type="text" class="form-control" readonly="readonly" style="width: 70%" value="<%=dto.getGroupCategory().getGroup_category_name() %>">
		                          </label>
		                        </div>
                   			   </div>
                      <div class="line"></div>
                       <div class="form-group row"> 
                                <label class="col-md-3 form-control-label">소모임 소개</label>
                                <div class="col-md-9">
                                <textarea name="group_description" class="form-control" style="width: 70%"><%=dto.getGroup_description() %></textarea>
                            </div>
                              </div>
                      <div class="line"></div>
                   <div class="form-group row">       
                                <label class="col-md-3 form-control-label">지역</label>
							<div class="col-md-9">
                                <select name="group_sido">
                             		<option ><%=dto.getAddress_sido() %></option>
                                </select>
                                <select name="group_sigungu">
                             		<option ><%=dto.getAddress_sigungu() %></option>
                                </select>
                                <label><input name="groupdontselect" type="checkbox">지역무관</label>
                               </div>
                              </div>
                      <div class="line"></div>
                       <div class="form-group row">
                               <label class="col-md-3 form-control-label">소모임 대표이미지</label>
                               <div class="col-md-9">
                               <input name="groupimg" type="file" value="<%=dto.getGroup_img() %>">
                               </div>
                               </div>
                      <div class="line"></div>
                          <button style="background-color: red;float: left;" name="deletegroup" type="button" class="btn btn-secondary">소모임 해체</button>
                          <button style="float: right;" type="submit" class="btn btn-primary">취소</button>
                          <button style="float: right;" type="submit" class="btn btn-primary">변경</button>
                    </form>
                  </div>
                </div>
              </div>
            </div>

	<%@ include file="/template/default_js_link.jsp" %>
</body>
</html>