package kr.co.jk.dto;

import lombok.Data;

@Data
public class MemberDto {
	private int id, juk, state;
	private String userid, pwd, name, email, phone, writeday, pcode;

}
