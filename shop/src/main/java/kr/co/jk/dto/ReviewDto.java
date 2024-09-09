package kr.co.jk.dto;

import lombok.Data;

@Data
public class ReviewDto {
	private int id, star;
	private String content, oneLine, userid, pcode, writeday;

}
