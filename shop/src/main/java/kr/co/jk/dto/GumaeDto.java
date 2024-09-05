package kr.co.jk.dto;

import lombok.Data;

@Data
public class GumaeDto {
    private int id, baeId, su, useJuk, chongPrice, sudan, card, halbu, bank, lcard, tong, nbank, state, isReview;
    private String userid, pcode, jumuncode, writeday;
    private int[] sues;
    private String[] pcodes;
	
}
