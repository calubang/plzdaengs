<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.register .input-group-prepend>button {
	width: inherit;
}

.register .form-control-label {
	font-size: 1.0rem;
	margin-top: auto;
	margin-bottom: auto;
}

.register .form-group input {
	font-size: 1.0rem;
}

.register .file-hidden {
	display: none;
}

.register label[for=ex_file] {
	border: 1px solid #4680ff;
	border-radius: 2rem;
	height: calc(2.25rem + 2px);
	line-height: calc(2.25rem + 2px);
	text-align: center;
	color: #4680ff;
}

.register label[for=ex_file]:hover {
	background-color: #4680ff;
	color: white;
}

.register .fileuploadimg {
	margin-left: 20px;
	max-width: 100px;
	max-height: 100px;
	padding: 0px;
}

.register .registerfileupload label, .register .registerfileupload input
	{
	margin-top: auto;
	margin-bottom: auto;
}

.register h3 {
	font-size: 1.5rem;
}
</style>
<script>
$(function() {
	$(".dropdown-item").click(dropdownItemClick);

	zipsearchWebSetting($(".registeraddress button"), $(".address input"));
	$(".registeraddress button").click(zipModalPopUp);
	$("input[type=file].file-hidden").change(fileUploadChange);

	fileDropDown();
	
	//회원가입
	$("button[type=submit]").click(memberjoinClick);
});

function memberjoinClick() {
	var id = $("input[name=id]").val();
	var password = $("input[name=password]").val();
	var passwordcheck = $("input[name=passwordcheck]").val();
	var emailid = $("input[name=emailid]").val();
	var emaildomain = $("input[name=emaildomain]").val();
	var nickname = $("input[name=nickname]").val();
	var tel = $("input[name=tel]").val();
	var gender = $("input[name=gender]").val();
	var zipcode = $("input[name=zipcode]").val();
	var address = $("input[name=address]").val();
	var addressdetail = $("input[name=addressdetail]").val();
	
	//필수 입력 확인
	if(id == null || id.length ==0){
		showAlertModal("필수값 입력 확인", "아이디를 입력하지 않으셨어요.");
		$("input[name=id]").focus();
		return false;
	}
	if(password == null || password.length ==0){
		showAlertModal("필수값 입력 확인", "비밀번호를 입력하지 않으셨어요.");
		$("input[name=password]").focus();
		return false;
	}
	if(passwordcheck == null || passwordcheck.length ==0){
		showAlertModal("필수값 입력 확인", "비밀번호를 입력하지 않으셨어요.");
		$("input[name=passwordcheck]").focus();
		return false;
	}
	if(emailid == null || emailid.length ==0){
		showAlertModal("필수값 입력 확인", "이메일을 입력하지 않으셨어요.");
		$("input[name=emailid]").focus();
		return false;
	}
	if(emaildomain == null || emaildomain.length ==0){
		showAlertModal("필수값 입력 확인", "이메일을 입력하지 않으셨어요.");
		$("input[name=emaildomain]").focus();
		return false;
	}
	if(nickname == null || nickname.length ==0){
		showAlertModal("필수값 입력 확인", "닉네임을 입력하지 않으셨어요.");
		$("input[name=nickname]").focus();
		return false;
	}
	
	memberjoin();
	
	return false;
}

function memberjoin() {
	alert("ajax 호출");
	var form = $(".register form")[0];
	console.log(form);
	var formData = new FormData(form);
	console.log(formData.get("id"));
	/* $.ajax({
		url : "memberjoin"
		, method : "post"
		, data : $("form").serialize()
		, success : function (result) {
			alert("success 실행 : " + result);
		}
	}); */
	
	$.ajax({
		url : "memberjoin"
		, method : "post"
		, processData : false
		, contentType : false
		, data : formData
		, success : function (result) {
			alert("success 실행 : " + result);
		}
	}); 
}

function fileDropDown() {
	var fileInputText = $(".registerfileupload input[type=text]");
	var fileInput = $(".registerfileupload input[type=file]");

	//드래그 한채로 들어오기
	fileInputText.on("dragenter", function(e) {
		e.stopPropagation();
		e.preventDefault();
		fileInputText.css("border-color", "#c6d8ff");
		fileInputText.css("box-shadow",
				"0 0 0 0.2rem rgba(70, 128, 255, 0.25)");
	});

	//드래그 한채로 나가기
	fileInputText.on("dragleave", function(e) {
		e.stopPropagation();
		e.preventDefault();
		fileInputText.css("border-color", "#ced4da");
		fileInputText.css("box-shadow", "");
	});
	//??
	fileInputText.on('dragover', function(e) {
		e.stopPropagation();
		e.preventDefault();
		fileInputText.css("border-color", "#c6d8ff");
		fileInputText.css("box-shadow",
				"0 0 0 0.2rem rgba(70, 128, 255, 0.25)");
	});

	//드래그 객체 놓기
	fileInputText.on('drop', function(e) {
		e.preventDefault();
		fileInputText.css("border-color", "#ced4da");
		fileInputText.css("box-shadow", "");

		var files = e.originalEvent.dataTransfer.files;

		if (files != null) {
			if (files.length < 1) {
				showAlertModal("이미지 업로드 경고", "잘못된 파일입니다.");
				return;
			}
			fileRegisterProcess(files);
		} else {
			showAlertModal("이미지 업로드 경고", "프로필 등록을 실패하였습니다.");
		}
	});
}

function fileRegisterProcess(files) {
	var fileInputText = $(".registerfileupload input[type=text]");
	var fileInput = $(".registerfileupload input[type=file]");
	var imgtag = $(".registerfileupload img");

	var fileName = files[0].name;
	imgtag.prop("src", "/plzdaengs/template/img/basic_user_profile.png");

	if (!(files[0].type.startsWith('image/'))) {
		alert(files[0].type);
		showAlertModal("이미지 업로드 경고", "올릴수 없는 확장자입니다.");
		return;
	}

	fileInput[0].files = files;
	fileName = fileInput[0].files[0].name;
	$(fileInputText[0]).val(fileName);
	
	var reader =new FileReader();
	reader.onload = function (e) {
		imgtag.prop("src", e.target.result);
	}
	reader.readAsDataURL(fileInput[0].files[0]);
}

function dropdownItemClick() {
	var text = $(this).text();
	$(this).parent().siblings("button").text(text);
	$(this).parent().siblings("input[type=hidden]").val(text);
}

function zipModalPopUp() {
	$("#doro").val("");
	$("#zipModal").modal("show");
}

function fileUploadChange() {
	var filename = this.files[0].name;
	var imgtag = $(this).siblings("img");
	imgtag.prop("src", "/plzdaengs/template/img/basic_user_profile.png");
	
	
	if (!this.files[0].type.startsWith("image/")) {
		this.files[0].value = "";
		showAlertModal("이미지 업로드 경고", "올릴수 없는 확장자입니다.");
		return;
	}

	imgtag.prop("src", "/plzdaengs/template/img/basic_user_profile.png");
	var reader =new FileReader();
	reader.onload = function (e) {
		imgtag.prop("src", e.target.result);
	}
	reader.readAsDataURL(this.files[0]);
	$(this).siblings("input[type=text]").val(filename);

}
</script>
<!-- section -->
<section class="register">
<!-- 경고창 모달 -->
<%@ include file="/template/alert_danger.jsp"%>
<!-- 우편번호 검색 모달 -->
<%@ include file="/template/zipsearchWeb.jsp"%>
	<div class="col-lg-10 mb-5">
		<div class="card">
			<div class="card-header">
				<h3 class="h6 text-uppercase mb-0">회원 가입</h3>
			</div>
			<div class="card-body">
				<form class="form-horizontal" enctype="multipart/form-data">
					<div class="form-group row registerid">
						<label class="col-md-3 form-control-label">아이디(*)</label>
						<div class="col-md-5">
							<input type="text" placeholder="아이디를 입력하세요"
								class="form-control" name="id">
						</div>
						<label class="col-md-2 form-control-label">아이디중복체크</label>
					</div>
					<div class="line"></div>
					<div class="form-group row registerpassword">
						<label class="col-md-3 form-control-label">비밀번호(*)</label>
						<div class="col-md-5">
							<input type="password" placeholder="비밀번호를 입력하세요"
								class="form-control" name="password">
						</div>
					</div>
					<div class="line"></div>
					<div class="form-group row registerpassword">
						<label class="col-md-3 form-control-label">비밀번호
							다시입력(*)</label>
						<div class="col-md-5">
							<input type="password" placeholder="비밀번호를 입력하세요"
								class="form-control" name="passwordcheck">
						</div>
						<label class="col-md-2 form-control-label">비밀번호 확인</label>
					</div>
					<div class="line"></div>
					<div class="form-group row registeremail">
						<label class="col-md-3 form-control-label">이메일(*)</label>
						<div class="col-md-3">
							<input type="text" placeholder="이메일을 입력하세요"
								class="form-control" name="emailid">
						</div>
						<label class="form-control-label text-label">@</label>
						<div class="input-group-prepend col-md-3">
							<input type="hidden" name="emaildomain" value="">
							<button type="button" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false"
								class="btn btn-outline-primary dropdown-toggle">이메일선택</button>
							<div class="dropdown-menu">
								<span class="dropdown-item">gmail.com</span> <span
									class="dropdown-item">naver.com</span> <span
									class="dropdown-item">daum.net</span>
							</div>
						</div>
					</div>
					<div class="line"></div>
					<div class="form-group row registernickname">
						<label class="col-md-3 form-control-label">닉네임(*)</label>
						<div class="col-md-5">
							<input type="text" placeholder="닉네임을 입력해주세요"
								class="form-control" name="nickname">
						</div>
					</div>
					<div class="line"></div>
					<div class="form-group row registerfileupload">
						<label class="col-md-3 form-control-label">프로필등록</label>
						<div class="col-md-9 input-group-prepend">
							<label for="ex_file" class="col-md-2">프로필선택</label> <input
								type="file" class="form-control file-hidden" id="ex_file"
								accept="image/*" name="imgdata"> 
								<input type="text" placeholder="파일을 등록해주세요" class="form-control col-md-5 "
								name="userimg" readonly> <img alt="" class="col-md-2 fileuploadimg"
								src="/plzdaengs/template/img/basic_user_profile.png">
						</div>
					</div>
					<div class="line"></div>
					<div class="form-group row registertel">
						<label class="col-md-3 form-control-label">전화번호</label>
						<div class="col-md-5">
							<input type="tel" placeholder="전화번호를 입력해주세요"
								class="form-control" name="tel">
						</div>
						<label class="col-md-2 form-control-label">(-)은 생략</label>
					</div>
					<div class="line"></div>
					<div class="form-group row registergender">
						<label class="col-md-3 form-control-label">성별</label>
						<div class="col-md-5">
							<div
								class="custom-control custom-radio custom-control-inline">
								<input id="genderfemaleradio" type="radio"
									class="custom-control-input" name="gender" value="F">
								<label for="genderfemaleradio" class="custom-control-label">여자</label>
							</div>
							<div
								class="custom-control custom-radio custom-control-inline">
								<input id="gendermaleradio" type="radio"
									class="custom-control-input" name="gender" value="M">
								<label for="gendermaleradio" class="custom-control-label">남자</label>
							</div>
						</div>
					</div>
					<div class="line"></div>
					<div class="form-group row registeraddress">
						<label class="col-md-3 form-control-label">주소</label>
						<div class="col-md-9">
							<input type="hidden" name="zipcode" value="">
							<button type="button"
								class="btn btn-outline-primary col-md-4">우편번호</button>
							<input type="text" placeholder="주소를 입력주세요"
								class="form-control" name="address" readonly> 
								<input type="text" placeholder="상세주소를 입력해주세요" class="form-control" name="addressdetail">
						</div>
					</div>
					<div class="line"></div>
					<div class="form-group row">
						<div class="col-md-9 ml-auto">
							<button type="reset" class="btn btn-primary">취소</button>
							<button type="submit" class="btn btn-primary">회원가입</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</section>