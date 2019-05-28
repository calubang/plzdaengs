<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
function showSuccessAlertModal(title, body, footer) {
	//아짓 footer는 고려안함..
	$("#alertSuccess .modal-title").html(title);
	$("#alertSuccess .modal-body>p").html(body);
	$("#alertSuccess").modal("show");
}
</script>
<style>
#alertSuccess .modal-dialog{
	margin-top: 15%;
}
</style>
<!-- 성공창 -->
<div class="modal fade" id="alertSuccess" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title"></h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<p></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" name="alertOK">확인</button>
			</div>
		</div>
	</div>
</div>