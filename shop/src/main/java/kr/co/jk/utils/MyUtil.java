package kr.co.jk.utils;

import java.time.LocalDate;

public class MyUtil {
	public static String getYoil(LocalDate xday) {
		int d=xday.getDayOfWeek().getValue();
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
	
}

