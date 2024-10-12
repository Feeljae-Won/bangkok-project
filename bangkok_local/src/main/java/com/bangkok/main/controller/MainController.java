package com.bangkok.main.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bangkok.event.service.EventService;
import com.bangkok.info.service.InfoService;
import com.bangkok.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {

    @Autowired
    @Qualifier("eventServiceImpl")
    private EventService eventService; // Corrected the naming to follow conventions
    @Autowired
    @Qualifier("infoServiceImpl")
    private InfoService infoService; // Corrected the naming to follow conventions

    @GetMapping(value = { "/", "/main.do", "/main/main.do" })
    public String goMain(HttpSession session, Model model, PageObject pageObject, String cityname, String countrycode
			, String filename) {
        log.info("MainController.goMain() --------------------------");
        
        try {
            // 이벤트 리스트 가져오기
            model.addAttribute("eventList", eventService.listEvent()); // Use the injected service to get the list
         // 여행정보 리스트 가져오기
            model.addAttribute("infoList", infoService.list(pageObject,cityname,countrycode,filename)); // 여행정보 리스트

            // JSP 파일 경로 반환 (/WEB-INF/views/main/main2.jsp)
            return "main/main"; // 반환할 JSP 파일의 이름 (경로는 설정에 따라 /WEB-INF/views/main/main2.jsp로 매핑됨)

        } catch (Exception e) {
            // 예외 발생 시 에러 페이지로 이동
            log.error("Error occurred in MainController.goMain(): ", e);
            model.addAttribute("error", e.getMessage()); // 에러 메시지를 모델에 추가
            return "error/500"; // 에러 페이지 반환
        }
    }

}
