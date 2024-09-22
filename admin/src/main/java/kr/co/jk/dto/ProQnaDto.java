package kr.co.jk.dto;

import lombok.Data;

@Data
public class ProQnaDto {
	private int id, qna, ref;
    private String title, userid, pcode, content, writeday;

}
