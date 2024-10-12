package com.bangkok.exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

// 자동 생성 DI 
// @Controller , @RestController, @Service, @Repository, @~Advice
@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {

	// 500번 오류에 해당하는 예외 처리
	@ExceptionHandler(Exception.class) // 클래스 전체를 예외처리로 시킬 때
	public String execeptionString(Exception ex, Model model) {
		// 간단한 오류 메세지만 출력할때
		log.error("Exception------------------------" + ex.getMessage());
		// JSP로 ex를 전달.
		model.addAttribute("exception",ex);
		
		log.error(model);
		
		return "error_page";
	}
	
		// 404 오류 예외 처리 - JSP가 없는 경우는 처리 안 한다. web.xml에서 처리함.
		@ExceptionHandler(NoHandlerFoundException.class)
		@ResponseStatus(HttpStatus.NOT_FOUND)
		public String handle404(NoHandlerFoundException ex) {
			return "custom404";
		}
}
