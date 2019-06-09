<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

/*
.modal-content {
	background-color: fuchsia;
}
*/
.button {
	color : white;
	font-size : large;
    background-color: lightcoral;
    border-color: #ccc;
}
.modal-dialog {
    max-width: 800px;
    margin: 1.75rem auto;
}
.form-group {
	font-size: medium;
}

</style>
<script type="text/javascript">
$("#enroll").modal('show').css({
    'margin-top': function () { //vertical centering
        return -($(this).height() / 2);
    },
    'margin-left': function () { //Horizontal centering
        return -($(this).width() / 2);
    }
});
</script>
</head>
<body>
<!-- Calendar 날짜 클릭했을시에 모달창 FE -->
<div id="enroll" class="modal fade">
	<div class="modal-dtpicker"></div>
	<div class="modal-dialog" width = "800">
		<div class="modal-content">
			<form>
				<div class="modal-header">다이어리 추가</div>
				<div class="modal-body">
					<!--div id="ipAlertTitle" class="alert alert-danger" role="alert">다이어리를 입력해주세요. </div-->
					<div id="ipTitle-group" class="form-group" align="left">
						<label for="ipTitle" >Title : </label>
						<input type="text" class="form-control" id="ipTitle" placeholder="Title">
					</div>
					<div id="ipDesc-group" class="form-group" align="left">
						<input type="file" class="form-control file-hidden" id="ex_file" accept="image/*" name="imgdata">
						<label for="ipDesc">Description : </label>
						<textarea class="form-control" rows="3" id="ipDesc" placeholder="Description"></textarea><br>
					</div>					
				</div>
				<div class="modal-footer">
					<button type="button" class="button" data-dismiss="modal">Close</button>
					<button type="button" class="button" id="submit" >Submit</button>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>