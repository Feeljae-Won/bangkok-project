package com.bangkok.plan.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bangkok.plan.mapper.PlanMapper;
import com.bangkok.plan.vo.PlanVO;
import com.bangkok.planDetail.vo.PlanDetailVO;

@Service
@Qualifier("planServiceImpl")
public class PlanServiceImpl implements PlanService{

	@Inject
	private PlanMapper mapper;
	
	// 1. 여행 계획 리스트
	@Override
	public List<PlanVO> list() {
		return mapper.list();
	}

	// 2-1. 여행 계획 상세보기
	@Override
	public PlanVO view(Long tno) {
		// TODO Auto-generated method stub
		return mapper.view(tno);
	}

	// 2-2. 방문지 리스트
	@Override
	public List<PlanDetailVO> planList(Long tno) {
		// TODO Auto-generated method stub
		return mapper.planList(tno);
	}
	
	// 2-3. 방문지 리스트
	@Override
	public PlanDetailVO planView(Long pno) {
		// TODO Auto-generated method stub
		return mapper.planView(pno);
	}
	
	@Override
	public Integer write(PlanVO vo) {
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}

	@Override
	public Integer update(PlanVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public Integer delete(Long tno) {
		// TODO Auto-generated method stub
		return mapper.delete(tno);
	}



}
