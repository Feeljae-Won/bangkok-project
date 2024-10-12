<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav"  tagdir="/WEB-INF/tags"%>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>
<%
    // 현재 날짜를 JSP에서 구함
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(new Date());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 리스트</title>
<style>
   /* 기존 스타일 유지 */
   .lineDiv {
       background: #f2f2f2;
       padding: 10px;
       border-radius: 30px;
       margin-bottom: 10px;
       height: 150px;
       width: 350px;
       display: flex;
       align-items: center;
       justify-content: flex-start;
       overflow: hidden;
   }

   .rounded {
       margin-right: 20px;
       max-width: 100%;
       max-height: 100%;
       object-fit: cover;
   }

   .eventTitle {
       margin: 0;
       font-weight: bold;
   }

   .dateRange {
       color: #666;
   }

   .dataRow {
       display: inline-block;
       vertical-align: top;
       width: calc(33.333% - 30px);
       margin-right: 20px;
       margin-bottom: 20px;
   }

   .dataRow:hover {
       cursor: pointer;
   }

   .editDiv {
       display: none;
   }

   .no-events {
       display: none;
       text-align: center;
       padding: 20px;
       font-size: 1.2em;
       color: #888;
   }
</style>
<script type="text/javascript">
$(function(){
    // 공지사항 글 보기 이동 처리
   $(document).ready(function() {
       $(".dataRow").each(function(index) {
           if ((index + 1) % 3 === 0) {
               $(this).css('margin-right', '0');
           } else {
               $(this).css('margin-right', '40px');
           }
       });

       $(".dataRow").click(function(){
           let eventNo = $(this).data("event-no");
           location = "view.do?eventNo=" + eventNo+"&${pageObject.pageQuery}";
       });
   });
});
</script>
<script type="text/javascript">
   $(function(){
      let today = new Date(); // 현재 날짜를 구함
      
      function changeEvent(today){
          $(".dataRow").each(function() {
              // 각 이벤트의 종료일을 가져와서 Date 객체로 변환
              let endDate = new Date($(this).find(".endDay").text().trim());
              // 날짜 차이를 밀리초로 계산하고, 이를 일 단위로 변환
              let diffTime = endDate - today;
              let diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); // 밀리초 -> 일수로 변환
            
              // 차이가 5일 이내이면 '마감임박' 뱃지를 추가
              if (diffDays <= 5) {
                  $(this).find(".eventTitle").append('<span class="badge badge-danger">마감임박</span>');
              }
         
         });
      };      
      
      $("#Trip").click(function(){
         //alert("여행");
         $("#menu1").load("/ajax/getTrip.do");
      });
      $("#Hotel").click(function(){
         //alert("호텔");
         $("#menu2").load("/ajax/getHotel.do");
      });
      $(document).ready(function() {
          
          function removeBadges() {
              $(".badge-danger").remove(); // 기존에 추가된 '마감임박' 뱃지 제거
          }

          //다른 탭을 클릭할 때 뱃지를 초기화
          $(".nav-link").click(function() {
              removeBadges(); // 탭 변경 시 뱃지 초기화
              if($(this).attr("id") == "all") {
                 changeEvent(today);
              }
          });
          $(".dataRow").each(function() {
             
              // 각 이벤트의 종료일을 가져와서 Date 객체로 변환
              let endDate = new Date($(this).find(".endDay").text().trim());
              // 날짜 차이를 밀리초로 계산하고, 이를 일 단위로 변환
              let diffTime = endDate - today;
              let diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); // 밀리초 -> 일수로 변환
            
              // 차이가 5일 이내이면 '마감임박' 뱃지를 추가
              if (diffDays <= 5) {
                  $(this).find(".eventTitle").append('<span class="badge badge-danger">마감임박</span>');
              }
          });
      });
   });
   
</script>
<script type="text/javascript">
$(function(){
    $(".cate_edit").on("click", function() {         
        //수정 삭제 버튼이 안 보일때 - 버튼이 나타나야 한다.
        if($(this).next().css("display") == "none") {
           //전체 editDiv는 안 보이게 
           $(".editDiv").slideUp();
           //버튼이 나타나게
           $(this).next().slideDown();
           //수정 삭제 버튼이 보일때 - 버튼이 사라져야 한다.
        } else {
           //전체 editDiv는 안 보이게 
           $(".editDiv").slideUp();
           //버튼이 사라지게
           //$(this).next().slideUp();
        }
        return false; // a tag이 페이지 이동 처리를 무시시킨다.
     });
	// 대분류 수정 버튼
	$(".bigUpdateBtn").click(function(){
		// alert("대분류 수정 버튼");
		
		// 데이터 수집
		let categoryNo = $(this).closest("a").data("cate_no");
		let categoryName = $(this).closest("a").find(".categoryName").text();
		// alert("categoryNo=" + categoryNo + ", categoryName=" + categoryName);
		
		return categoryProcess("대분류 수정", categoryNo, categoryName,
				"categoryUpdate.do", "수정");

	});
	// 대분류 삭제 버튼
	$(".bigDeleteBtn").click(function(){
		// alert("대분류 삭제 버튼");
		
		// 데이터 수집
		let categoryNo = $(this).closest("a").data("cate_no");
		let categoryName = $(this).closest("a").find(".categoryName").text();
		// alert("cate_code1=" + cate_code1 + ", cate_name=" + cate_name);
		
		return categoryProcess("대분류 삭제", categoryNo, categoryName,
				"categoryDelete.do", "삭제");

	});	
	// 대분류 추가 버튼
	$("#bigWriteBtn").click(function(){
		// alert("대분류 추가");
		// a tag의 페이지 이동 처리를 무시시킨다.
		return categoryProcess("대분류 추가", 0, "", "categoryWrite.do", "추가");
	});
	function categoryProcess(title, categoryNo,categoryName, url, btnName){

		// 제목 변경
		$("#categoryModal").find(".modal-title").text(title);
		// category 데이터들은 전부 0이여야 한다.
		$("#modalCate_code1").val(categoryNo);
		$("#modalCate_name").val(categoryName);
		
		// 데이터를 보낼 url 세팅
		$("#modalForm").attr("action", url);
		
		// 버튼 이름 바꾸기
		$("#submitBtn").text(btnName);
		
		$("#categoryModal").modal("show");
		
		return false;
	}
});
</script>
    <script type="text/javascript">
        $(function(){
            $(".nav-link").click(function() {
                let targetId = $(this).attr("href");
                let targetPane = $(targetId);
                let noEventsDiv = $("#no-events");

                // 모든 tab-content를 숨기고 no-events div도 숨깁니다
                $(".tab-pane").hide();
                noEventsDiv.hide();

                // 클릭한 탭에 해당하는 컨텐츠를 표시합니다
                if (targetPane.children().length > 0) {
                    targetPane.show();
                } else {
                    noEventsDiv.show();
                }
            });

            // 페이지 로드 시 활성화된 탭의 컨텐츠를 표시
            let activeTabId = $(".nav-link.active").attr("href");
            let activePane = $(activeTabId);
            let noEventsDiv = $("#no-events");

            if (activePane.children().length > 0) {
                activePane.show();
            } else {
                noEventsDiv.show();
            }
        });
    </script>
</head>
<body>
    <div class="container">
        <h2>이벤트</h2>
        <br>
        <!-- Nav tabs -->
        <ul class="nav nav-tabs">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" id="all" href="#home">전체</a>
            </li>
            <c:forEach items="${bigList}" var="vo">
                <li class="nav-item">
                    <a class="nav-link bigCateData ${(vo.categoryNo == param.categoryNo) ? 'active' : ''}"
                       data-toggle="tab" data-cate_no="${vo.categoryNo}"
                       href="#menu${vo.categoryNo}" id="${vo.categoryName}">
                        <span class="categoryName">${vo.categoryName}</span>
                        <i class="fa fa-edit cate_edit"></i>
                        <div class="editDiv">
                            <button class="btn btn-success btn-sm bigUpdateBtn">수정</button>
                            <br>
                            <button class="btn btn-danger btn-sm bigDeleteBtn">삭제</button>
                        </div>
                    </a>
                </li>
            </c:forEach>
            <li class="nav-item">
                <a class="nav-link"
                   data-toggle="tab" data-categoryNo="${vo.categoryNo}"
                   href="#mid_category" id="bigWriteBtn">
                    <i class="fa fa-plus"></i>
                </a>
            </li>
        </ul>

        <!-- Tab panes -->
        <div class="tab-content">
            <!-- 전체 탭 부분 시작 -->
            <div id="home" class="container tab-pane active"><br>
                <c:forEach items="${list}" var="vo">
                    <div class="dataRow" data-event-no="${vo.eventNo}">
                        <div class="lineDiv">
                            <img class="rounded sub_image" src="${vo.sub_image}" alt="Cinque Terre">
                            <img class="rounded image" src="${vo.image}" alt="Cinque Terre">
                        </div>
                        <p class="eventTitle">${vo.title}</p>
                        <div class="dateRange">
                            <span><fmt:formatDate value="${vo.startDay}" pattern="yyyy-MM-dd"/></span> ~
                            <span class="endDay"><fmt:formatDate value="${vo.endDay}" pattern="yyyy-MM-dd"/></span>
                        </div>
                    </div>
                </c:forEach>
                <div>
                    <pageNav:pageNav listURI="list.do" pageObject="${pageObject}"/>
                </div>
                <a href="writeForm.do" class="btn btn-outline-warning">이벤트 등록</a>
            </div>
            <div id="menu1" class="container tab-pane fade"><br>
                <!-- 여행 관련 컨텐츠 -->
            </div>
            <div id="menu2" class="container tab-pane fade"><br>
                <!-- 호텔 관련 컨텐츠 -->
            </div>
        </div>

        <!-- 새로운 div 추가 -->
        <div id="no-events" class="no-events">이벤트가 없습니다</div>

    </div> <!-- 컨테이너 끝 -->
<!-- 모달 창 시작 -->
<!-- The Modal -->
<div class="modal" id="categoryModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Modal Heading</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

		<form method="post" id="modalForm">
			<input name="categoryNo" value="0" type="hidden" id="modalCate_code1">
		      <!-- Modal body -->
		      <div class="modal-body">
		        <input name="categoryName" class="form-control" id="modalCate_name">
		      </div>
		
		      <!-- Modal footer -->
		      <div class="modal-footer">
		      	<button class="btn btn-primary" id="submitBtn">전송</button>
		        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
		      </div>
		</form>
    </div>
  </div>
</div>
<!-- 모달 창 끝 -->
</body>
</html>