package com.bangkok.hotel.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bangkok.amenities.service.AmenitiesService;
import com.bangkok.hotel.controller.HotelController;
import com.bangkok.hotel.service.HotelService;
import com.bangkok.hotel.vo.HotelImageVO;
import com.bangkok.hotel.vo.HotelRoomVO;
import com.bangkok.hotel.vo.HotelVO;
import com.bangkok.hotel.vo.RoomImageVO;
import com.bangkok.util.page.PageObject;
import com.bangkok.util.file.FileUtil;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/hotel")
@Log4j
public class HotelController {

	// 자동 DI
	// @Setter(onMethod_ = @Autowired)
	// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
	@Autowired
	@Qualifier("hotelServiceImpl")
	private HotelService service;
	
	@Autowired
	@Qualifier("amenitiesServiceImpl")
	private AmenitiesService amenitiesService;
	
	String path = "/upload/hotel";
	
	// 상품 리스트
	@GetMapping("/list.do")
	// public ModelAndView list(Model model) {
	public String list(Model model, HttpServletRequest request)
			throws Exception {
	//	public String list(HttpServletRequest request) {
		log.info("list.do");
		// request.setAttribute("list", service.list());
		
		// 페이지 처리를 위한 객체 생겅
		PageObject pageObject = PageObject.getInstance(request);
		
		// 한 페이지당 보여주는 데이터의 개수가 없으면 기본은 8로 정한다.
		String strPerPageNum = request.getParameter("perPageNum");
			if(strPerPageNum == null || strPerPageNum.equals(""))
				pageObject.setPerPageNum(6);
			
			
		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
		model.addAttribute("list", service.list(pageObject));
		log.info(pageObject);
		model.addAttribute("pageObject", pageObject);
		return "hotel/list";
	}
	
	//--- 상품 글보기 ------------------------------------
	@GetMapping("/view.do")
	public String view(Model model, 
			@RequestParam(name = "no") Integer no, 
			@RequestParam(name = "inc") int inc
			) {
		log.info("view.do - no=" + no + ", inc=" + inc);
		
		// 상품 상세 정보 가져오기 - 현재 판매 가격 포함
		model.addAttribute("vo", service.view(no, inc));
		// 호텔 첨부 이미지 파일 리스트
		model.addAttribute("hotelImageList", service.hotelImageList(no));
//		// 객실 리스트
		model.addAttribute("hotelRoomList", service.hotelRoomList(no));
//		// 객실 첨부 이미지 파일 리스트
//		model.addAttribute("roomImageList", service.roomImageList(rno));
		// 편의시설 리스트
		model.addAttribute("amenitiesList", service.amenitiesList(no));
		
		return "hotel/view";
	}
	
	//--- 상품 글등록 폼 ------------------------------------
	@GetMapping("/writeForm.do")
	public String writeForm(Model model, Integer amenitiesNo) {
		log.info("writeForm.do");
		// 편의시설을 가져와서 JSP로 넘기기.
		model.addAttribute("amenitieslist", amenitiesService.list());
		return "hotel/writeForm";
	}
	
	//--- 상품 글등록 처리 ------------------------------------
	@PostMapping("/write.do")
	 public String write(@ModelAttribute HotelRoomVO roomVO, HotelVO vo,
			 
			 // 호텔 대표 이미지
			 MultipartFile imageFile, 
			 
			 // 상세보기 이동시 바로 보여지는 이미지
			 MultipartFile detailImageFile,
			 
			 // 호텔 추가 이미지들
				ArrayList<MultipartFile> imageFiles, 
				
				// 객실 대표 이미지
				ArrayList<MultipartFile> roomImageFile,
				
				Long perPageNum, 
				Long[] amenitiesNo,
				HttpServletRequest request) throws Exception {
				
				// getList에 객실에 대한 정보가 있음
				List<HotelRoomVO> hotelRoomList = roomVO.getList();
		
				log.info("----------- [ write.do ] --------------");
				log.info("호텔 대표 이미지 : " + imageFile.getOriginalFilename());
				log.info("상세보기 이동시 보여지는 이미지 : " + detailImageFile.getOriginalFilename());
				log.info("호텔 첨부 이미지 : ");
				for(MultipartFile file : imageFiles)
					log.info(file.getOriginalFilename());
				
				// 이미지 올리기와 DB에 저장할 데이터 수집
				log.info("<<<----- 이미지 처리 ----------------->>");
				
				log.info("호텔 객실 : " + roomVO.getList());
				
				log.info("" + Arrays.toString(amenitiesNo));
				
				// 호텔 대표 이미지 처리
				vo.setImage_name(FileUtil.upload(path, imageFile, request));
				
				String fileName = detailImageFile.getOriginalFilename();
				
				// 상세보기 이동시 보여지는 이미지
				if(fileName != null && !fileName.equals(""))
				vo.setDetail_image_name(FileUtil.upload(path, detailImageFile, request));
				
				// 호텔 첨부 이미지 - HotelImageVO
				List<HotelImageVO> hotelImageList = null;
				// 첨부 추가 있는 이미지가 있는 경우 처리
				if(imageFiles != null && imageFiles.size() > 0)
					for(MultipartFile file : imageFiles) {
						if(hotelImageList == null) hotelImageList = new ArrayList<>();
						fileName = file.getOriginalFilename();
						// 파일은 선택한 경우 처리
						if(fileName != null && !fileName.equals("")) {
							HotelImageVO hotelImageVO = new HotelImageVO();
							// 파일은 서버에 올리고 DB에 저장할 정보를 VO에 저장한다.
							hotelImageVO.setHotel_image_name(FileUtil.upload(path, file, request));
							hotelImageList.add(hotelImageVO);
						}
					}
				
				// 객실 대표 이미지 -
				// 첨부 추가 있는 이미지가 있는 경우 처리
				if(roomImageFile != null && roomImageFile.size() > 0)
					for(int i = 0; i < roomImageFile.size(); i++) {
						fileName = roomImageFile.get(i).getOriginalFilename();
						log.info(fileName);
						// 파일은 선택한 경우 처리
						if(fileName != null && !fileName.equals("")) {
							
							// 파일은 서버에 올리고 DB에 저장할 정보를 VO에 저장한다.
							hotelRoomList.get(i).setRoom_image_name(FileUtil.upload(path, 
									roomImageFile.get(i), request));
						}
					}
				
				log.info("객실 대표 이미지" + roomImageFile);
				// 객실 첨부 이미지 - HotelImageVO
				// 첨부 추가 있는 이미지가 있는 경우 처리
				for(HotelRoomVO rVO : hotelRoomList) { // 객실을 꺼내옴
					if(rVO.getRoomImage() != null && rVO.getRoomImage().size() > 0)
						for(MultipartFile file : rVO.getRoomImage()) { // 객실에 있는 이미지들을 꺼내옴
							if(rVO.getRoom_image_names() == null) rVO.setRoom_image_names(new ArrayList<>());
							fileName = file.getOriginalFilename();
							log.info(fileName);
							// 파일은 선택한 경우 처리
							if(fileName != null && !fileName.equals("")) {
								// 파일은 서버에 올리고 DB에 저장할 정보를 VO에 저장한다.
								rVO.getRoom_image_names().add(FileUtil.upload(path, file, request));
							}
						}
					}
				log.info("hotelImageList : " + hotelImageList);
				log.info("**********************" + hotelRoomList);
				
				service.write(vo, hotelImageList, hotelRoomList, amenitiesNo);
		return "redirect:list.do?perPageNum=" + perPageNum;
	   }

	//--- 상품 글수정 폼 ------------------------------------
	@GetMapping("/updateForm.do")
	public String updateForm(Integer no, Model model) {
		log.info("updateForm.do");
		
		model.addAttribute("vo", service.view(no, 0));
		
		return "goods/updateForm";
	}
	
	//--- 상품 글수정 처리 ------------------------------------
	@PostMapping("/update.do")
	public String update(HotelVO vo, RedirectAttributes rttr) {
		log.info("update.do");
		log.info(vo);
		if(service.update(vo) == 1)
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("msg", "상품 글수정이 되었습니다.");
		else
			rttr.addFlashAttribute("msg",
					"상품 글수정이 되지 않았습니다. "
					+ "글번호나 비밀번호가 맞지 않습니다. 다시 확인하고 시도해 주세요.");
		
		return "redirect:view.do";
	}
	
	
	//--- 상품 글삭제 처리 ------------------------------------
	@PostMapping("/delete.do")
	public String delete(HotelVO vo, RedirectAttributes rttr) {
		log.info("delete.do");
		log.info(vo);
		// 처리 결과에 대한 메시지 처리
		if(service.delete(vo) == 1) {
			rttr.addFlashAttribute("msg", "상품 글삭제가 되었습니다.");
			return "redirect:list.do";
		}
		else {
			rttr.addFlashAttribute("msg",
					"상품 글삭제가 되지 않았습니다. "
							+ "글번호나 비밀번호가 맞지 않습니다. 다시 확인하고 시도해 주세요.");
			return "redirect:view.do";
		}
	}
	
}
