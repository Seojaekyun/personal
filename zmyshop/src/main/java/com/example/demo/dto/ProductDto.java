package com.example.demo.dto;

import lombok.Data;

@Data
public class ProductDto {
	private int id, price, halin, su, baeprice, baeday, juk, pansu, review, halinPrice, jukPrice, ystar, hstar, gstar;
	private String pcode, pimg, dimg, title, writeday, baeEx;
	private double star;
	
}
