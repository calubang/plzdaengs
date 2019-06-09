<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Calendar</title>
	<%@ include file="/template/default_link.jsp"%>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.diary.min.js"></script>

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
        initDate(); // 날짜 초기화할것
        drawDays();
        $("#movePrevMonth").on("click", function(){movePrevMonth();});
        $("#moveNextMonth").on("click", function(){moveNextMonth();});
        //$("table.calendar").on("click", function(){cellClick();}); // 달력별 셀 클릭했을 때 나타나는 event
        /*
        $("table.calendar").on("click", function(sView, dSelectedDate, bIsAllDay, pClickedAt){
        	alert('달력클릭');
        	console.log("Cell Click했슈 : " + dSelectedDate);  // [1]
			showModal(true, dSelectedDate);		
        	}); // 달력별 셀 클릭했을 때 나타나는 event
        */	
        
        /*
        	$("#table tbody tr" + " tr:gt(0)").find("td:eq(3)").mouseover( function() { 
        		alert("이벤트 실행되었습니다."); alert(this.parentNode.rowIndex - 1); 
        		});
		*/
		
        $('table tbody td').mouseover(function() {
        	//alert('올려놨슈');
            $(this).children().css({
                'backgroundColor' : '#DCDCDC',
                'cursor' : 'pointer'
            });
        }).mouseout(function() { // 그 순간 움직일 때
        	//alert('내려놨슈');
            $(this).children().css({
                'backgroundColor' : '#FFFFFF',
                'cursor' : 'default'
            }); // $(this).children().css끝
        });
		$('table tbody td').click(function() { // table td 클릭할 때
			// 1. 클릭하면 모달나오게 해야함 > 일정 등록하는거
			
			
			var cellText = $(this).text();  
			alert(cellText + '일 click!'); // 위에 .html하면 관련 식 나오고 text해야 date나옴
        	//alert(cellText);
        	var a = document.body.firstChild.nextSibling.nextSibling.nodeName;
        	//alert(a); // nodeType : 1, nodeName : DIV 뜨는디
        	
        	//showModal(true, dSelectedDate);
        })
        
        
        
    });
    
    /*
    function cellClick() { // 잠시 block
		alert('테이블 셀클릭햇쇼');
		console.log("Cell Click했슈 : " + dSelectedDate) 
		showModal(true, dSelectedDate);	
		//console.log('완료');
	}
    */
    
    
    function showModal(bIsAllDay, dStartDateTime){
    	console.log("showModal : " + bIsAllDay + "//" + dStartDateTime); //[2] : 위에서 이미 true라고 하니까 true라고 찍히는거
    	$("#modal-form").modal('show');
    		
    	$("#ipTitle, #ipDesc").val("");
    	$("#ipAllDay").prop("checked", bIsAllDay);
    			
    	var dEndDateTime, sStartDateTime, sEndDateTime;
    	
    	/* 필요없는 기능
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
    	*/
    			
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
    
    //calendar 그리기
    function drawCalendar(){
        var setTableHTML = "";
        setTableHTML+='<table class="calendar" id = "calendar">';
        setTableHTML+='<tr><th>SUN</th><th>MON</th><th>TUE</th><th>WED</th><th>THU</th><th>FRI</th><th>SAT</th></tr>';
        for(var i=0;i<6;i++){
            setTableHTML+='<tr height="100">';
            for(var j=0;j<7;j++){
                setTableHTML+='<td style="text-overflow:ellipsis;overflow:hidden;white-space:nowrap">';
                setTableHTML+='    <div class="cal-day" id = "cal-day" ondrop="drop(event)" ondragover="allowDrop(event)"></div>';
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
		$(dataTemp).css("width", "40px");
		$(dataTemp).css("height", "40px");
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