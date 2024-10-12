package com.bangkok.plan.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bangkok.plan.vo.PlanVO;
import com.bangkok.planDetail.vo.PlanDetailVO;

@Service
public interface PlanService {

	// 1. 여행 계획 리스트
	public List<PlanVO> list();
	
	// 2-1. 여행 계획 상세보기
	public PlanVO view(Long tno);
	
	// 2-2 방문지 리스트
	public List<PlanDetailVO> planList(Long tno);
	
	// 2-3. 방문지 상세보기
	public PlanDetailVO planView(Long pno);
	
	// write
	public Integer write(PlanVO vo);
	
	// update
	public Integer update(PlanVO vo);
	
	// update
	public Integer delete(Long tno);
	
}
