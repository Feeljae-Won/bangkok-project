package com.bangkok.member.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {

    private String email;        // 아이디@도메인
    private String pw;           // 비밀번호 (영어, 숫자)
    private String name;         // 이름
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birth;          // 생년월일
    private String tel;          // 연락처 (xxx-xxxx-xxxx)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date regDate;        // 가입일
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date conDate;        // 최근 접속일
    private String status;       // 상태
    private String photo;        // 사진
    private String gradeName;        // 사진
    private int gradeNo;         // 등급 (일반회원-1, 사업자-5, 관리자-9)
    private String nickName;     // 닉네임
    private String gender;       // 성별
    private  String reset_token;
    private Date reset_token_expiry; // 비밀번호 재설정 토큰 만료일
    private String kakaoId;  // 카카오 아이디 필드 추가
}
