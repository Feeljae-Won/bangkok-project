package com.bangkok.info.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import com.bangkok.category.vo.CategoryVO;
import com.bangkok.info.vo.InfoImageVO;
import com.bangkok.info.vo.InfoVO;
import com.bangkok.util.page.PageObject;

@Repository
public interface InfoMapper {

	// list
	public List<InfoVO> list(PageObject pageObject);
	
	public Long getInfo(PageObject pageObject);
	
	// getTotalRow
	public Long getTotalRow(PageObject pageObject);

	// view
	public InfoVO view(@Param("no") Long no); // data를 가져올 때
	public List<InfoImageVO> imageList(Long image_no);
	
	// write
	public Integer write(InfoVO vo);
	public Integer writeImage(List<InfoImageVO> imageList);
	
	// update
	public Integer update(InfoVO vo);

	// delete
	public Integer delete(InfoVO vo);
	
	public List<CategoryVO> getCategory(@Param("cate_code1") Integer cate_code1);

	
}