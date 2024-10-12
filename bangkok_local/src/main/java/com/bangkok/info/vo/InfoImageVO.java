package com.bangkok.info.vo;

import java.util.List;
import lombok.Data;

@Data
public class InfoImageVO {
	
	private Long image_no;
	private Long no;
	private String filename;
	public List<String> imageList;
}