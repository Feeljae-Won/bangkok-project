package com.bangkok.member.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bangkok.member.service.EmailService;
import com.bangkok.member.service.MemberService;
import com.bangkok.member.vo.BusinessVO;
import com.bangkok.member.vo.LoginVO;
import com.bangkok.member.vo.MemberVO;
import com.bangkok.util.file.FileUtil;
import com.bangkok.util.page.PageObject;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {
	// 파일 위치 지정
	String path = "/upload/member";
	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService service;
	@Autowired
	private EmailService emailService;

	// 회원 리스트 - 관리자만
	@GetMapping("/memberList.do")
	public String list(Model model, HttpServletRequest request) throws Exception {
		PageObject pageObject = PageObject.getInstance(request);

		model.addAttribute("list", service.list(pageObject));
		model.addAttribute("pageObject", pageObject);

		return "member/memberList";
	}

	@RequestMapping("/view.do")
	public String view(Model model, HttpSession session, @RequestParam(value = "email", required = false) String email) {
	    log.info("memberController.view()-------------");

	    // 이메일이 파라미터로 전달되었는지 확인
	    if (email == null || email.isEmpty()) {
	        // 이메일이 파라미터로 전달되지 않은 경우, 세션에서 이메일을 가져옵니다
	        MemberVO user = (MemberVO) session.getAttribute("user");
	        if (user != null) {
	            email = user.getEmail(); // 세션에서 사용자 정보로부터 이메일을 가져옴
	        } else {
	            return "redirect:/main/main.do"; // 메인 페이지로 리디렉션
	        }
	    }

	    // 이메일을 통해 회원 정보 조회
	    model.addAttribute("vo", service.view(email));
	    return "member/view";
	}


	// 회원가입 폼
	@GetMapping("/joinForm.do")
	public String writeForm() {
		log.info("memberController.JoinForm()-------------");
		return "member/joinForm";
	}

	// 회원가입 처리
	@PostMapping("/join.do")
	public String join(MemberVO memberVO, BusinessVO businessVO, int gradeNo, RedirectAttributes rttr,
			MultipartFile photoFile, HttpServletRequest request) throws Exception {
		// 파일 업로드 처리
		if (photoFile != null && !photoFile.isEmpty()) {
			String photoPath = FileUtil.upload(path, photoFile, request);
			memberVO.setPhoto(photoPath);
			log.info("업로드된 사진: " + photoFile.getOriginalFilename());

		}
		// 회원 등급에 따라 분기
		memberVO.setGradeNo(gradeNo);
		service.join(memberVO, businessVO);
		rttr.addFlashAttribute("msg", "회원가입 되셨습니다 로그인 후 이용해주세요.");
		return "redirect:/main/main.do";
	}

	// 회원 정보 수정 폼
	@GetMapping("/updateForm.do")
	public String updateForm(Model model, @RequestParam("email") String email) {
		log.info("memberController.updateForm()-------------");
		log.info(email);
		// 데이터 조회 후 모델에 추가
		model.addAttribute("vo", service.view(email));
		// 업데이트 폼 뷰 반환
		return "member/updateForm";
	}

	// 회원 정보 수정 처리
	@PostMapping(value = "/update.do", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public ResponseEntity<String> update(MemberVO memberVO, @RequestParam("photoFile") MultipartFile photoFile,
			@RequestParam(value = "existingPhoto", required = false) String existingPhoto, HttpServletRequest request)
			throws Exception {
		log.info("memberController.update()-------------");

		// 기존 사진이 있을 경우, 기본값으로 설정
		if (existingPhoto != null && !existingPhoto.isEmpty()) {
			memberVO.setPhoto(existingPhoto);
		}

		// 파일 업로드 처리
		if (photoFile != null && !photoFile.isEmpty()) {
			String photoPath = FileUtil.upload(path, photoFile, request);
			memberVO.setPhoto(photoPath);
			log.info("업로드된 사진: " + photoFile.getOriginalFilename());
		}

		Integer result = service.update(memberVO);

		if (result > 0) {
			// 세션 업데이트
			request.getSession().setAttribute("login", service.getMemberInfo(memberVO.getEmail()));
			return ResponseEntity.ok("정보가 성공적으로 업데이트되었습니다.");
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("정보 업데이트에 실패했습니다.");
		}
	}

	// 사업자 정보 수정 폼
	@GetMapping("/bisUpdateForm.do")
	public String bisUpdateForm(Model model, @RequestParam("email") String email) {
		log.info("memberController.bisUpdateForm()-------------");
		log.info(email);
		// 데이터 조회 후 모델에 추가
		model.addAttribute("vo", service.bisView(email));
		// 업데이트 폼 뷰 반환
		return "member/bisUpdateForm";
	}

	// 사업자 정보 수정 처리
	@PostMapping("/bisUpdate.do")
	public String bisUpdate(BusinessVO vo, RedirectAttributes rttr) throws Exception {
		log.info("memberController.bisUpdate()-------------");

		Integer result = service.bisUpdate(vo);

		if (result > 0) {
			// 세션 업데이트
			rttr.addFlashAttribute("msg", "정보가 성공적으로 업데이트되었습니다.");
			return "redirect:/main/main.do"; // 업데이트 후 상세보기 페이지로 리다이렉트
		} else {
			rttr.addFlashAttribute("msg", "정보 업데이트에 실패했습니다.");
			return "redirect:bisView.do"; // 업데이트 실패 시 다시 회원 정보 페이지로 리다이렉트
		}
	}

	// 사업자 페이지 보기
	@RequestMapping("/bisView.do")
	public String bisView(Model model, HttpSession session, String email) {
		log.info("memberController.bisView()-------------");

		if (session.getAttribute("email") != null) {
			email = (String) session.getAttribute("email");
			session.removeAttribute("email");
		}

		model.addAttribute("vo", service.bisView(email));
		return "member/bisView";
	}

	// 이메일 찾기 폼
	@GetMapping("/findEmailForm.do")
	public String showFindEmailForm() {
		// 이메일 찾기 폼으로 이동
		return "member/findEmailForm"; // JSP 파일 경로
	}

	// 이메일 찾기 처리
	@PostMapping("/findEmailResult.do")
	public String findEmailResult(@RequestParam("name") String name, @RequestParam("tel") String tel, Model model) {
		String email = service.findEmail(name, tel);

		if (email != null) {
			model.addAttribute("email", email);
			return "member/emailResult"; // 결과 페이지
		} else {
			model.addAttribute("msg", "일치하는 이메일이 없습니다.");
			return "member/findEmailForm"; // 폼으로 다시 이동
		}
	}

	// 비밀번호 찾기 폼 및 결과 처리 (단일 JSP 사용)
	@GetMapping("/findPwForm.do")
	public String showFindPwForm(Model model) {
		// JSP에서 비밀번호 찾기 폼 및 결과를 함께 보여주도록 처리
		model.addAttribute("msg", ""); // 빈 메시지로 시작
		return "member/findPwForm"; // JSP 파일 경로
	}

	// 비밀번호 찾기 처리
	@PostMapping("/findPw.do")
	public String findPassword(@RequestParam("name") String name, @RequestParam("email") String email,
	        @RequestParam("tel") String tel, Model model,RedirectAttributes rttr) {
	    MemberVO member = service.findPassword(name, email, tel);

	    if (member != null) {
	        String token = UUID.randomUUID().toString();
	        service.createPasswordResetTokenForUser(member, token);

	        String resetUrl = "http://localhost:80/member/findPwResult.do?token=" + token;
	        emailService.sendSimpleMessage(email, "[BANGKOK] 비밀번호 재설정", "비밀번호를 재설정하려면 아래 링크를 클릭하세요:\n" + resetUrl);
	        rttr.addFlashAttribute("msg", "비밀번호 재설정 링크가 이메일로 전송되었습니다.");

	        // 이메일 전송 후 메인 페이지로 리다이렉트
	        return "redirect:/main/main.do";
	    } else {
	    	rttr.addFlashAttribute("msg", "입력하신 정보와 일치하는 사용자가 없습니다.");
	        return "member/findPwForm"; // 비밀번호 찾기 폼으로 다시 리턴
	    }
	}


	@GetMapping("/findPwResult.do")
	public String showResetPasswordForm(@RequestParam("token") String token, Model model, RedirectAttributes rttr) {
	    if (service.validatePasswordResetToken(token)) {
	        model.addAttribute("token", token); // 토큰을 JSP로 전달
	        return "member/resetPwForm"; // 비밀번호 재설정 폼으로 이동
	    } else {
	        rttr.addFlashAttribute("msg", "유효하지 않은 링크입니다.");
	        return "redirect:/member/findPwForm.do"; // 비밀번호 찾기 페이지로 리다이렉트
	    }
	}

	
	@PostMapping("/resetPw.do")
	public String resetPassword(@RequestParam("token") String token, @RequestParam("pw") String pw, RedirectAttributes rttr) {
	    if (service.resetPassword(token, pw)) {
	        rttr.addFlashAttribute("msg", "비밀번호가 성공적으로 변경되었습니다.");
	        return "redirect:/main/main.do";
	    } else {
	        rttr.addFlashAttribute("msg", "비밀번호 변경에 실패했습니다.");
	        return "member/resetPwForm";
	    }
	}
	


	// 회원 탈퇴 처리
	@PostMapping("/delete.do")
	public String delete(MemberVO vo, RedirectAttributes rttr, HttpServletRequest request) {
		log.info("memberController.delete()-------------");

		vo.setStatus("탈퇴"); // 상태를 '탈퇴'로 설정

		if (service.delete(vo) == 1) {
			rttr.addFlashAttribute("msg", "회원 탈퇴 완료 되었습니다.");

			// 로그아웃 처리 (세션 무효화)
			request.getSession().invalidate();

			return "redirect:/main/main.do";
		} else {
			rttr.addFlashAttribute("msg", "회원관리 삭제를 실패했습니다.");
			return "redirect:view.do?no=" + vo.getEmail() + "&inc=0";
		}
	}

	// 회원 상태/등급 수정 처리 - 관리자
	@PostMapping("/updateMember.do")
	public String updateMember(@RequestParam("email") String email,
	                           @RequestParam(value = "status", required = false) String status,
	                           @RequestParam(value = "gradeNo", required = false) Integer gradeNo,
	                           RedirectAttributes rttr) {
	    // 회원 정보를 업데이트하는 서비스 메서드 호출
	    if (status != null) {
	        service.updateStatus(email, status);
	    }
	    if (gradeNo != null) {
	        service.updateGrade(email, gradeNo);
	    }
	    rttr.addFlashAttribute("msg", "회원 정보가 성공적으로 변경되었습니다.");
	    return "redirect:/member/memberList.do"; // 최신 회원 리스트를 로드
	}

	@PostMapping("/login.do")
	public String login(LoginVO vo, HttpSession session, RedirectAttributes rttr) {
	    // 로그인 로직
	    LoginVO loginVO = service.login(vo);

	    // 로그인 정보가 잘못된 경우
	    if (loginVO == null) {
	        rttr.addFlashAttribute("msg", "로그인 정보가 맞지 않습니다. 다시 로그인 해주세요.");
	        return "redirect:/main/main.do";
	    }

	    // 회원 상태 확인
	    if ("탈퇴".equals(loginVO.getStatus()) || "강퇴".equals(loginVO.getStatus())) {
	        rttr.addFlashAttribute("msg", "회원 탈퇴 또는 강퇴된 계정입니다. 관리자에게 문의하세요.");
	        return "redirect:/main/main.do";
	    }

	    // 상태가 유효한 경우 세션에 로그인 정보 저장
	    session.setAttribute("login", loginVO);
	    session.setAttribute("email", loginVO.getEmail()); // 이메일도 별도로 세션에 저장

	    // 최근접속일 업데이트
	    service.changeConDate(loginVO.getEmail());

	    // 메시지 및 리디렉션
	    rttr.addFlashAttribute("msg", loginVO.getName() + "님은 " + loginVO.getGradeName() + " (으)로 로그인 되었습니다.");
	    return "redirect:/main/main.do";
	}

	// 로그아웃 처리
	@GetMapping("/logout.do")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		log.info("memberController.logout()-------------");
		session.removeAttribute("login");
		rttr.addFlashAttribute("msg", "로그아웃 되었습니다.");
		return "redirect:/main/main.do";
	}

	@PostMapping("/googleLogin")
	public String googleLogin(LoginVO googleUser, HttpSession session, RedirectAttributes rttr) {
	    LoginVO loginVO = service.findByGoogleId(googleUser.getEmail());

	    if (loginVO == null) {
	        loginVO = service.autoRegister(googleUser);
	    }

	    session.setAttribute("user", loginVO); // "goologin" 대신 "user"로 세션에 저장
	    log.info(loginVO + "--------------------------------");

	    rttr.addFlashAttribute("msg", loginVO.getName() + "님이 구글 계정으로 로그인 되었습니다.");
	    return "redirect:/main/main.do";
	}

 
}
