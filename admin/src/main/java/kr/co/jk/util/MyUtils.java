package kr.co.jk.util;

import java.io.File;
import java.util.concurrent.ThreadLocalRandom;

import java.util.concurrent.ThreadLocalRandom;

import org.springframework.util.ResourceUtils;

public class MyUtils {
	public static String getFileName(String fname, String str) throws Exception {
		File ff=new File(str);
		
		while(ff.exists()) {
			String code="";
				int num=(int)(ThreadLocalRandom.current().nextDouble()*62);
			for(int i=1;i<=4;i++) {
				int num=(int)(ThreadLocalRandom.current().nextDouble()*62);
				
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
	
}
