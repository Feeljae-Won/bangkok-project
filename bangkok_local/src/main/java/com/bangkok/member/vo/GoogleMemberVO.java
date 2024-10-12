package com.bangkok.member.vo;

import lombok.Data;

@Data
public class GoogleMemberVO {
	private String email; // 아이디@도메인
	private String name; // 이름
	private int gradeNo = 1;  // 기본값으로 일반 회원 등급
	private String photo;
}
