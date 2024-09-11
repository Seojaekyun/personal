package kr.co.jk.dto;

import lombok.Data;

@Data
public class ProductDto {
	private int id, price, halin, su, baeprice, baeday, juk, pansu, halinPrice, jukPrice;
	private double star;
	private String pcode, pimg, dimg, title, writeday, review;
	
	private String baeEx;

	private int ystar, hstar, gstar;
	
}
