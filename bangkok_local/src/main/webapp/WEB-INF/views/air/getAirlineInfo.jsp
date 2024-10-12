<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript" src="/js/priceAddComma.js"></script>
	<table class="table text-center">
		<tr>
			<th style="width:40%;">운항 노선 수</th>
			<td>${info.routes }</td>
		</tr>
		<tr>
			<th>보유 기종 수</th>
			<td>${info.flights }</td>
		</tr>
		<tr>
			<th>금일 운항</th>
			<td>${info.todaySchedule }</td>
		</tr>
		<tr>
			<th>운항 예정</th>
			<td>${info.preSchedule }</td>
		</tr>
		<tr>
			<th>운항 종료</th>
			<td>${info.endSchedule }</td>
		</tr>
		<tr>
			<th>총 운항 수</th>
			<td>${info.allSchedule }</td>
		</tr>
	</table>