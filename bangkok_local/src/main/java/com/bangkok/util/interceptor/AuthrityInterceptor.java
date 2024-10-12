package com.bangkok.util.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bangkok.member.vo.LoginVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class AuthrityInterceptor extends HandlerInterceptorAdapter{
	
	// 권한 정보가 들어있는 map <uri,등급>
	// 복기 : Integer / Long : 대문자들은 -> Object로 받는다.
	// Static 블록
	private Map<String, Integer> authMap = new HashMap<>(); 	// 안에 저장하는 변수에 대한 타입을 생성할 때 제너릭 이라고 표현하고. 생략한다
	
	// 권한 정보를 등록하는 초기화 블록 - Static이 아님 - Static으로 사용해도 무방하다.
	{
		// 등급이 1이면 로그인 필요, 등급이 9면 로그인도 되어야 하고 관리자인걸 표시
		// 댓글
		authMap.put("/boardreply/write.do", 1);	//key,value -- 등급의 번호 
		
		// 상품 관리 (등록,수정,삭제는 관리자만 하기) - 페이지 권한
//		authMap.put("/goods/writeForm.do", 9);	//key,value -- 등급의 번호 
//		authMap.put("/goods/write.do", 9);	
		authMap.put("/goods/updateForm.do", 9);	
		authMap.put("/goods/update.do", 9);	 
		authMap.put("/goods/delete.do", 9);	
		authMap.put("/goods/changeImage.do", 9);	
		authMap.put("/goods/addSize.do", 9);	
		authMap.put("/goods/addColor.do", 9);	
		authMap.put("/goods/changePrice.do", 9);	
		
		// 회원관리 페이지 권한
		authMap.put("/member/logout.do", 1);	//key,value -- 등급의 번호 
		
	}
	
	
	@Override // 메서드 형태가 똑같이 만드는 메서드 (앞에서)
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		// 권한 처리 진행
		log.info("------------------------ [ 권한 처리 Interceptor ] ------------------------");
		
		// 로그인 여부 - 사용자 권한 등급 번호(login - session). 페이지 권한 숫자 필요(authMap)
		// 페이지 권한 가져오기
		String uri = request.getRequestURI();
		Integer pageGradeNo = authMap.get(uri);
		// null이 아닌 경우에만 처리 null은 로그인 필요 없음
		
		// 로그인이 필요한 경우
		if(pageGradeNo != null) {
			// 세션 가져오기
			HttpSession session = request.getSession();
			// vo에 있는 정보 담기
			LoginVO vo = (LoginVO) session.getAttribute("login");
			
			// 로그인이 필요한데 로그인을 안 한 경우
			if(vo == null) {
				
				// 권한 오류 JSP로 이동시킨다.
				request.getRequestDispatcher("/WEB-INF/views/error/loginError.jsp").forward(request, response);
				
				return false;
			}
			
			// 페이지 권한 확인
			// 등급 확인
			Integer userGradeNo = vo.getGradeNo();
			// 페이지 등급번호가 유저 등급보다 크면 안된다.
			if(pageGradeNo > userGradeNo) {
				// 권한 오류 JSP로 이동시킨다.
				request.getRequestDispatcher("/WEB-INF/views/error/authError.jsp").forward(request, response);
				
				return false;
			}
		}
		
		// 요청한 내용을 계속 진행 - 적합한 권한인 경우
		return super.preHandle(request, response, handler); // super : HandlerInterceptorAdapter 을 집어 넣었다.
	} // end of preHandle
}
