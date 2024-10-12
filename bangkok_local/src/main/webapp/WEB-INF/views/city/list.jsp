<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach items="${cityList }" var="vo">
	<div class="card mb-0 cityList" style="height:80px;">
		<div class="card-body" style="padding:10px;">
			<input type='hidden' value='${vo.cityNum}' id="cityNum" name="cityNum">
			<div class="img-thumbnail float-left">
				<img src="${vo.cityImg}" alt="cityImg" width="50" height="50">
			</div>
			<div class="float-left" id="tripPlace"
				style="width: 50%; margin-left: 10px;">
				<p style="font-weight:bold; font-size:15px;">${vo.cityName}, ${vo.countryKor}</p>
			</div>
		</div>
	</div>
</c:forEach>
