package com.bangkok.member.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.bangkok.member.vo.BusinessVO;
import com.bangkok.member.vo.GoogleMemberVO;
import com.bangkok.member.vo.LoginVO;
import com.bangkok.member.vo.MemberVO;
import com.bangkok.util.page.PageObject;

@Repository
public interface MemberMapper {

    // 일반 게시판 글 리스트를 가져옵니다.
    public List<MemberVO> list(PageObject pageObject);

    // 게시판 리스트 페이지 처리를 위한 전체 데이터 개수를 가져옵니다.
    public Long getTotalRow(PageObject pageObject);

    // 특정 이메일을 가진 회원의 정보를 조회합니다.
    public MemberVO view(String email);

    // 회원 정보를 수정합니다.
    public Integer update(MemberVO vo);

    // 회원을 탈퇴 처리합니다.
    public Integer delete(MemberVO vo);

    // 로그인 정보를 확인하여 로그인 처리를 합니다.
    public LoginVO login(LoginVO vo);

    // 이메일 중복을 확인합니다.
    public Integer checkEmail(String email);

    // 닉네임 중복을 확인합니다.
    public Integer checkNickname(String nickName);

    // 일반 회원을 데이터베이스에 등록합니다.
    public int insertMember(MemberVO vo);

    // 사업자 회원을 데이터베이스에 등록합니다.
    public int insertBusiness(BusinessVO vo);

    // 특정 이메일을 가진 회원의 정보를 가져옵니다.
    public MemberVO getMemberInfo(String email);

    // 사업자 정보를 수정합니다.
    public Integer bisUpdate(BusinessVO vo);

    // 특정 이메일을 가진 사업자 페이지 정보를 조회합니다.
    public BusinessVO bisView(String email);

    // 회원의 최근 접속일을 업데이트합니다.
    public void changeConDate(String email);

    // 회원 정보를 수정합니다. (상태 및 등급 번호 포함)
    public void updateMember(@Param("email") String email,
                             @Param("status") String status,
                             @Param("gradeNo") int gradeNo);

    // 이름, 이메일, 전화번호를 사용하여 이메일을 찾습니다.
    public String findEmail(@Param("name") String name, 
                            @Param("tel") String tel);

    // 비밀번호 재설정 토큰을 회원 정보에 업데이트합니다.
    public void updatePasswordResetToken(MemberVO member);

    // 이름, 이메일, 전화번호를 사용하여 회원 정보를 조회합니다.
    public MemberVO findMemberByNameEmailTel(@Param("name") String name, 
                                             @Param("email") String email, 
                                             @Param("tel") String tel);

    // 비밀번호 재설정 토큰의 유효성을 검증합니다.
    public int validatePasswordResetToken(String token);

    // 비밀번호 찾기 기능을 위한 메서드입니다. 파라미터로 주어진 정보를 사용하여 회원 정보를 찾습니다.
    public MemberVO findPassword(Map<String, Object> parameters);

    // 주어진 토큰으로 회원 정보를 찾습니다.
    public MemberVO findByResetToken(String token);
    
    public MemberVO findMemberByNameEmailTel(MemberVO memberVO);

    // 주어진 리셋 토큰을 가진 회원을 찾습니다.
    public MemberVO findMemberByResetToken(@Param("reset_token") String resetToken);

    // 비밀번호 업데이트를 위한 메서드입니다. 토큰과 새로운 비밀번호를 사용하여 업데이트합니다.
    public void updatePassword(Map<String, Object> params);

	public void updateStatus(@Param("email")String email, @Param("status")String status);

	public void updateGrade(@Param("email")String email, @Param("gradeNo")Integer gradeNo);

	public MemberVO findByEmail(String email);
	public LoginVO googleEmail(String email);

	public void updateMember(MemberVO member);
	
	public void saveGoogleMember(GoogleMemberVO googleMember);

	public void autoRegister(LoginVO googleUser);

}
