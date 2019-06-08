<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Calendar</title>
	<%@ include file="/template/default_link.jsp"%>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<style type="text/css">
#div1 {
  width: 1000px;
  height: 100px;
  padding: 10px;
  border: 1px solid #aaaaaa;
  margin-left: 500px;
}

.cal_top{
    text-align: center;
    font-size: 30px;
}

.cal{
    text-align: center;    
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
</style>

<script type="text/javascript">
    
    var today = null;
    var year = null;
    var month = null;
    var firstDay = null;
    var lastDay = null;
    var $tdDay = null;
    var $tdSche = null;
 
    $(document).ready(function() { // 아예 시작할 때
        drawCalendar();
        initDate();
        drawDays();
        $("#movePrevMonth").on("click", function(){movePrevMonth();});
        $("#moveNextMonth").on("click", function(){moveNextMonth();});
        $("table.calendar").on("click", function(){cellClick();}); // 달력별 셀 클릭했을 때 나타나는 event
    });
    
    function cellClick() {
		alert('테이블 셀클릭햇쇼');
		console.log("Cell Click했슈 : " + dSelectedDate);
		showModal(true, dSelectedDate);	
		//console.log('완료');
	}
    
    
    function showModal(bIsAllDay, dStartDateTime){
    	console.log("showModal : " + bIsAllDay + " " + dStartDateTime);
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
    			
    	console.log(sEndDateTime + "  " + sEndDateTime);
    	$("#ipStart").val(sStartDateTime);
    	$("#ipEnd").val(sEndDateTime);
    	validateAllDayChecked();
    }
    
    //calendar 그리기
    function drawCalendar(){
        var setTableHTML = "";
        setTableHTML+='<table class="calendar">';
        setTableHTML+='<tr><th>SUN</th><th>MON</th><th>TUE</th><th>WED</th><th>THU</th><th>FRI</th><th>SAT</th></tr>';
        for(var i=0;i<6;i++){
            setTableHTML+='<tr height="100">';
            for(var j=0;j<7;j++){
                setTableHTML+='<td style="text-overflow:ellipsis;overflow:hidden;white-space:nowrap">';
                setTableHTML+='    <div class="cal-day"></div>';
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

<script>
	// DRAG & DROP 오예!
	function allowDrop(ev) { ev.preventDefault();} 
	function drag(ev) { ev.dataTransfer.setData("text", ev.target.id); }
	function drop(ev) {
		ev.preventDefault();
		var data = ev.dataTransfer.getData("text");
		//console.log(data);
		
		var dataTemp = document.getElementById(data).cloneNode();
		$(dataTemp).css("width", "50px");
		$(dataTemp).css("height", "50px");
		$(dataTemp).click(function(e) {
			alert("거북이 클릭");
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
        <a href="#" id="movePrevMonth"><span id="prevMonth" class="cal_tit">&lt;</span></a>
        <span id="cal_top_year"></span>
        <span id="cal_top_month"></span>
        <a href="#" id="moveNextMonth">
        <span id="nextMonth" class="cal_tit">&gt;</span>
        </a>
		<div id="cal_tab" class="cal" ondrop="drop(event)" ondragover="allowDrop(event)"></div>
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