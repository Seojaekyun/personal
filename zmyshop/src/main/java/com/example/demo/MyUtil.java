package com.example.demo;

import java.io.File;
import java.time.LocalDate;

import org.springframework.util.ResourceUtils;

import com.example.demo.dto.ProductDto;

public class MyUtil {

	public static String getNewPwd() {
		String newPwd="";
		for(int i=1;i<=6;i++) {
			int num=(int)(Math.random()*62); // 0~61까지의 정수
			// 0~9:(48~57)숫자   , 10~35:(65~90)대문자  , 36~61:(97~122)소문자
			if(num<10) {
				num=num+48;
			}
			else if(num<36) {
				num=num+55;
			}
			else {
				num=num+61;
			}
			
			newPwd=newPwd+(char)num;
		}
		
		return newPwd;
	}
	
	public static String getNewPwd2() {
		String newPwd="";
		for(int i=1;i<=6;i++) {
			int num=(int)(Math.random()*90); // 0~89까지의 정수
			// (33~47)특수문자 , (48~57)숫자 (58~64)특수문자   , 
			// (65~90)대문자, (91~96)특수문자  , (97~122)소문자
			
			num=num+33;
			
			newPwd=newPwd+(char)num;
		}
		
		return newPwd;
	}
	
	public static String getFileName(String fname, String str) throws Exception {
		File ff=new File(str);
		
		while(ff.exists()) {
			String code="";
			
			for(int i=1;i<=4;i++) {
				int num=(int)(Math.random()*62);
				
				if(num>=0&&num<=9) {
					num=num+48;
				}
				else if(num>=10&&num<=35) {
					num=num+55;
				}
				else {
					num=num+61;
				}
				
				code=code+(char)num;
			}
			
			String[] imsi=fname.split("[.]");
			String newFname=imsi[0]+code+"."+imsi[1];
			str=ResourceUtils.getFile("classpath:static/product").toPath().toString()+"/"+newFname;
			
			ff=new File(str);
			
			System.out.println(code);
		}
		
		return str;
	}
	
	public static int[] getStar(double star) {
		// 노란별, 반별, 회색별의 갯수를 전달
		int ystar=0, hstar=0, gstar=0;
					
		// 노란별의 갯수
		ystar=(int)star;
					
		// 소수점 구하기 => 노, 반, 회 지정
		double imsi=star-ystar;
					
		if(imsi>=0.8) {
			ystar++;
		}
		else if(imsi<0.8 && imsi>=0.2) {
			hstar=1;
		}
					
		// 회색별 =>  5-(노란별+반별)
		gstar=5-(ystar+hstar);
					
		// ystar,hstar,gstar 가 생성=>배열로 리턴
		int[] stars=new int[3];
		stars[0]=ystar;
		stars[1]=hstar;
		stars[2]=gstar;
		
		return stars;
	}
	
	public static void getStar(double star, ProductDto pdto) {
		// 노란별, 반별, 회색별의 갯수를 전달
		int ystar=0, hstar=0, gstar=0;
					
		// 노란별의 갯수
		ystar=(int)star;
					
		// 소수점 구하기 => 노, 반, 회 지정
		double imsi=star-ystar;
					
		if(imsi>=0.8) {
			ystar++;
		}
		else if(imsi<0.8&&imsi>=0.2) {
			hstar=1;
		}
					
		// 회색별 =>  5-(노란별+반별)
		gstar=5-(ystar+hstar);
					
		// ystar,hstar,gstar 가 생성=> dto에 저장
		pdto.setYstar(ystar);
		pdto.setHstar(hstar);
		pdto.setGstar(gstar);
	}
	
	public static String getYoil(LocalDate xday) {
		int d=xday.getDayOfWeek().getValue(); // 1~7 (월~일)
		String yoil=null;
		switch(d) {
			case 1: yoil="월"; break;
			case 2: yoil="화"; break;
			case 3: yoil="수"; break;
			case 4: yoil="목"; break;
			case 5: yoil="금"; break;
			case 6: yoil="토"; break;
			case 7: yoil="일"; break;
		}
		
		return yoil;
	}
	
	public static String getBaesong(int baeday) {
		LocalDate today=LocalDate.now();			
		// 오늘날짜에서 minus(),plus()메소드를 이용하여 몇일 전,후의 날짜를 생성
		LocalDate xday=today.plusDays(baeday);
		int m=xday.getMonthValue(); // 월
		int d=xday.getDayOfMonth(); // 일
				
		// 요일 getDayofWeek() => sunday => .getValue() =>  1~7까지의 값
		int dd=xday.getDayOfWeek().getValue();
		String yoil=null;
		switch(dd) {
			case 1: yoil="월"; break;
			case 2: yoil="화"; break;
			case 3: yoil="수"; break;
			case 4: yoil="목"; break;
			case 5: yoil="금"; break;
			case 6: yoil="토"; break;
			case 7: yoil="일"; break;
		}
		
		String baeEx="";
		if(baeday==1) {
			baeEx="내일("+yoil+") 도착예정";
		}
		else if(baeday==2) {
			baeEx="모레("+yoil+") 도착예정";
		}
		else {
			baeEx=m+"/"+d+"("+yoil+") 도착예정";
		}
		
		return baeEx;
	}
	
	public static void getBaesong(ProductDto pdto) {
		LocalDate today=LocalDate.now();			
		// 오늘날짜에서 minus(),plus()메소드를 이용하여 몇일 전,후의 날짜를 생성
		LocalDate xday=today.plusDays(pdto.getBaeday());
		int m=xday.getMonthValue(); // 월
		int d=xday.getDayOfMonth(); // 일
				
		// 요일 getDayofWeek() => sunday => .getValue() =>  1~7까지의 값
		int dd=xday.getDayOfWeek().getValue();
		String yoil=null;
		switch(dd) {
			case 1: yoil="월"; break;
			case 2: yoil="화"; break;
			case 3: yoil="수"; break;
			case 4: yoil="목"; break;
			case 5: yoil="금"; break;
			case 6: yoil="토"; break;
			case 7: yoil="일"; break;
		}
		
		String baeEx="";
		if(pdto.getBaeday()==1) {
			baeEx="내일("+yoil+") 도착예정";
		}
		else if(pdto.getBaeday()==2) {
			baeEx="모레("+yoil+") 도착예정";
		}
		else {
			baeEx=m+"/"+d+"("+yoil+") 도착예정";
		}
		
		pdto.setBaeEx(baeEx);
	}
	
}
