package com.bangkok.planDetail.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bangkok.planDetail.vo.PlanDetailVO;

@Repository
public interface PlanDetailMapper {

	// 1. list
	public List<PlanDetailVO> planList(@Param(value = "tno") Long tno);
	
	// 2. view
	public PlanDetailVO planView(@Param(value = "pno") Long pno);
	
}
