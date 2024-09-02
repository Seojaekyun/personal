package collection;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class MapEx {

	public static void main(String[] args) {
		// Map => 저장할때 키와 값을 저장 =>  name,홍길동
		// 키는 중복이 불가 , 값은 중복가능
        //Map<String,String> map=new HashMap<String,String>();
		HashMap<String,String> map=new HashMap<String,String>();
		map.put("name", "홍길동");
		map.put("age", "33");
		map.put("phone", "010-1234-5678");
	    map.put("name", "배트맨");
		 
		 
		// size()
		System.out.println(map.size());
		
		// get(key) 
		System.out.println(map.get("name"));
		
		// remove(), clear();
		
		// 전체출력
		Set<String> s1=map.keySet(); // key만 가져온다.
		
		Iterator<String> it =s1.iterator();
		
		while(it.hasNext())
		{
			System.out.println( map.get(it.next()) );
		}
		
		System.out.println(map.toString());
	}

}


