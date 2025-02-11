package collection;

import java.util.HashSet;
import java.util.Iterator;
import java.util.SortedSet;
import java.util.TreeSet;

public class SetEx {
	public static void main(String[] args) {
		// Set 계열 => 순서가 없다, 중복불가
		// Collection => Set => HashSet, SortedSet, TreeSet
		// Collection co=new HashSet();
		// Set ss=new HashSet();

		HashSet<String> set1 = new HashSet<String>();
		TreeSet<String> set2 = new TreeSet<String>();
		SortedSet<String> set3 = new TreeSet<String>();

		set1.add("홍길동");
<<<<<<< HEAD
		set1.add("배트맨");
		set1.add("슈퍼맨");
		set2.add("뽀로로");
		set3.add("배트맨");
=======
		set2.add("배트맨");
		set3.add("슈퍼맨");
		set1.add("뽀로로");
		set1.add("배트맨");
>>>>>>> branch 'master' of https://github.com/Seojaekyun/personal.git

		System.out.println(set1.toString());

		// 전체 값을 출력
		Iterator<String> it = set1.iterator();
		while (it.hasNext()) {
			System.out.println(it.next());
		}

		// size()
		System.out.println(set1.size());

		// remove(), clear()는 List와 동일하다.
	}
}
