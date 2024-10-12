package com.bangkok.info.vo;

import java.sql.Date;
import java.util.List;
import lombok.Data;

@Data
public class InfoVO {
	
	private Long no;
	private String title;
	private String content;
	private String writer;
	private Integer cityNum;
	private String cityname;
	private String countrycode;
	private String Place;
	private Integer cate_code1;
	private Date writeDate;
	private String filename;
	private Integer image_no;
	private String imageFile;
	private String cate_name;
	
	public List<String> imageList;
}
