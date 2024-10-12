<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:forEach items="${email }" var="vo">
		<option value="${vo.email }">${vo.email } (${vo.nickName })</option>
	</c:forEach>