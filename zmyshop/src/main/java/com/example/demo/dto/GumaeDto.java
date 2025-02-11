package com.example.demo.dto;

import lombok.Data;

@Data
public class GumaeDto {
	private int id, baeId, su, useJuk, chongPrice, sudan;
	private int card, halbu, bank, lcard, tong, nbank;
	private int state, isReview;
	private String userid, pcode, jumuncode, writeday;

	// 여러상품의 수량,상품코드를 배열
	private int[] sues;
	private String[] pcodes;

}
