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
	.body {
	background-image: url('diary/img/footprint.png');
	}
	
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
	$("#realmodal").modal('show').css({
	    'margin-top': function () { //vertical centering
	        return -($(this).height() / 2);
	    },
	    'margin-left': function () { //Horizontal centering
	        return -($(this).width() / 2);
	    }
	});


	$(document).ready(function() { // 아예 시작할 때
        $("#submit").on("click", function(){
        	// [1] servlet 이동 : 해결
            var str = $("#form").serialize();
            alert('str : ' + str);
			// file은 직렬화 안됨.. 
            $.ajax({
              type:"POST",
              url:"/plzdaengs/diary",
              contentType: "application/x-www-form-urlencoded; charset=utf-8",
              data: str,
              datatype:"json",
              success: function(data) {
                alert("ajax 성공 : " + data.result);			
              },
              error: function(e) {
                alert("ajax 실패 : 에러가 발생하였습니다.");
              }			
            });
        	
        	// [2]
        	var input1 = document.getElementById('title').value;
        	
        	var schedule = cell.siblings(".cal-schedule")[0];
        	var element = $(document.createElement("div")); // div element 만들꺼얌
        	
        	element.attr("class", "schedule");
        	element.text(input1);
        	element.click(scheduleClick);
        	
        	$(schedule).append(element);
        	alert('등록되었습니다 : ' + input1);
        	
        	$("#enroll #title").val("");
        	$("#enroll #ipDesc").val("");
			$('#enroll').modal("hide");
        });
	});
	
	function scheduleClick() {
		$('#enroll').modal("show");
		$("#enroll #title").val($(this).text());
	}
	
	function register() {
		if(document.getElementById("title").value == "") {
			alert("다이어리 제목을 입력하세요.");
			$('#enroll').modal("show");
			return;
		} else {
			
		}
	}
	
</script>
</head>
<body>
<!-- 
	Calendar 날짜 클릭했을시에 모달창 FE 
	original : <form method = "get" action = "/plzdaengs/diary/mparam.jsp">
-->

<div id="enroll" class="modal fade">
	<div id = "realmodal" class="modal-dialog" width = "800">
		<div class="modal-content">
			<form id = "form">
				<div class="modal-header">다이어리 추가</div>
				<div class="modal-body">
					<!--div id="ipAlertTitle" class="alert alert-danger" role="alert">다이어리를 입력해주세요. </div-->
					<div id="ipTitle-group" class="form-group" align="left">
						<label for="ipTitle" >Title : </label>
						<input type="text" class="form-control" id="title" placeholder="Title" name="title">
					</div>
					<div id="ipDesc-group" class="form-group" align="left">
						<label for="ipDesc">Description : </label>
						<textarea class="form-control" rows="3" id="ipDesc" placeholder="Description" name="description"></textarea><br>
						<input type="file" id = "imgdata" name="imgdata" accept=".jpg,.jpeg,.png,.gif,.bmp">
					</div>					
				</div>
				<div class="modal-footer">
					<button type="button" class="button" data-dismiss="modal">Close</button>
					<button type=button class="button" id="submit">Submit</button>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>