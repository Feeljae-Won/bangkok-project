package com.bangkok.city.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bangkok.city.vo.CityVO;

@Repository
public interface CityMapper {

	public List<CityVO> list();
	
}
