<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<c:forEach items="${baggageTypeList }" var="vo">
	<option value="0">수하물 선택</option>
	<option value="${vo.baggageTypeID }">${vo.baggage_Type}</option>
</c:forEach>

<c:forEach items="${baggageTypeList }" var="vo">
	<option value="0">수하물 종류 선택</option>
	<option value="${vo.exampleID }">${vo.exampleName}</option>
</c:forEach>
	  
	  