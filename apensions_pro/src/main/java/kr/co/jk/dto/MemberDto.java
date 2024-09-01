package kr.co.jk.dto;

import lombok.Data;

@Data
public class MemberDto {
	private int id,state;
	private String userid,name,pwd,email,phone,writeday;
	
}
