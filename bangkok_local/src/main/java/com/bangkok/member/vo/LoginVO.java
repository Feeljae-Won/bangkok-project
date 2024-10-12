package com.bangkok.member.vo;

import lombok.Data;

@Data
public class LoginVO {

	private String email;
	private String pw;
	private String name;
	private String nickName;
	private String photo;
	private Integer gradeNo;
	private String gradeName;	// grade 테이블에 있다.
	private String status;
}
