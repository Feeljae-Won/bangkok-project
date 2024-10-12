package com.bangkok.ajaxairReservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.bangkok.airReservation.service.AirReservationService;
import com.bangkok.airReservation.vo.BaggageTypeVO;
import com.bangkok.airReservation.vo.CountryVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/ajax")
@Log4j
public class AirReservationAjaxController {
    
    @Autowired
    @Qualifier("AirReservationServiceImpl")
    private AirReservationService service;
    
    @GetMapping(value = "/getCountry.do", 
    		produces = {
					MediaType.APPLICATION_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
			})
    
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getCountry() {
    	
        List<CountryVO> countryList = service.selectCountry();
        
        Map<String, Object> map = new HashMap<String, Object>();
        
        log.info("Country List: " + countryList);
        
        map.put("countryList", countryList);
        
        return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);  // JSON 형식으로 반환
    }
    
    @GetMapping(value = "/getBaggageType.do", produces = {
            MediaType.APPLICATION_XML_VALUE,
            MediaType.APPLICATION_JSON_UTF8_VALUE
    })
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getBaggageType() {
        
        List<BaggageTypeVO> baggageTypeList = service.selectBaggage();
        
        Map<String, Object> map = new HashMap<>();
        
        log.info("Baggage Type List: " + baggageTypeList);
        
        map.put("baggageTypeList", baggageTypeList);
        
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    
}
