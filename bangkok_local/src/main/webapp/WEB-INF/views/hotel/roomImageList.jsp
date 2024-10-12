<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:forEach items="${roomImageList}" var="roomImageVO">
	<img src="${roomImageVO.room_image_name}"
		class="smallImage img-thumbnail" alt="호텔 이미지">
</c:forEach>