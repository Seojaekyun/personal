package kr.co.jk.dto;

import lombok.Data;

@Data
public class BaesongDto {
	private int id, gibon, req;
	private String userid, name, zip, juso, jusoEtc, phone;

	// 배송방법 문자처리
	private String breq;

	// 배송지 처음입력 or 추가입력
	private String tt;
}
