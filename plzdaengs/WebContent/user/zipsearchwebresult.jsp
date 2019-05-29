<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
$(function(){
	$(".zipcode").click(zipcodeClick);
	$(".lnmAdres").click(lnmAdresClick);
	$(".rnAdres").click(rnAdresClick);
});

function rnAdresClick() {
	var tr = $(this).parent().siblings("tr")[0];
	selectZip($(tr).find(".zipcode").text(), $(this).text());
}
function lnmAdresClick() {
	selectZip($(this).siblings(".zipcode").text(), $(this).text());
}
function zipcodeClick() {
	selectZip($(this).text(), $(this).siblings(".lnmAdres").text());
}
</script>
<c:set var="result" value="${requestScope.zipsearchwebresult}"></c:set>
<x:parse var="doc" xml="${result}"></x:parse>
<x:set var="totalCount" select="$doc/NewAddressListResponse/cmmMsgHeader/totalCount" />
<x:set var="totalPage" select="$doc/NewAddressListResponse/cmmMsgHeader/totalPage" />
<x:set var="currentPage" select="$doc/NewAddressListResponse/cmmMsgHeader/currentPage" />
<x:set var="countPerPage" select="$doc/NewAddressListResponse/cmmMsgHeader/countPerPage" />
<table class="table-bordered text-center">
	<thead>
		<tr>
			<th style="width: 150px;">우편번호</th>
			<th style="width: 600px;">주소</th>
		</tr>
	</thead>
	<tbody id="zip_codeList">
	<x:forEach select="$doc/NewAddressListResponse/newAddressListAreaCdSearchAll">
		<tr>
			<td rowspan="2" class="zipcode"><x:out select="zipNo"/></td>
			<td class="lnmAdres"><x:out select="lnmAdres"/></td>
		</tr>
		<tr>
			<td class="rnAdres"><x:out select="rnAdres"/></td>
		</tr>
	</x:forEach>
	</tbody>
</table>
<ul class="pagination" style="padding-left: 30%">
  	<li class="page-item">
	<x:choose>
	  	<x:when select="currentPage>1">
	  	<a class="page-link prev" href="#">이전</a>
	  	</x:when>
	  	<x:otherwise>
	  	<a class="page-link prev no" href="#">이전</a>
	  	</x:otherwise>
	</x:choose>
	</li>
		
	<li class="page-item"><a class="page-link" href="#">1</a></li>
	<li class="page-item"><a class="page-link" href="#">2</a></li>
	<li class="page-item"><a class="page-link" href="#">3</a></li>

	<x:choose>
		<x:when select="$doc/NewAddressListResponse/cmmMsgHeader/currentPage<totalPage">
	  	<li class="page-item next"><a class="page-link" href="#">다음</a></li>
	  	</x:when>
	  	<x:otherwise>
	  	<li class="page-item next no"><a class="page-link" href="#">다음</a></li>
	  	</x:otherwise>
	</x:choose>
</ul>
