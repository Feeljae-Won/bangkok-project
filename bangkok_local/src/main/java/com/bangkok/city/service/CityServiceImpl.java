package com.bangkok.city.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bangkok.city.mapper.CityMapper;
import com.bangkok.city.vo.CityVO;

@Service
@Qualifier("cityServiceImpl")
public class CityServiceImpl implements CityService{

	@Inject
	CityMapper mapper;
	
	public List<CityVO> list(){
		return mapper.list();
	};
	
}
