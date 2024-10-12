<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>항공 예약 관리</title>
    <script>
        function togglePassengers(reservationNo) {
            var passengersDiv = document.getElementById("passengers-" + reservationNo);
            if (passengersDiv.style.display === "none") {
                passengersDiv.style.display = "block";
            } else {
                passengersDiv.style.display = "none";
            }
        }
    </script>
</head>
<body>
    <h1>항공 예약 관리</h1>

    <h2>예약 목록</h2>
    <table>
        <thead>
            <tr>
                <th>예약 번호</th>
                <th>이메일</th>
                <th>예약 날짜</th>
                <th>총 가격</th>
                <th>상태</th>
                <th>승객 수</th>
                <th>작업</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="reservation" items="${reservations}">
                <tr>
                    <td>${reservation.reservationNo}</td>
                    <td>${reservation.email}</td>
                    <td>${reservation.booking_Date}</td>
                    <td>${reservation.total_Price}</td>
                    <td>
                        <form action="adminUpdate.do" method="post">
                            <input type="hidden" name="reservationNo" value="${reservation.reservationNo}" />
                            <select name="status">
                                <option value="진행중" ${reservation.status == '진행중' ? 'selected' : ''}>진행중</option>
                                <option value="완료됨" ${reservation.status == '완료됨' ? 'selected' : ''}>완료됨</option>
                                <option value="취소됨" ${reservation.status == '취소됨' ? 'selected' : ''}>취소됨</option>
                            </select>
                            <input type="submit" value="상태 업데이트" />
                        </form>
                    </td>
                    <td>${reservation.passenger_cnt}</td>
                    <td>
                        <form action="${pageContext.request.contextPath}/deleteReservation" method="post">
                            <input type="hidden" name="reservationNo" value="${reservation.reservationNo}" />
                            <input type="submit" value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');" />
                        </form>
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        <button onclick="togglePassengers(${reservation.reservationNo})">승객 목록 보기/숨기기</button>
                        <div id="passengers-${reservation.reservationNo}" style="display:none;">
                            <h3>승객 목록</h3>
                            <table>
                                <thead>
                                    <tr>
                                        <th>승객 번호</th>
                                        <th>이름</th>
                                        <th>성</th>
                                        <th>생년월일</th>
                                        <th>국적</th>
                                        <th>여권 번호</th>
                                        <th>작업</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="passenger" items="${reservations.passengers}">
                                        <tr>
                                            <td>${passenger.passengerNo}</td>
                                            <td>${passenger.firstName}</td>
                                            <td>${passenger.lastName}</td>
                                            <td>${passenger.birth}</td>
                                            <td>${passenger.nationality}</td>
                                            <td>${passenger.passport_number}</td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/deletePassenger" method="post">
                                                    <input type="hidden" name="passengerNo" value="${passenger.passengerNo}" />
                                                    <input type="submit" value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');" />
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>
