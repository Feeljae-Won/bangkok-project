package com.bangkok.info.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import com.bangkok.info.mapper.InfoMapper;
import com.bangkok.info.vo.InfoImageVO;
import com.bangkok.info.vo.InfoVO;
import com.bangkok.util.page.PageObject;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("infoServiceImpl")
public class InfoServiceImpl implements InfoService{

	@Inject
	private InfoMapper mapper;

		// list
		@Override
		public List<InfoVO> list(PageObject pageObject, String cityname, String countrycode
				, String filename){
			pageObject.setTotalRow(mapper.getTotalRow(pageObject));
			return mapper.list(pageObject);
		}
		
		// view
		@Override
		public InfoVO view(Long no) {
			return mapper.view(no);
		}
		
		
		// write
		@Override
		public Integer write(InfoVO vo) {
			Integer result = mapper.write(vo);
			return result;
		}
		
		// update
		@Override
		public Integer update(InfoVO vo) {
			return mapper.update(vo);
		}
		
		// delete
		@Override
		public Integer delete(InfoVO vo) {
			return mapper.delete(vo);
		}


		@Override
		public List<InfoImageVO> ImageList(Long no) {
		    List<InfoImageVO> imageList = mapper.imageList(no);
		    log.info("ImageList in Service: " + imageList);  // Add this to confirm the data in service
		    return imageList;
		}

		
}