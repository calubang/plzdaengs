<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/template/default_link.jsp" %>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0/dist/Chart.min.js"></script>
<script type="text/javascript">
$(function() {
	var donutCanvas = $("#donutChart");
	var myChart = new Chart(donutCanvas, {
		type : "doughnut"
		, data : {
			labels: ["강", "아", "지"]
			, datasets :[{
				label: "시츄"
				, backgroundColor: [
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	            ]
		        , borderColor: [
	                'rgba(255, 99, 132, 1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
	            ]
				, data : [12, 19, 3]
			}]
		}
		, options : {
			animateRotate : true
		}
	});
});
</script>
</head>
<body>
	<!-- navbar-->	
	<%@ include file="/template/header.jsp" %>
	<div class="d-flex align-items-stretch" id ="document">
		<!-- 사이드 sidebar -->
		<%@ include file="/template/sidebar.jsp" %>
		<!-- 사이드 sidebar -->
		<div class="page-holder w-100 d-flex flex-wrap">
			<div class="container-fluid" id="contents">
				<!-- 로그인 시 뜨는 경고창 -->
				<%@ include file="/template/alert_danger.jsp" %>
				<!-- section 1 -->
				<section class="py-5">
					<div class="col-lg-10 mb-4 mb-lg-0">
						<div class="card">
							<div class="card-header">
								<h2 class="h6 text-uppercase mb-0">Line chart Example</h2>
							</div>
							<div class="card-body">
								<p class="mb-5 text-gray">여기에 차트를 해볼까 하는데</p>
								<div class="chart-holder mt-5 mb-5">
									<canvas id="donutChart"></canvas>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
			<%@ include file="/template/footer.jsp" %>
		</div>
	</div>
	<%@ include file="/template/default_js_link.jsp" %>
</body>
</html>