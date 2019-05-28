<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(function() {
	$("#alert button[name=alertOK]").click(function () {
		$("#alert").modal("hide");
	});
});
function showAlertModal(title, body, footer) {
	//아짓 footer는 고려안함..
	$("#alert .modal-title").html(title);
	$("#alert .modal-body>p").html(body);
	$("#alert").modal("show");
}
</script>
<style>
#alert .modal-dialog{
	margin-top: 15%;
}
</style>
<!-- 경고창 -->
<div class="modal fade" id="alert" role="dialog">
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
				<button type="button" class="btn btn-danger" name="alertOK">확인</button>
			</div>
		</div>
	</div>
</div>