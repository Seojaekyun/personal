package com.example.demo.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class ProductDto {
   private int id,price,halin,su,baeprice,baeday,juk,pansu,review;
   private double star;
   private String pcode, pimg, dimg, title,writeday;
   //private LocalDate writeday;
   // 할인후 상품금액, 적립금액, 배송일관련
   private int halinPrice, jukPrice;
   private String baeEx;
   
   // 노란별,반별,회색별
   private int gstar,hstar,ystar;
   
   // 타임세일 관련
   private int sales;
   private String salesDay;
}
