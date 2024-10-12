package com.bangkok.plan.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bangkok.plan.vo.PlanVO;
import com.bangkok.planDetail.vo.PlanDetailVO;

@Repository
public interface PlanMapper {

	// 여행 계획 리스트-완료
	public List<PlanVO> list();

	// 2-1. 여행 게획 상세보기-완료
	public PlanVO view(@Param(value = "tno") Long tno);
	
	// 2-2. 여행 게획 상세보기-완료
	public List<PlanDetailVO> planList(@Param(value = "tno") Long tno);
	
	// 2-3. 여행 게획 상세보기-완료
	public PlanDetailVO planView(@Param(value = "pno") Long pno);
	
	// 3. 여행 계획 등록
	public Integer write(PlanVO vo);

	// 4. 여행 계획 수정
	public Integer update(PlanVO vo);

	// 5. 여행 계획 삭제-완료
	public Integer delete(@Param(value = "tno") Long tno);
	
}
