package com.bangkok.member.ajax;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.bangkok.member.service.MemberService;
import com.bangkok.member.vo.LoginVO;
import com.bangkok.member.vo.MemberVO;

import lombok.extern.log4j.Log4j;

@RequestMapping("/ajax")
@Controller
@Log4j
public class MemberAjaxController {
	@Autowired
	@Qualifier("memberServiceImpl") // 대소문자 구별하니 조심.
	private MemberService service;
	
	
	@PostMapping("/checkEmail")
	@ResponseBody
	public boolean checkEmail(@RequestParam("email") String email) {
	    boolean result = service.checkEmail(email);
	    return result; // true or false
	}
	
	@PostMapping("/checkNickName")
	@ResponseBody
	public boolean checkNickName(@RequestParam("nickName") String nickName) {
	    boolean result = service.checkNickname(nickName);
	    return result; // true or false
	}
	
	@GetMapping("/getInfo")
    public MemberVO getProfileInfo(HttpSession session) {
        LoginVO loginVO = (LoginVO) session.getAttribute("login");
        if (loginVO != null) {
            return service.getMemberInfo(loginVO.getEmail());
        }
        return null; // 또는 적절한 오류 처리를 수행
    }
	
}
