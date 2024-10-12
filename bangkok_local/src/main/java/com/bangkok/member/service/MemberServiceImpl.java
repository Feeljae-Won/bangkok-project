package com.bangkok.member.service;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.bangkok.common.DateTimeConverter;
import com.bangkok.member.mapper.MemberMapper;
import com.bangkok.member.vo.BusinessVO;
import com.bangkok.member.vo.GoogleMemberVO;
import com.bangkok.member.vo.LoginVO;
import com.bangkok.member.vo.MemberVO;
import com.bangkok.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Service("memberServiceImpl")
@Log4j
@Qualifier("memberServiceImpl")
public class MemberServiceImpl implements MemberService {
	@Inject
	private MemberMapper mapper;

	@Override
	public List<MemberVO> list(PageObject pageObject) {
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}

	@Override
	public Long getTotalRow(PageObject pageObject) {
		return mapper.getTotalRow(pageObject);
	}

	@Transactional
	@Override
	public Integer join(MemberVO vo, BusinessVO businessVO) throws Exception {
		int result = 0;
		try {
			result = mapper.insertMember(vo);

			if (result > 0 && vo.getGradeNo() == 5) {
				businessVO.setEmail(vo.getEmail());
				log.info("Inserting business user with email: " + businessVO.getEmail());
				int businessResult = mapper.insertBusiness(businessVO);

				if (businessResult > 0) {
					return result;
				} else {
					throw new Exception("Failed to insert business user information.");
				}
			}
		} catch (Exception e) {
			log.error("Error during join process", e);
			throw e;
		}

		return result;
	}

	@Override
	public MemberVO view(String email) {
		log.info(email);
		return mapper.view(email);
	}

	@Override
	public Integer update(MemberVO vo) {
		log.info(vo);
		return mapper.update(vo);
	}

	@Override
	public Integer bisUpdate(BusinessVO vo) {
		log.info(vo);
		return mapper.bisUpdate(vo);
	}

	@Override
	public Integer delete(MemberVO vo) {
		log.info(vo);
		return mapper.delete(vo);
	}

	@Override
	public LoginVO login(LoginVO vo) {
		log.info(vo);
		return mapper.login(vo);
	}

	@Override
	public boolean checkEmail(String email) {
		return mapper.checkEmail(email) > 0; // 이메일이 존재하면 true, 아니면 false
	}

	@Override
	public boolean checkNickname(String nickName) {
		Integer count = mapper.checkNickname(nickName);
		log.info("Nickname: " + nickName + ", Count: " + count);
		return count > 0; // 닉네임이 존재하면 true, 아니면 false
	}

	@Override
	public MemberVO getMemberInfo(String email) {
		return mapper.getMemberInfo(email);
	}

	@Override
	public BusinessVO bisView(String email) {
		return mapper.bisView(email);
	}

	@Override
	public void changeConDate(String email) {
		mapper.changeConDate(email);
	}

	@Override
	public void updateMember(String email, String status, int gradeNo) {
		// 회원 정보를 업데이트하는 매퍼 메서드 호출
		mapper.updateMember(email, status, gradeNo);
	}

	@Override
	public String findEmail(String name, String tel) {
		return mapper.findEmail(name, tel);
	}

	@Override
	public MemberVO findPassword(String name, String email, String tel) {
		// 사용자 정보 조회
		return mapper.findMemberByNameEmailTel(name, email, tel);
	}

	@Override
	public void createPasswordResetTokenForUser(MemberVO vo, String token) {
		LocalDateTime expiryDateTime = LocalDateTime.now().plusHours(1); // 예: 1시간 후
		Date expiryDate = DateTimeConverter.convertToDate(expiryDateTime);

		vo.setReset_token(token); // reset_token 필드에 토큰을 설정합니다.
		vo.setReset_token_expiry(expiryDate); // reset_token_expiry 필드에 만료일을 설정합니다.

		// 데이터베이스에 저장
		mapper.updatePasswordResetToken(vo);
	}

	@Override
	public void updatePassword(String email, String newPassword, String token) {
		Map<String, Object> params = new HashMap<>();
		params.put("email", email);
		params.put("pw", newPassword);
		params.put("reset_token", token);

		mapper.updatePassword(params); // Ensure this call matches the interface definition
	}

	@Override
	public MemberVO findMemberByToken(String token) {
		return mapper.findByResetToken(token); // 토큰으로 사용자 조회
	}

	@Override
	public boolean validatePasswordResetToken(String token) {
		int count = mapper.validatePasswordResetToken(token);
		return count > 0;
	}

	@Override
	public boolean resetPassword(String token, String newPassword) {
		// 토큰 유효성 검사 및 비밀번호 업데이트 처리
		MemberVO member = mapper.findMemberByResetToken(token);
		if (member != null && !member.getReset_token_expiry().before(new Date())) {
			// 비밀번호 업데이트
			Map<String, Object> params = new HashMap<>();
			params.put("email", member.getEmail());
			params.put("pw", newPassword);
			params.put("reset_token", token);

			mapper.updatePassword(params); // 매퍼 호출
			return true;
		}
		return false;
	}

	@Override
	public void updateStatus(String email, String status) {
		// 상태를 업데이트하는 로직
		mapper.updateStatus(email, status);
	}

	@Override
	public void updateGrade(String email, Integer gradeNo) {
		// 등급을 업데이트하는 로직
		mapper.updateGrade(email, gradeNo);

	}

	@Override
	public MemberVO findByEmail(String email) {
		return mapper.findByEmail(email);
	}

	@Override
	public void saveGoogleMember(GoogleMemberVO googleMember) {
		mapper.saveGoogleMember(googleMember);

	}

	@Override
	public LoginVO findByGoogleId(String email) {
		return mapper.googleEmail(email);
	}

	@Override
	public LoginVO autoRegister(LoginVO googleUser) {
		mapper.autoRegister(googleUser);
		return mapper.googleEmail(googleUser.getEmail());
	}

}
