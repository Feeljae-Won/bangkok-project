<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
	<form action="list.do" id="searchForm">
 	<input name="page" value="1" type="hidden">
  <div class="row">
  	<div class="col-md-8">
  		<div class="input-group mb-3">
		  <div class="input-group-prepend">
		      <select name="key" id="key" class="form-control">
		      	<option value="t">제목</option>
		      	<option value="c">내용</option>
		      	<option value="w">작성자</option>
		      	<option value="tc">제목/내용</option>
		      	<option value="tw">제목/작성자</option>
		      	<option value="cw">내용/작성자</option>
		      	<option value="tcw">모두</option>
		      </select>
		  </div>
		  <input type="text" class="form-control" placeholder="검색"
		   id="word" name="word" value="${pageObject.word }">
		  <div class="input-group-append">
		      <button class="btn btn-outline-primary">
		      	<i class="fa fa-search"></i>
		      </button>
		  </div>
		</div>
  	</div>
  	<div class="col-md-4">
  		너비를 조정하기 위한 div 추가. float-right : 오른쪽 정렬
  		<div style="width: 200px;" class="float-right">
		  <div class="input-group mb-3">
		    <div class="input-group-prepend">
		      <span class="input-group-text">Rows/Page</span>
		    </div>
		    <select id="perPageNum" name="perPageNum" class="form-control">
		    	<option>10</option>
		    	<option>15</option>
		    	<option>20</option>
		    	<option>25</option>
		    </select>
		  </div>
	  </div>
  	</div>
  </div>
 </form>