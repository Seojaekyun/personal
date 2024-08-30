package kr.co.jk.util;

import java.text.DecimalFormat;

public class Test {
    public static void main(String[] args) {
    	double num=12345.65678;
    	
		DecimalFormat df=new DecimalFormat("#");
		System.out.println( df.format(num) );
		
		df=new DecimalFormat("0");
		System.out.println( df.format(num) );
		
		df=new DecimalFormat("#.##");
		System.out.println( df.format(num) );
		
		df=new DecimalFormat("0.00");
		System.out.println( df.format(num) );
		
		df=new DecimalFormat("########.##");
		System.out.println( df.format(num) );
		
		df=new DecimalFormat("00000000.00");
		System.out.println( df.format(num) );
		
		df=new DecimalFormat("#,###");
		System.out.println( df.format(num) );
		
		df=new DecimalFormat("0,000");
		System.out.println( df.format(num) );
	}
}
