/**
 * 
 */

// 숫자에 천 단위 콤마를 추가하는 함수
function addCommas(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}