package com.bangkok.info.service;

import java.util.List;
import com.bangkok.info.vo.InfoImageVO;
import com.bangkok.info.vo.InfoVO;
import com.bangkok.util.page.PageObject;

public interface InfoService {

	public List<InfoVO> list(PageObject pageObject, String cityname, String countrycode
			, String filename);
	

	public InfoVO view(Long no);
	public List<InfoImageVO> ImageList(Long no);
	
	

	public Integer write(InfoVO vo);

	public Integer update(InfoVO vo);
	
	public Integer delete(InfoVO vo);


}