package com.bangkok.city.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bangkok.city.vo.CityVO;

@Service
public interface CityService {

	public List<CityVO> list();
	
}
