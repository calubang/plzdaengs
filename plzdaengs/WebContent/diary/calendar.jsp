<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String title = request.getParameter("title");
	String description = request.getParameter("description");
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Calendar</title>
	<%@ include file="/template/default_link.jsp"%>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.diary.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.bundle.js"></script>

<style type="text/css">
	#div1 {
	  width: 1000px;
	  height: 100px;
	  padding: 10px;
	  border: 1px solid #aaaaaa;
	  margin-left: 500px;
	}
	
	.cal-day{
	/*
		background-color: black;
	*/
	}
	.cal_top{
	    text-align: center;
	    font-size: 30px;
	}
	
	.cal{
	    text-align: center;    
	}
	
	table.calendar .cal-schedule{
	/*
		1. 이 부분이 일정등록 클릭할 부분
	*/
		min-height : 55px;
		font-size: medium;
	}
	
	table.calendar{
	/*
		1. 캘린더 위치설정
		2. 달력 칸칸별 넓혀놓고 > border: thin solid black; 지워놓기
	*/
	    margin-left: 500px; 
	    margin-top: 100px;
	    display: inline-table;
	    text-align: left;
	}
	
	table.calendar td{
	    vertical-align: top;
	    height : 50px;
	    width: 150px;
	}
	
	.schedule:hover{
		border: 1px solid black;
		cursor: pointer;
	}
</style>

<script type="text/javascript">
    var today = null;
    var year = null;
    var month = null;
    var firstDay = null;
    var lastDay = null;
    var $tdDay = null;
    var $tdSche = null;
    var cellText = null;
    var cell = null;
 
    $(document).ready(function() { // 아예 시작할 때
    	//sendRequest("/plzdaengs/plzDiary", params, callback, "GET");

        drawCalendar();
        initDate(); // 날짜 초기화할것
        drawDays();
        
        var a = $("#attr").html();
    	console.log(a);
    	//$(".cal-schedule").html('<div>'+ a + '</div>');
    	//alert('가져온 값 : ' + a);
    	
        $("#movePrevMonth").on("click", function(){movePrevMonth();});
        $("#moveNextMonth").on("click", function(){moveNextMonth();});
        $('table tbody td').mouseover(function() {
        	//alert('올려놨슈');
            $(this).children().css({
                'backgroundColor' : '#DCDCDC',
                'cursor' : 'pointer'
            });
        }).mouseout(function() { // 그 순간 움직일 때
        	//alert('내려놨슈');
            $(this).children().css({
                'backgroundColor' : '#F8F9FB',
                'cursor' : 'default'
            }); // $(this).children().css끝
        });
        
		$('table tbody td div.cal-day').click(function(e) { // table td 클릭할 때
			
			// 1. 클릭하면 모달나오게 해야함 > 일정 등록하는거
			cellText = $(this).text().trim(); // ★★★★★★★★★ 몇번째 꺼인지 
			cell = $(this);
			console.log(cell);
			console.log(cellText);
			
			alert(cellText + '일 click!'); // 위에 .html하면 관련 식 나오고 text해야 date나옴
			//request.setAttribute("cellText", cellText);
			
			// 보내야함.. https://codeday.me/ko/qa/20190321/115067.html
			//e.originalEvent.dataTransfer.setData("cellText", cellText);
			
			$("#enroll").modal();
        }) // td클릭시 function 끝
        
        $('table tbody td div.cal-schedule').click(function() {
        	// 2. 밑에 스케줄쪽 클릭하면 편집할 수 있어야
			//alert('div.cal-schedule 클릭 > modal 연결');
			//$("#enroll").modal(); // 근데 이거 submit하기 전이얌 그니까 당연히 null이뜸
			//console.log('[1] modal창 넘어감');
        })
        
        
    });
    
    /*
    function cellClick() { // 잠시 block
		alert('테이블 셀클릭햇쇼');
		console.log("Cell Click했슈 : " + dSelectedDate) 
		showModal(true, dSelectedDate);	
		//console.log('완료');
	}
    
    
    
    function showModal(bIsAllDay, dStartDateTime){
    	console.log("showModal : " + bIsAllDay + "/" + dStartDateTime); //[2] : 위에서 이미 true라고 하니까 true라고 찍히는거
    	$("#modal-form").modal('show');
    		
    	$("#ipTitle, #ipDesc").val("");
    	$("#ipAllDay").prop("checked", bIsAllDay);
    			
    	var dEndDateTime, sStartDateTime, sEndDateTime;
    	
    	
    	if(bIsAllDay) {
    		dEndDateTime = new Date(dStartDateTime);
    		dEndDateTime.setDate(dStartDateTime.getDate() + (oCal1.setting.allDayEventDuration - 1));
    				
    		sStartDateTime = oCal1.getDateInFormat({"date": dStartDateTime}, "dd-MM-yyyy", false, false);
    		sEndDateTime = oCal1.getDateInFormat({"date": dEndDateTime}, "dd-MM-yyyy", false, false);
    	} else {
    		dEndDateTime = new Date(dStartDateTime.getTime() + (oCal1.setting.eventDuration * 6E4));
    				
    		sStartDateTime = oCal1.getDateInFormat({"date": dStartDateTime}, "dd-MM-yyyy HH:mm", oCal1.setting.is24Hour, false);
    		sEndDateTime = oCal1.getDateInFormat({"date": dEndDateTime}, "dd-MM-yyyy HH:mm", oCal1.setting.is24Hour, false);
    	}
    	
    			
    	console.log(sEndDateTime + "  " + sEndDateTime); // [3]
    	$("#ipStart").val(sStartDateTime);
    	$("#ipEnd").val(sEndDateTime);
    	validateAllDayChecked();
    }
    
    function validateAllDayChecked() {
    	console.log("validateAllDayChecked " + ($("#ipAllDay").is(':checked')));
    	if($("#ipAllDay").is(':checked')){
    		$("#ipStart-group label").html("Start Date : ");
    		$("#ipEnd-group label").html("End Date : ");
    				
    		$("#ipStart, #ipEnd").data("field", "date");
    				
    		var sDateTimeRegex = /^([0-3]{1}[0-9]{1})(-([0-1]{1}[0-9]{1}))(-([0-9]{4}))(\s)([0-2]{1}[0-9]{1}):([0-6]{1}[0-9]{1})/;
    		var sDateTimeStart = $("#ipStart").val(),
    		sArrDateTimeStart = sDateTimeStart.match(sDateTimeRegex),
    		sDateTimeEnd = $("#ipEnd").val(),
    		sArrDateTimeEnd = sDateTimeEnd.match(sDateTimeRegex);
    		
    		if(sArrDateTimeStart != null)
    			$("#ipStart").val(sDateTimeStart.split(" ")[0]);
    		if(sArrDateTimeEnd != null)
    			$("#ipEnd").val(sDateTimeEnd.split(" ")[0]);
    	} else {
    		$("#ipStart-group label").html("Start Date Time : ");
    		$("#ipEnd-group label").html("End Date Time : ");
    				
    		$("#ipStart, #ipEnd").data("field", "datetime");
    				
    		var sDateTimeRegex = /^([0-3]{1}[0-9]{1})(-([0-1]{1}[0-9]{1}))(-([0-9]{4}))(\s)([0-2]{1}[0-9]{1}):([0-6]{1}[0-9]{1})/;
    		var sDateTimeStart = $("#ipStart").val(),
    		sArrDateTimeStart = sDateTimeStart.match(sDateTimeRegex),
    		sDateTimeEnd = $("#ipEnd").val(),
    		sArrDateTimeEnd = sDateTimeEnd.match(sDateTimeRegex);
    		console.log("Arrays : " + sDateTimeStart + " " + sDateTimeEnd);
    		console.log(sArrDateTimeStart);
    		console.log(sArrDateTimeEnd);
    			if(sArrDateTimeStart == null)
    				$("#ipStart").val(sDateTimeStart + " 00:00");
    			if(sArrDateTimeEnd == null)
    				$("#ipEnd").val(sDateTimeEnd + " 00:00");
    			}
    } 
    */
    
    //calendar 그리기
    function drawCalendar(){
    	
        var setTableHTML = "";
        
        //var a = $("#attr").html();
    	//console.log('drawCalendar()에서 받아옴 : '+ a);
    	//var insert = '<div>'+ a +'</div>'
    	//console.log(insert);
    	//console.log(cellText);
    	
        setTableHTML+='<table class="calendar" id = "calendar">';
        setTableHTML+='<tr><th>SUN</th><th>MON</th><th>TUE</th><th>WED</th><th>THU</th><th>FRI</th><th>SAT</th></tr>';
        for(var i=0;i<6;i++){
            setTableHTML+='<tr height="100">';
            for(var j=0;j<7;j++){
                setTableHTML+='<td style="text-overflow:ellipsis;overflow:hidden;white-space:nowrap">';
                setTableHTML+='    <div class="cal-day" id = "cal-day" ondrop="drop(event)" ondragover="allowDrop(event)"></div>'; // day 써있는곳에 놓기
                setTableHTML+='    <div class="cal-schedule"></div>';
                setTableHTML+='</td>';
            }
            setTableHTML+='</tr>';
        }
        setTableHTML+='</table>';
        $("#cal_tab").html(setTableHTML);
        
    }
 
	//날짜 초기화
    function initDate(){
        $tdDay = $("td div.cal-day")
        $tdSche = $("td div.cal-schedule")
        dayCount = 0;
        today = new Date();
        year = today.getFullYear();
        month = today.getMonth()+1;
        firstDay = new Date(year,month-1,1);
        lastDay = new Date(year,month,0);
        
    }
    
	//calendar 날짜표시
    function drawDays(){
        $("#cal_top_year").text(year);
        $("#cal_top_month").text(month);
        for(var i=firstDay.getDay();i<firstDay.getDay()+lastDay.getDate();i++){
            $tdDay.eq(i).text(++dayCount);
        }
        for(var i=0;i<42;i+=7){
            $tdDay.eq(i).css("color","red");
            //$tdDay.eq(i).css("background","red");
        }
        for(var i=6;i<42;i+=7){
            $tdDay.eq(i).css("color","blue");
        }
    }
 
    //calendar 월 이동
    function movePrevMonth(){
        month--;
        if(month<=0){
            month=12;
            year--;
        }
        
        if(month<10){
            month=String("0"+month);
        }
        
        getNewInfo();
        }
    
    function moveNextMonth(){
        month++;
        if(month>12){
            month=1;
            year++;
        }
        
        if(month<10){
            month=String("0"+month);
        }
        
        getNewInfo();
    }

    
    function getNewInfo(){
        for(var i=0;i<42;i++){
            $tdDay.eq(i).text("");
        }
        dayCount=0;
        firstDay = new Date(year,month-1,1);
        lastDay = new Date(year,month,0);
        drawDays();

    }
</script>

<!-- DRAG & DROP -->
<script>
	function allowDrop(ev) { 
		ev.preventDefault();
	} 
	
	function drag(ev) { 
		//var a = $('#attr').text();
		//console.log(a);
		ev.dataTransfer.setData("text", ev.target.id); // img용
		
	}
	
	function drop(ev) {
		var a = $('#attr').text();
		console.log('1!!!' + a);
		
		ev.preventDefault();
		var data = ev.dataTransfer.getData("text");
		console.log(data);
		
		var dataTemp = document.getElementById(data).cloneNode();
		console.log(dataTemp);
		$(dataTemp).css("width", "40px");
		$(dataTemp).css("height", "40px");
		$(dataTemp).css("font-size", "small");
		$(dataTemp).click(function(e) {
			alert("이모티콘 클릭해또");
		});
		ev.target.appendChild(dataTemp); // 이모티콘 붙일 때 없어지지 않고 남아있기
	}
</script>

</head>

<body>
<div class="d-flex align-items-stretch" id ="document">
<%@ include file="/template/sidebar.jsp" %>
<section>
    <div class="cal_top">
    	<!-- 모달모달 -->
    	<%@ include file="modal.jsp"%>
        <a href="#" id="movePrevMonth"><span id="prevMonth" class="cal_tit">&lt;</span></a>
        <span id="cal_top_year"></span>
        <span id="cal_top_month"></span>
        <a href="#" id="moveNextMonth">
        <span id="nextMonth" class="cal_tit">&gt;</span>
        </a>
		<div id="cal_tab" class="cal" ></div>
		<div id="cal_image" style="margin-left: 200px;">
			<img id="drag1" src="img/hospital.png" draggable="true" ondragstart="drag(event)" width="50px" height="50px"> &nbsp;&nbsp;&nbsp;&nbsp;
			<img id="drag2" src="img/bones.png" draggable="true" ondragstart="drag(event)" width="50px" height="50px"> &nbsp;&nbsp;&nbsp;&nbsp;
			<img id="drag3" src="img/dog.png" draggable="true" ondragstart="drag(event)" width="50px" height="50px"> &nbsp;&nbsp;&nbsp;&nbsp;
			<img id="drag4" src="img/bath.png" draggable="true" ondragstart="drag(event)" width="50px" height="50px"> &nbsp;&nbsp;&nbsp;&nbsp;
			<img id="drag5" src="img/facial-treatment.png" draggable="true" ondragstart="drag(event)" width="50px" height="50px"> &nbsp;&nbsp;&nbsp;&nbsp;
			<img id="drag6" src="img/school.png" draggable="true" ondragstart="drag(event)" width="50px" height="50px"> &nbsp;&nbsp;&nbsp;&nbsp;
			<img id="drag7" src="img/pet-house.png" draggable="true" ondragstart="drag(event)" width="50px" height="50px">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<img id="bin" src="img/bin.png" width="50px" height="50px" ondrop="delete(event)" ondragover="allowDrop(event)">
		</div>
    </div>
</section>
 </div>

 
</body>
</html>