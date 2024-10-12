<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:forEach items="${airportList }" var="vo">
		<div class="airList" data-airportcode="${vo.airportCode }" >
			<ul>
				<li class="mb-2">
					<b class="airportCode">${vo.airportCode }</b> - <strong class="airportKor">${vo.airportKor}</strong> (<small class="airportEng">${vo.airportEng }</small>)
					<i class="fa fa-pencil airportUpdateBtn btn-light btn-sm" style="color:#E37027;"></i>
					<i class="fa fa-close airportDeleteBtn btn-light btn-sm" style="color:red;"></i>											
				</li>
			</ul>
		</div>
	</c:forEach>
	<button class="btn btn-outline-dark btn-sm mt-3 ml-4 airportAddBtn"> + 공항 추가 </button>