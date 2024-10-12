package com.bangkok.category.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import com.bangkok.category.vo.CategoryVO;

@Repository
public interface CategoryMapper {

	// list
	public List<CategoryVO> list(@Param("cate_code1") Integer cate_code1);
	
	public static List<CategoryVO> getBigList() {
		// TODO Auto-generated method stub
		return null;
	}
	
}
