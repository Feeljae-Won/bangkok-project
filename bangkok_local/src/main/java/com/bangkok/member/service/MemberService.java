package com.bangkok.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import com.bangkok.member.vo.BusinessVO;
import com.bangkok.member.vo.GoogleMemberVO;
import com.bangkok.member.vo.LoginVO;
import com.bangkok.member.vo.MemberVO;
import com.bangkok.util.page.PageObject;

//@Controller : url - HTML , @Service - 처리 , @Repository(저장소-DB : 데이터 저장), @Component - 구성체, 
//@RestController(순수한 데이터를 주고 받기-URL과 연결) : AJAX 처리  @~Advice : 예외 처리
public interface MemberService {

	public List<MemberVO> list(PageObject pageObject);

	public Integer update(MemberVO memberVO);

	public Integer delete(MemberVO vo);
	// 로그인
	public LoginVO login(LoginVO vo);
    // 이메일 중복 확인
	public boolean checkEmail(String email);
	
	public boolean checkNickname(String nickName);

    public MemberVO view(String email);
    @Transactional
    public Integer join(MemberVO vo, BusinessVO businessVO) throws Exception;

	public MemberVO getMemberInfo(String email);

	public Integer bisUpdate(BusinessVO vo);

	public BusinessVO bisView(String email);

	public void changeConDate(String email);

	public Long getTotalRow(PageObject pageObject);

	public void updateMember(String email, String status, int grade);

	public String findEmail(String name, String tel);

	public void createPasswordResetTokenForUser(MemberVO member, String token);

	public MemberVO findPassword(String name, String email, String tel);

	public MemberVO findMemberByToken(String token);

	public boolean validatePasswordResetToken(String token);

	public void updatePassword(String email, String newPassword, String token);
	
	public boolean resetPassword(String token, String newPassword);

	void updateStatus(String email, String status);

	public void updateGrade(String email, Integer gradeNo);

	public MemberVO findByEmail(String userEmail);

	public void saveGoogleMember(GoogleMemberVO googleMember);

	public LoginVO findByGoogleId(String email);

	public LoginVO autoRegister(LoginVO googleUser);
	
}
