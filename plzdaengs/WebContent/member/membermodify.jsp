<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/template/default_link.jsp"%>
<script type="text/javascript">
	$(function() {
		$(".dropdown-item").click(dropdownItemClick);

		zipsearchWebSetting($(".registeraddress button"), $(".address input"));
		$(".registeraddress button").click(zipModalPopUp);
		$("input[type=file].file-hidden").change(fileUploadChange);

		fileDropDown();
	});

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

		if (!(files[0].type.startsWith('image/'))) {
			showAlertModal("이미지 업로드 경고", "올릴수 없는 확장자입니다.");
			return;
		}

		fileInput[0].files = files;
		fileName = fileInput[0].files[0].name;
		$(fileInputText[0]).val(fileName);
		//

		imgtag.prop("src", "/plzdaengs/template/img/basic_user_profile.png");
		if (window.FileReader) {
			var reader = new FileReader();
			reader.onload = function(e) {
				var src = e.target.result;
				imgtag.prop("src", src);
			}
			reader.readAsDataURL(fileInput[0].files[0]);
		} else {
			fileInput[0].select();
			fileInput[0].blur();
			var imgSrc = document.selection.createRange().text;
			imgtag.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""
					+ imgSrc + "\")";
		}
	}

	function dropdownItemClick() {
		var text = $(this).text();
		$(this).parent().siblings("button").text(text);
	}

	function zipModalPopUp() {
		$("#doro").val("");
		$("#zipModal").modal("show");
	}

	function fileUploadChange() {
		var filename = this.files[0].name;
		var imgtag = $(this).siblings("img");
		imgtag.prop("src", "/plzdaengs/template/img/basic_user_profile.png");
		
		if (!($(this)[0].type.startsWith('image/'))) {
			$(this)[0].value = "";
			showAlertModal("이미지 업로드 경고", "올릴수 없는 확장자입니다.");
			return;
		}
		
		$(this).siblings("input[type=text]").val(filename);

		if (window.FileReader) {
			var reader = new FileReader();
			reader.onload = function(e) {
				var src = e.target.result;
				imgtag.prop("src", src);
			}
			reader.readAsDataURL($(this)[0].files[0]);
		} else {
			$(this)[0].select();
			$(this)[0].blur();
			var imgSrc = document.selection.createRange().text;
			//alert(imgSrc);
			imgtag.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""
					+ imgSrc + "\")";
		}
	}
</script>
<style type="text/css">
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
</head>
<body>
	<!-- 경고창 모달 -->
	<%@ include file="/template/alert_danger.jsp"%>
	<!-- 우편번호 검색 모달 -->
	<%@ include file="/template/zipsearchWeb.jsp"%>
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
					class="nav-link dropdown-toggle"><img
						src="/plzdaengs/template/img/avatar-6.jpg" alt="Jason Doe"
						style="max-width: 2.5rem;" class="img-fluid rounded-circle shadow"></a>
					<div aria-labelledby="userInfo" class="dropdown-menu">
						<a href="#" class="dropdown-item"><strong
							class="d-block text-uppercase headings-font-family">Mark
								Stephen</strong><small>Web Developer</small></a>
						<div class="dropdown-divider"></div>
						<a href="#" class="dropdown-item">Settings</a><a href="#"
							class="dropdown-item">Activity log </a>
						<div class="dropdown-divider"></div>
						<a href="/plzdaengs/login.html" class="dropdown-item">Logout</a>
					</div>
				</li>
			</ul>
		</nav>
	</header>

	<div class="d-flex align-items-stretch" id="document">
		<!-- 사이드 sidebar -->
		<%@ include file="/template/sidebar.jsp"%>
		<!-- 사이드 sidebar -->

		<div class="page-holder w-100 d-flex flex-wrap">
			<div class="container-fluid" id="contents">
				<!-- section 2 -->
				<section class="register">
					<div class="col-lg-10 mb-5">
						<div class="card">
							<div class="card-header">
								<h3 class="h6 text-uppercase mb-0">회원 정보</h3>
							</div>
							<div class="card-body">
								<form class="form-horizontal">
									<div class="form-group row registerid">
										<label class="col-md-3 form-control-label">아이디(*)</label>
										<div class="col-md-5">
											<input type="text" placeholder="아이디를 입력하세요"
												class="form-control" required>
										</div>
										<label class="col-md-2 form-control-label">아이디중복체크</label>
									</div>
									<div class="line"></div>
									<div class="form-group row registerpassword">
										<label class="col-md-3 form-control-label">비밀번호(*)</label>
										<div class="col-md-5">
											<input type="password" placeholder="비밀번호를 입력하세요"
												class="form-control" required>
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row registerpassword">
										<label class="col-md-3 form-control-label">비밀번호
											다시입력(*)</label>
										<div class="col-md-5">
											<input type="password" placeholder="비밀번호를 입력하세요"
												class="form-control" required>
										</div>
										<label class="col-md-2 form-control-label">비밀번호 확인</label>
									</div>
									<div class="line"></div>
									<div class="form-group row registeremail">
										<label class="col-md-3 form-control-label">이메일(*)</label>
										<div class="col-md-3">
											<input type="text" placeholder="이메일을 입력하세요"
												class="form-control" required>
										</div>
										<label class="form-control-label text-label">@</label>
										<div class="input-group-prepend col-md-3">
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
												class="form-control" required>
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row registerfileupload">
										<label class="col-md-3 form-control-label">프로필등록</label>
										<div class="col-md-9 input-group-prepend">
											<label for="ex_file" class="col-md-2">프로필선택</label> <input
												type="file" class="form-control file-hidden" id="ex_file"
												accept="image/*"> <input type="text"
												placeholder="파일을 등록해주세요" class="form-control col-md-5 "
												readonly> <img alt="" class="col-md-2 fileuploadimg"
												src="/plzdaengs/template/img/basic_user_profile.png">
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row registertel">
										<label class="col-md-3 form-control-label">전화번호</label>
										<div class="col-md-5">
											<input type="tel" placeholder="전화번호를 입력해주세요"
												class="form-control">
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
													class="custom-control-input" name="gender" value="female">
												<label for="genderfemaleradio" class="custom-control-label">여자</label>
											</div>
											<div
												class="custom-control custom-radio custom-control-inline">
												<input id="gendermaleradio" type="radio"
													class="custom-control-input" name="gender" value="male">
												<label for="gendermaleradio" class="custom-control-label">남자</label>
											</div>
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row registeraddress">
										<label class="col-md-3 form-control-label">주소</label>
										<div class="col-md-9">
											<button type="button"
												class="btn btn-outline-primary col-md-4">우편번호</button>
											<input type="text" placeholder="주소를 입력주세요"
												class="form-control" readonly> <input type="text"
												placeholder="상세주소를 입력해주세요" class="form-control">
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
				<!-- section 2 -->
				<section class="register">
					<div class="col-lg-10 mb-5">
						<div class="card">
							<div class="card-header">
								<h3 class="h6 text-uppercase mb-0">회원 가입</h3>
							</div>
							<div class="card-body">
								<form class="form-horizontal">
									<div class="line"></div>
									<div class="form-group row">
										<label class="col-md-3 form-control-label">Password</label>
										<div class="col-md-9">
											<input type="password" name="password" class="form-control">
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row">
										<label class="col-md-3 form-control-label">Placeholder</label>
										<div class="col-md-9">
											<input type="text" placeholder="placeholder"
												class="form-control">
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row">
										<label class="col-md-3 form-control-label">Ranges</label>
										<div class="col-md-9">
											<div>
												<label for="formControlRange">Example Range</label> <input
													id="formControlRange" type="range"
													class="form-control-range">
											</div>
											<div>
												<label for="customRange1">Custom Range</label> <input
													id="customRange1" type="range" class="custom-range">
											</div>
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row">
										<label class="col-md-3 form-control-label">Disabled</label>
										<div class="col-md-9">
											<input type="text" disabled=""
												placeholder="Disabled input here..." class="form-control">
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row">
										<label class="col-md-3 form-control-label">Checkboxes
											and radios <br> <small class="text-primary">Standard
												HTML elements</small>
										</label>
										<div class="col-md-9">
											<div>
												<input id="option" type="checkbox" value=""> <label
													for="option">Option one is this and that—be sure to
													include why it's great</label>
											</div>
											<div>
												<input id="optionsRadios1" type="radio" checked=""
													value="option1" name="optionsRadios"> <label
													for="optionsRadios1">Option one is this and that be
													sure to include why it's great</label>
											</div>
											<div>
												<input id="optionsRadios2" type="radio" value="option2"
													name="optionsRadios"> <label for="optionsRadios2">Option
													two can be something else and selecting it will deselect
													option one</label>
											</div>
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row">
										<label class="col-md-3 form-control-label">Inline
											checkboxes</label>
										<div class="col-md-9">
											<label class="checkbox-inline"> <input
												id="inlineCheckbox1" type="checkbox" value="option1">
												a
											</label> <label class="checkbox-inline"> <input
												id="inlineCheckbox2" type="checkbox" value="option2">
												b
											</label> <label class="checkbox-inline"> <input
												id="inlineCheckbox3" type="checkbox" value="option3">
												c
											</label>
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row">
										<label class="col-md-3 form-control-label">Checkboxes
											&amp; radios <br> <small class="text-primary">Bootstrap4
												custom controls</small>
										</label>
										<div class="col-md-9">
											<div class="custom-control custom-checkbox">
												<input id="customCheck1" type="checkbox"
													class="custom-control-input"> <label
													for="customCheck1" class="custom-control-label">Check
													this custom checkbox</label>
											</div>
											<div
												class="custom-control custom-radio custom-control-inline">
												<input id="customRadioInline1" type="radio"
													name="customRadioInline1" class="custom-control-input">
												<label for="customRadioInline1" class="custom-control-label">Toggle
													this custom radio</label>
											</div>
											<div
												class="custom-control custom-radio custom-control-inline">
												<input id="customRadioInline2" type="radio"
													name="customRadioInline1" class="custom-control-input">
												<label for="customRadioInline2" class="custom-control-label">Or
													toggle this other custom radio</label>
											</div>
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row">
										<label class="col-md-3 form-control-label">Select</label>
										<div class="col-md-9 select mb-3">
											<select name="account" class="form-control">
												<option>option 1</option>
												<option>option 2</option>
												<option>option 3</option>
												<option>option 4</option>
											</select>
										</div>
										<div class="col-md-9 ml-auto select">
											<select multiple="" class="form-control rounded">
												<option>option 1</option>
												<option>option 2</option>
												<option>option 3</option>
												<option>option 4</option>
											</select>
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row has-success">
										<label class="col-sm-3 form-control-label">Input with
											success</label>
										<div class="col-sm-9">
											<input type="text" class="form-control is-valid">
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row has-danger">
										<label class="col-sm-3 form-control-label">Input with
											error</label>
										<div class="col-sm-9">
											<input type="text" class="form-control is-invalid">
											<div class="invalid-feedback ml-3">Please provide your
												name.</div>
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row">
										<label class="col-md-3 form-control-label">Control
											sizing</label>
										<div class="col-md-9">
											<div class="form-group">
												<input type="text" placeholder=".input-lg"
													class="form-control form-control-lg">
											</div>
											<div class="form-group">
												<input type="text" placeholder="Default input"
													class="form-control">
											</div>
											<div class="form-group">
												<input type="text" placeholder=".input-sm"
													class="form-control form-control-sm">
											</div>
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row">
										<label class="col-md-3 form-control-label">Column
											sizing</label>
										<div class="col-md-9">
											<div class="row">
												<div class="col-md-3">
													<input type="text" placeholder=".col-md-3"
														class="form-control">
												</div>
												<div class="col-md-4">
													<input type="text" placeholder=".col-md-4"
														class="form-control">
												</div>
												<div class="col-md-5">
													<input type="text" placeholder=".col-md-5"
														class="form-control">
												</div>
											</div>
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row">
										<label class="col-md-3 form-control-label">Input
											groups</label>
										<div class="col-md-9">
											<div class="form-group">
												<div class="input-group mb-3">
													<div class="input-group-prepend">
														<span class="input-group-text">$</span>
													</div>
													<input type="text"
														aria-label="Dollar amount (with dot and two decimal places)"
														class="form-control">
												</div>
											</div>
											<div class="form-group">
												<div class="input-group">
													<input type="text"
														aria-label="Dollar amount (with dot and two decimal places)"
														class="form-control">
													<div class="input-group-append">
														<span class="input-group-text">$</span>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="input-group mb-3">
													<div class="input-group-prepend">
														<span class="input-group-text">$</span>
													</div>
													<input type="text"
														aria-label="Amount (to the nearest dollar)"
														class="form-control">
													<div class="input-group-append">
														<span class="input-group-text">.00</span>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="input-group mb-3">
													<div class="input-group-prepend">
														<div class="input-group-text">
															<input type="checkbox"
																aria-label="Checkbox for following text input">
														</div>
													</div>
													<input type="text" aria-label="Text input with checkbox"
														class="form-control">
												</div>
											</div>
											<div class="form-group">
												<div class="input-group">
													<div class="input-group-prepend">
														<div class="input-group-text">
															<input type="radio"
																aria-label="Radio button for following text input">
														</div>
													</div>
													<input type="text"
														aria-label="Text input with radio button"
														class="form-control">
												</div>
											</div>
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row">
										<label class="col-md-3 form-control-label">Button
											addons</label>
										<div class="col-md-9">
											<div class="form-group">
												<div class="input-group mb-3">
													<div class="input-group-prepend">
														<button id="button-addon1" type="button"
															class="btn btn-primary">Button</button>
													</div>
													<input type="text" placeholder=""
														aria-label="Example text with button addon"
														aria-describedby="button-addon1" class="form-control">
												</div>
											</div>
											<div class="form-group">
												<div class="input-group mb-3">
													<input type="text" placeholder="Recipient's username"
														aria-label="Recipient's username"
														aria-describedby="button-addon2" class="form-control">
													<div class="input-group-append">
														<button id="button-addon2" type="button"
															class="btn btn-primary">Button</button>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row">
										<label class="col-md-3 form-control-label">With
											dropdowns</label>
										<div class="col-md-9">
											<div class="input-group mb-3">
												<div class="input-group-prepend">
													<button type="button" data-toggle="dropdown"
														aria-haspopup="true" aria-expanded="false"
														class="btn btn-outline-primary dropdown-toggle">Dropdown</button>
													<div class="dropdown-menu">
														<a href="#" class="dropdown-item">Action</a><a href="#"
															class="dropdown-item">Another action</a><a href="#"
															class="dropdown-item">Something else here</a>
														<div role="separator" class="dropdown-divider"></div>
														<a href="#" class="dropdown-item">Separated link</a>
													</div>
												</div>
												<input type="text"
													aria-label="Text input with dropdown button"
													class="form-control">
											</div>
										</div>
									</div>
									<div class="line"></div>
									<div class="form-group row">
										<div class="col-md-9 ml-auto">
											<button type="submit" class="btn btn-secondary">Cancel</button>
											<button type="submit" class="btn btn-primary">Save
												changes</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</section>
			</div>
			<%@ include file="/template/footer.jsp"%>
		</div>
	</div>
	<%@ include file="/template/default_js_link.jsp"%>
</body>
</html>