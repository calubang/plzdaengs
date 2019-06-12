<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageBean" value="${requestScope.pageBean}"></c:set>
<script>
$(function(){
	$(".pagenumber").click(function(){
		if($(this).text() != ${pageBean.currentPage}){
			$("nav>ul>li>a[href=boardlist]").trigger("click", $(this).text());
		}
		return false;
	});
	
	$(".pageprev").click(function() {
		//이전으로
		if(${pageBean.startPage} != 1){
			$("nav>ul>li>a[href=boardlist]").trigger("click", ${pageBean.startPage-1});
		}
		return false;
	});
	
	$(".pagenext").click(function() {
		//다음으로
		if(${pageBean.endPage} != ${pageBean.maxPage}){
			$("nav>ul>li>a[href=boardlist]").trigger("click", ${pageBean.endPage+1});
		}
		return false;
	});
	
	$(".repboard table tbody tr").click(function() {
		
		var boardseq = $(this).find("td[name=board_seq]").text();
		//alert(boardseq);
		$.ajax({
			url : "boarddetail"
			, data : {
				boardseq : boardseq
			}
			, success : function() {
				alert("응답옴");
			}
		});
	});
});
</script>
<div>
	<ul class="pagination">
	  	<c:if test="${pageBean.startPage != 1}">
	  	</c:if>
	  	<li class="page-item"><a class="page-link pageprev" href="#">이전</a></li>
	  	
	 	<c:forEach begin="${pageBean.startPage}" end="${pageBean.endPage}" step="1" var="pagenumber">
	 		<c:choose>
	 		<c:when test="${pageBean.currentPage == pagenumber}">
	 			<li class="page-item active">
	 				<a class="page-link pagenumber" href="#">${pagenumber}</a>		
	 			</li>
	 		</c:when>	
	 		<c:otherwise>
	 			<li class="page-item">
	 				<a class="page-link pagenumber" href="#">${pagenumber}</a>		
	 			</li>
	 		</c:otherwise>		
	 		</c:choose>
	 	</c:forEach>
	  	<li class="page-item"><a class="page-link pagenext" href="#">다음</a></li>
	  	<c:if test="${pageBean.endPage != pageBean.maxPage}">
		</c:if>
	</ul>
</div>