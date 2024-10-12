<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Airplane Seat Map</title>
    <style>
        .seat-map { display: grid; grid-template-columns: repeat(2, 50px); gap: 10px; }
        .seat { width: 50px; height: 50px; border: 1px solid black; text-align: center; line-height: 50px; }
        .legroom { background-color: #ff66b2; }
        .economy { background-color: #66ccff; }
        .front { background-color: #cc66ff; }
        .duo { background-color: #ff9933; }
        .occupied { background-color: #000000; color: #fff; }
    </style>
</head>
<body>
    <h1>Seat Map</h1>
    <div class="seat-map">
        <c:forEach var="seat" items="${seats}">
            <c:set var="seatClass">
                <c:choose>
                    <c:when test="${seat.classNo == 1}">legroom</c:when>
                    <c:when test="${seat.classNo == 2}">economy</c:when>
                    <c:when test="${seat.classNo == 3}">front</c:when>
                    <c:when test="${seat.classNo == 4}">duo</c:when>
                </c:choose>
            </c:set>

            <div class="seat ${seatClass} ${seat.passengerNo != 0 ? 'occupied' : ''}">
                ${seat.seatID}
            </div>
        </c:forEach>
    </div>
</body>
</html>
