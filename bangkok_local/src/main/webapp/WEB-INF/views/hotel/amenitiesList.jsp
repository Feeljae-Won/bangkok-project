<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach items="${amenities}" var="vo">
	<div class="form-check mb-2 mr-sm-2">
		<label>
		<input type="checkbox" class="form-control"  
			name="amenitiesNo" value="${vo.amenitiesNo }">
			${vo.amenitiesName }
		</label>
	</div>
</c:forEach>
