package com.bangkok.air.vo;

public class HangulUtils {

	// 유니코드를 사용하여 초성을 추출하는 방법
    private static final char[] CHO_SUNG = { 'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' };

    public static String extractChoSung(String word) {
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < word.length(); i++) {
            char c = word.charAt(i);
            if (c >= 0xAC00 && c <= 0xD7A3) { // 한글 음절인지 확인
                int base = c - 0xAC00;
                int choSungIndex = base / (21 * 28); // 초성 인덱스 계산
                result.append(CHO_SUNG[choSungIndex]);
            } else {
                result.append(c); // 한글이 아니면 그대로 추가
            }
        }
        return result.toString();
    }
	
}
