package kr.co.jk.dto;

import lombok.Data;

@Data
public class BoardDto {
	private int id,rnum,bid;
	private String uid,name,title,writer,content,pwd,writeday,inday,email,phone,rimg,wuid;
	
	private String[] imgs;
    
	
}
