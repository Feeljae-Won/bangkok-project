/**
 * 날짜와 시간에 대한 표시와 처리
 */

// 날짜로 표시하는 처리
// timeStamp : Long type의 시간 정보 데이터
function toDate(timeStamp, separChar) {
	if (!separChar) separChar = "-";

	let dateObj = new Date(timeStamp);
	let yy = dateObj.getFullYear();
	let mm = dateObj.getMonth() + 1; // 월은 0~11까지 사용.
	let dd = dateObj.getDate();

	let dateStr = yy + separChar + ((mm > 9 ? "" : "0") + mm) + separChar + dd;

	return dateStr;
}
/**
 * timestamp를 받아 HH : MM : SS 형식의 시간 문자열로 변환하는 함수
 * @param {number} timeStamp - Long Type의 시간 정보 데이터
 * @return {string} 포맷된 시간 문자열
 */
function toTime(timeStamp) {
	let dateObj = new Date(timeStamp);

	let hh = dateObj.getHours();
	let mi = dateObj.getMinutes();
	let ss = dateObj.getSeconds();

	return (
		((hh > 9 ? "" : "0") + hh) + ":" +
		((mi > 9 ? "" : "0") + mi) + ":" +
		((ss > 9 ? "" : "0") + ss)
	);

	// 두 자리 숫자로 포맷팅하는 함수
	// console.log("dataTime.js - timeStamp : " + timeStamp);
	// const formatNumber = (num) => (num < 10 ? '0' + num : num);

	// 시간을 포맷팅하여 반환
	// return [formatNumber(hh), formatNumber(mi), formatNumber(ss)].join(' : ');
}

// 날짜와 시간 표시하는 처리
// 24 시간이 지나지 않았으면 시간을, 지났으면 날짜를 표시하도록 처리한다.
function toDateTime(timeStamp) {
	// console.log("dataTime.js - timeStamp : " + timeStamp);
	// 현재 날짜 객체
	let today = new Date(); // 아무것도 안집어 넣으면 현재 날짜로 인식.
	let gap = today.getTime() - timeStamp; // Long type의 timeStamp로 표시, 1000분의 1초 단위의 지나간 시간이 나온다.

	// console.log("dataTime.js - gap : " + gap);

	// 지나간 시간이 24 시간 보다 작은 경우(24시간이 안 지나갔다.) - 이런 경우 시간 표시
	if (gap < (1000 * 60 * 60 * 24)) return toTime(timeStamp);
	// else는 안 써도 되는데 24시간 지난 경우는 날짜 표시
	else return toDate(timeStamp, "-");

}
