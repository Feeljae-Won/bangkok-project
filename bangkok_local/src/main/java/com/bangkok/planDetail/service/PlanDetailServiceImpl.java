package com.bangkok.planDetail.service;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bangkok.planDetail.mapper.PlanDetailMapper;
import com.bangkok.planDetail.vo.PlanDetailVO;

@Service
@Qualifier("planDetailServiceImpl")
public class PlanDetailServiceImpl implements PlanDetailService {

	@Inject
	PlanDetailMapper mapper;
	
	@Override
	public List<PlanDetailVO> planList(Long tno) {
		return mapper.planList(tno);
	}

	@Override
	public PlanDetailVO planView(Long pno) {
		// TODO Auto-generated method stub
		return mapper.planView(pno);
	}
	
}
