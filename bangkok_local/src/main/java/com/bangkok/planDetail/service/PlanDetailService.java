package com.bangkok.planDetail.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.bangkok.planDetail.vo.PlanDetailVO;

@Service
public interface PlanDetailService {

	public List<PlanDetailVO> planList(Long tno);
	
	public PlanDetailVO planView(Long pno);
	
}
