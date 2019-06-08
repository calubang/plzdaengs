 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <!-- Calendar 날짜 클릭했을시에 모달창 FE -->
<div id="modal-form" class="modal fade">
	<div class="modal-dtpicker"></div>
	<div class="modal-dialog">
		<div class="modal-content">
			<form>
				<div class="modal-header">다이어리 생성</div>
				<div class="modal-body">
					<div id="ipAlertTitle" class="alert alert-danger" role="alert">다이어리를 입력해주세요. </div>
					<div id="ipTitle-group" class="form-group">
						<label for="ipTitle">Title : </label>
						<input type="text" class="form-control" id="ipTitle" placeholder="Title">
					</div>
					<div id="ipAllDay-group" class="checkbox">
						<label>
							<input id="ipAllDay" type="checkbox" checked> All Day
						</label>
					</div>
					<div id="ipAlertStartEnd" class="alert alert-danger" role="alert">Start DateTime should be earlier than End DateTime</div>
			 		<div id="ipStart-group" class="form-group">
						<label for="ipStart">Start Date : </label>
						<input type="text" class="form-control" id="ipStart" data-field="date" placeholder="Start">
					</div>
					<div id="ipEnd-group" class="form-group">
						<label for="ipStart">End Date : </label>
						<input type="text" class="form-control" id="ipEnd" data-field="date" placeholder="End">
					</div>
					<div id="ipDesc-group" class="form-group">
						<label for="ipDesc">Description : </label>
						<textarea class="form-control" rows="3" id="ipDesc" placeholder="Description"></textarea><br>
					</div>					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default form-btn" data-dismiss="modal">Close</button>
					<button id="submit" type="button" class="btn btn-default form-btn">Submit</button>
				</div>
			</form>
		</div>
	</div>
</div>