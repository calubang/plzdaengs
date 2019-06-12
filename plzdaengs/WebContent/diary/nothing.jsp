<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!-- 파일 경로 가져오기
파일업로드<input type="file" id="fileup1" onchange="document.getElementById('filetext1').value=this.value;" />
실제 값<input type="text" id="filetext1" />
-->

<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script>
$(document).ready(function(){
  $("button").click(function(){
    $("#btn").text($("form").serialize());
  });
});
</script>
</head>
<body>

<form action="">
  First name: <input type="text" name="FirstName" value="Mickey"><br>
  Last name: <input type="text" name="LastName" value="Mouse"><br>
</form>

<button>Serialize form values</button>

<div id = "btn"></div>

</body>
</html>
