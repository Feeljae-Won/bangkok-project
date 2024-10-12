<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hotel Write</title>
<script
    defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAcseD0Ef2zBeEW5pzXqHnB7ql8s9om-6Q&callback=initMap"
  ></script>

<style type="text/css">
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
   height: 500px;
}

/* Optional: Makes the sample page fill the window. */
html, body {
   height: 100%;
   margin: 0;
   padding: 0;
}

.file-input {
   display: none; /* 파일 입력 필드는 숨김 */
}

.upload-btn {
   display: inline-block;
   padding: 8px 16px; /* Bootstrap btn-sm 보다 큰 패딩 값 */
   background-color: #007bff;
   color: white;
   border: none;
   border-radius: 5px;
   cursor: pointer;
   font-size: 14px;
}

.preview-img {
   margin-top: 20px;
   max-width: 300px; /* 이미지 미리보기 최대 너비 */
   height: 300px;
   width: 300px;
   display: none; /* 처음에는 미리보기 이미지 숨김 */
   object-fit: cover;
}
</style>
<script type="text/javascript">
$(function() {
	
	 // 지도 부분
    let map = google.maps.Map;
    async function initMap() {
        const { Map } = await google.maps.importLibrary("maps");
        // 마커 생성 부분
        const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");
        const map = new Map(document.getElementById("map"), {
            // 중심지의 위도/경도
           center: { lat: 37.738835, lng: 127.045888 },
            zoom: 14,
            mapId: "4504f8b37365c3d0",
        });
        const marker = new AdvancedMarkerElement({
          map,
          position: { lat: 37.738835, lng: 127.045888 },
        });
    }
    
    initMap();
	
    // 바로 편의시설의 데이터를 세팅한다.
    $("#amenitiesDiv").load("/ajax/getAmenities.do");

    let roomIndex = 1; // 첫 번째 객실은 이미 있으므로 1부터 시작      
    
    $("#addRoomBtn").click(function() {
        let appendRoomTag = `
            <div class="room-entry">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h6><b>객실 입력 ${roomIndex}</b></h6>
                <div class="input-group-append">
                    <button type="button" class="btn btn-danger removRoomBtn">
                        <i class="fa fa-close"></i>
                    </button>
                </div>
            </div>

            <div class="rounded-lg shadow-sm p3 row bg-light">      
                <div class="col-md-4 ImgInputDiv">               
                    <button type="button" class="upload-btn uploadBtn mt-2">Image</button>
                    <!-- 숨겨진 파일 입력 -->
                    <input type="file" name="roomImageFile" class="file-input fileInput" accept="image/*">
                    <!-- 미리보기 이미지 -->
                    <img class="preview-img imagePreview rounded" src="#" alt="이미지 미리보기">               
                </div>      
                <div class="col-md-8" id="roomInputDiv">
                    <div class="form-row p-3">
                        <div class="form-group col">
                            <label for="room_title">Room Name</label> 
                            <input class="form-control" name="list[\${roomIndex}].room_title" id="room_title" required>
                        </div>
                        <div id="roomDiv col">
                            <label>객실 타입</label>
                            <select name="list[\${roomIndex}].room_type" class="custom-select" style="width: 100%">
                                <option selected>Standard</option>
                                <option>Deluxe</option>
                                <option>suite</option>
                                <option>Premiere</option>
                            </select>
                        </div>
                        <div class="form-group col">
                            <label for="price">정가</label> 
                            <input class="form-control" name="list[\${roomIndex}].price" id="price" required value="0">
                        </div>
                    </div>
                    <div class="rounded-lg p-3 form-row" style="background-color: white">
                        <div class="form-group col-12">
                            <label for="room_content">객실 소개</label>
                            <textarea class="form-control" name="list[\${roomIndex}].room_content" id="room_content" rows="4"></textarea>
                        </div>
                    </div>
                    <div class="rounded-lg p-3 my-2 form-row" style="background-color: white">
                        <div class="form-group col">
                            <label>인원수</label> 
                            <input type="number" name="list[\${roomIndex}].people" class="form-control" value="1" min="1">
                        </div>
                        <div class="form-group col">
                            <label>객실 수</label> 
                            <input type="number" name="list[\${roomIndex}].room_number" class="form-control" value="1" min="1">
                        </div>
                    </div>
                </div>
                <fieldset class="border col-xl" id="roomImageFieldSet_\${roomIndex}">
                    <legend class="w-auto px-2">
                        <b style="font-size: 14pt;">[객실 이미지 추가]</b>
                        <button type="button" class="btn btn-primary btn-sm addRoomImageBtn" data-room-index="\${roomIndex}">add RoomImage</button>
                    </legend>
                    <div class="input-group mb-3">
                        <input class="form-control roomImageFiles" type="file" name="list[\${roomIndex}].roomImage[0]" required>
                    </div>
                </fieldset>
            </div>
        `;

        $("#roomFieldSet").append(appendRoomTag);

        // 인덱스 증가
        roomIndex++;
    });

    // 객실 입력 블록 제거 처리
    $("#roomFieldSet").on("click", ".removRoomBtn", function() {
        $(this).closest(".room-entry").remove();
    });
    
    
    //이미지 선택 이벤트
    $("#roomFieldSet").on("click",".uploadBtn",function() {
        $(this).next().click();
    });
    
    // 파일 선택 시 미리보기
    $("#roomFieldSet").on('change','.fileInput', function(event) {
       const file = event.target.files[0];
       const $this = $(this); // 현재 이벤트가 발생한 요소를 변수로 저장         
       
       if (file) {            
          
          const reader = new FileReader();
        
          reader.onload = function(e) {
             $this.closest(".ImgInputDiv").find("img").prop('src', e.target.result).show(); // 이미지 미리보기 src 설정 및 보여주기
          }
           reader.readAsDataURL(file); // 파일 읽기
         }
    });
    
  //첨부 이미지 추가 처리
    $("#addHotelImageBtn").click(function() {
       console.log("addHotelImageBtn");
      let appendImageTag = `
          <div class="input-group mb-3">
              <input class="form-control imageFiles" type="file" name="imageFiles">
              <div class="input-group-append">
                  <button type="button" class="btn btn-danger removeImageBtn">
                      <i class="fa fa-close"></i>
                  </button>
              </div>
          </div>
      `;
      $("#imageFieldSet").append(appendImageTag);
      imageCnt++;
    });

    //첨부 이미지 제거 처리
    $("#imageFieldSet").on("click", ".removeImageBtn", function() {
      $(this).closest(".input-group").remove();
      imageCnt--;
       });
    
 // 객실 첨부 이미지 추가 처리
    $("#roomFieldSet").on("click", ".addRoomImageBtn", function() {
        let roomIndex = $(this).data("room-index");
       let roomImageCnt = $(this).closest("#roomImageFieldSet_" + roomIndex).find(".roomImageFiles").length;
        let appendRoomImageTag = `
            <div class="input-group mb-3">
                <input class="form-control roomImageFiles" type="file" name="list[\${roomIndex}].roomImage[\${roomImageCnt}]">
                <div class="input-group-append">
                    <button type="button" class="btn btn-danger removeImageBtn">
                        <i class="fa fa-close"></i>
                    </button>
                </div>
            </div>
        `;
        $("#roomImageFieldSet_" + roomIndex).append(appendRoomImageTag);
        
    });

    // 객실 첨부 이미지 제거 처리
    $("#roomFieldSet").on("click", ".removeImageBtn", function() {
        $(this).closest(".input-group").remove();
        
    });
    
 });
</script>

</head>
<body>
   <div class="container">
      <h2>Hotel Write</h2>
      <form action="write.do" method="post" enctype="multipart/form-data">
         <input type="hidden" name="perPageNum" value="${param.perPageNum }">
         <div class="form-group">
            <!-- VO객체의 프로퍼티와 이름이 다르다. 파일 자체이므로 DB에는 이름만 저장 -->
            <label for="imageFile">대표 이미지</label> <input class="form-control"
               name="imageFile" id="imageFile" required type="file">
         </div>
         <div class="form-group">
            <label for="title">Hotel Name</label> <input class="form-control"
               name="title" id="title" required>
         </div>
         <div class="form-group">
            <!-- VO객체의 프로퍼티와 이름이 다르다. 파일 자체이므로 DB에는 이름만 저장 -->
            <label for="detailImageFile">상세보기 이미지</label> <input
               class="form-control" name="detailImageFile" id="detailImageFile"
               type="file">
         </div>
         <div class="form-group">
            <label>등급 : &nbsp;</label>
            <div class="form-check-inline">
               <label class="form-check-label"> <input type="radio"
                  class="form-check-input" name="rating" checked value="5">5
               </label>
            </div>
            <div class="form-check-inline">
               <label class="form-check-label"> <input type="radio"
                  class="form-check-input" name="rating" value="4">4
               </label>
            </div>
            <div class="form-check-inline">
               <label class="form-check-label"> <input type="radio"
                  class="form-check-input" name="rating" value="3">3
               </label>
            </div>
            <div class="form-check-inline">
               <label class="form-check-label"> <input type="radio"
                  class="form-check-input" name="rating" value="2">2
               </label>
            </div>
            <div class="form-check-inline">
               <label class="form-check-label"> <input type="radio"
                  class="form-check-input" name="rating" value="1">1
               </label>
            </div>
         </div>
         <div class="form-group">
            <label for="content">호텔 소개</label>
            <textarea class="form-control" name="content" id="content" rows="7"></textarea>
         </div>
         <div class="form-group">
            <label for="tel" class="label"> 연락처: </label> <input type="text"
               class="form-control" placeholder="'-'포함 입력" id="tel" name="tel">
         </div>
         <div class="form-group">
            <label for="notice">공지사항</label>
            <textarea class="form-control" name="notice" id="notice" rows="7"></textarea>
         </div>
         <div class="row">
         <div class="col-md-6">
         <div class="form-group">
            <div class="form-group">
               <label for="address">주소 입력</label> <input type="text" id="address"
                  name="address" class="form-control" placeholder="상세주소를 입력하세요"
                  required>
            </div>
         </div>
         </div>
         <div class="col-md-6">
                  <div id="map"></div>
         </div>
         </div>
         <div class="form-group">
            <div class="form-check-inline">
               <label class="form-check-label"> <input type="radio"
                  class="form-check-input" name="accommodations" checked
                  value="국내 숙소">국내 숙소
               </label>
            </div>
            <div class="form-check-inline">
               <label class="form-check-label"> <input type="radio"
                  class="form-check-input" name="accommodations"
                  value="해외 숙소">해외 숙소
               </label>
            </div>
         </div>
         <fieldset class="border p-4">
            <fieldset class="border p-4" id="amenitiesFieldSet">
               <!-- px-# : padding 왼쪽 오른쪽 상대적인 설정 (참고:pl-#,pr-#,pt-#,pb-#,py-#) -->
               <legend class="w-auto px-2">
                  <b style="font-size: 14pt;">[편의시설]</b>
               </legend>
               <div id="amenitiesDiv" class="form-inline"></div>
            </fieldset>
         </fieldset>
         <br>
         <fieldset class="border p-4" id="imageFieldSet">
            <legend class="w-auto px-2">
               <b style="font-size: 14pt;">[호텔 이미지 추가]</b>
               <button type="button" id="addHotelImageBtn"
                  class="btn btn-primary btn-sm">add Image</button>
            </legend>
            <div class="input-group mb-3">
               <input class="form-control imageFiles" type="file"
                  name="imageFiles">
            </div>
         </fieldset>
         <fieldset class="border p-4" id="roomFieldSet">
            <!-- px-# : padding 왼쪽 오른쪽 상대적인 설정 (참고:pl-#,pr-#,pt-#,pb-#,py-#) -->
            <legend class="w-auto px-2">
               <b style="font-size: 14pt;">[객실 추가]</b>
               <button type="button" id="addRoomBtn"
                  class="btn btn-primary btn-sm">add Room</button>
            </legend>
            <h6 class="mt-2">
               <b>객실 입력</b>
            </h6>
            <div class="rounded-lg shadow-sm p3 row bg-light">
               <div class="col-md-4 ImgInputDiv">
                  <button type="button" class="upload-btn uploadBtn mt-2">Image</button>
                  <!-- 숨겨진 파일 입력 -->
                  <input type="file" name="roomImageFile"
                     class="file-input fileInput" accept="image/*">
                  <!-- 미리보기 이미지 -->
                  <img class="preview-img imagePreview rounded" src="#"
                     alt="이미지 미리보기">

               </div>
               <div class="col-md-8" id="roomInputDiv">
                  <div class="form-row p-3">
                     <div class="form-group col">
                        <label for="room_title">Room Name</label> <input
                           class="form-control" name="list[0].room_title" id="room_title"
                           required>
                     </div>
                     <div id="roomDiv col">
                        <label>객실 타입</label> <select name="list[0].room_type"
                           class="custom-select" style="width: 100%">
                           <option selected>Standard</option>
                           <option>Deluxe</option>
                           <option>Suite</option>
                           <option>Premiere</option>
                        </select>
                     </div>
                     <div class="form-group col">
                        <label for="price">정가</label> <input class="form-control"
                           name="list[0].price" id="price" required value="0">
                     </div>

                  </div>
                  <div class="rounded-lg p-3 form-row"
                     style="background-color: white">
                     <div class="form-group col-12">
                        <label for="room_content">객실 소개</label>
                        <textarea class="form-control" name="list[0].room_content"
                           id="room_content" rows="4"></textarea>
                     </div>
                  </div>
                  <div class="rounded-lg p-3 my-2 form-row"
                     style="background-color: white">
                     <div class="form-group col">
                        <label>인원수</label> <input type="number" name="list[0].people"
                           class="form-control" value="1" min="1">
                     </div>
                     <div class="form-group col">
                        <label>객실 수</label> <input type="number"
                           name="list[0].room_number" class="form-control" value="1"
                           min="1">
                     </div>
                  </div>
               </div>
               <fieldset class="border col-xl" id="roomImageFieldSet_0">
                  <legend class="w-auto px-2">
                     <b style="font-size: 14pt;">[객실 이미지 추가]</b>
                     <button type="button"
                        class="btn btn-primary btn-sm addRoomImageBtn"
                        data-room-index="0">add RoomImage</button>
                  </legend>
                  <div class="input-group mb-3">
                     <input class="form-control roomImageFiles" type="file" 
                        name="list[0].roomImage[0]" required>
                  </div>
               </fieldset>
            </div>
         </fieldset>
         <div class="mt-3">
            <button type="submit" class="btn btn-primary">등록</button>
            <button type="reset" class="btn btn-warning">새로입력</button>
            <button type="button" class="cancelBtn btn btn-success">취소</button>
         </div>
      </form>
   </div>
</body>
</html>