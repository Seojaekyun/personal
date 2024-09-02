package collection;

import java.util.HashSet;

public class SetLotto {
    public static void main(String[] args) {
		
    	HashSet<Integer> lotto=new HashSet<Integer>();
    	
    	while(lotto.size()<6)
    	{
    	   int num=(int)(Math.random()*45)+1;
    	   lotto.add(num);
    	   System.out.println(num);
    	}
    	System.out.println("=========");
    	System.out.println(lotto.toString());
	}
}
