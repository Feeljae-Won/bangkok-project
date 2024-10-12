package com.bangkok.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

// 자동 생성 - @Controller, @RestController, @Service, @Repository, @Component, @~Advice
@Component
@Log4j
@Aspect	// AOP 프로그램 지정
public class LogAdvice {
	// 실행하기 전 후에 실행할거다 선언 - @Around
	// * org.zerock.*.service.*ServiceImpl.*(..)) 
	@Around("execution(* com.bangkok.*.service.*ServiceImpl.*(..))")
	// ProceedingJoinPoint - 실행 해야할 객체(~ServiceImpl) + parameter(넘어가는 데이터)
	// Throwable : Execption 위에 단계 (Execption을 포함하고 있다.)
	public Object logTime(ProceedingJoinPoint pjp) throws Throwable {
		
//		----------------- [ Before 처리 실행 ] -------------------
		// 결과를 저장하는 변수 선언
		Object result = null;
		// 시작 시간 저장
		long start = System.currentTimeMillis(); // 1000분의 1초
		
		log.info(" + ******************* [ AOP 실행 전 로그 출력 ]******************** + ");	// 실행되는 객체의 이름 출력
//		log.info(" + 실행 객체 : " + pjp.getTarget());	// 실행되는 객체의 이름 출력
		log.info(" + 실행 메서드 : " + pjp.getSignature());	// 실행되는 객체의 이름 출력
		// 전달 되는 파라미터 데이터 출력{배열}
		log.info(" + 전달 데이터 : " + Arrays.toString(pjp.getArgs()));
//		----------------- [ After 처리 실행 (Around Advice)] -------------------
		// 실행하는 부분 - 다른 AOP가 있으면 그쪽으로 가서 진행 처리
		result = pjp.proceed();
		// 실행한 결과 데이터 출력
		log.info(" + 실행 결과 : " + result);
		
		// 끝나는 시간 저장
		long end = System.currentTimeMillis(); // 백만분의 1초
				
		// 실행 시간 출력 - 1/1000 초
		log.info(" + 소요 시간 : " + (end - start));
		log.info(" + *********************************************************** + ");	// 실행되는 객체의 이름 출력
		
		return result;
	}
}
