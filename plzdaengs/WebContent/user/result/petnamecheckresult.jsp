<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${requestScope.result == 0}">가능한 이름입니다</c:when>
	<c:otherwise>같은 이름으로 등록된 반려동물이 있습니다</c:otherwise>
</c:choose>
