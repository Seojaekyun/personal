package kr.co.jk.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.ArrayList;

import jakarta.servlet.http.HttpServletRequest;

import kr.co.jk.dto.RoomDto;

public class Utils {
    // 자주 사용되는 값 처리를 메소드로
	public static String comma(int val) {
		DecimalFormat df=new DecimalFormat("#,###");
		
		return df.format(val);
	}
	
	public static void getRooms(HttpServletRequest request) throws Exception {
		Class.forName("com.mysql.jdbc.Driver"); // 라이브러리를 찾아라
		String db="jdbc:mysql://localhost:3306/pension";
		Connection conn=DriverManager.getConnection(db,"root","1234");
		
		String sql="select title, id from room order by price asc";
		
		PreparedStatement pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		
		ArrayList<RoomDto> rlist=new ArrayList<RoomDto>();
		
		while(rs.next()) {
			RoomDto rdto=new RoomDto();
			rdto.setId(rs.getInt("id"));
			rdto.setTitle(rs.getString("title"));
			
			rlist.add(rdto);
		}
		
		request.setAttribute("rlist", rlist);
		
		conn.close();
	}
	
	public static LocalDate getDate(String date, int day) {
		String[] ymd=date.split("-");
		
		int y=Integer.parseInt(ymd[0]);
		int m=Integer.parseInt(ymd[1]);
		int d=Integer.parseInt(ymd[2]);
		
		LocalDate xday=LocalDate.of(y, m, d);
		LocalDate dday=xday.plusDays(day);
		
		return dday;
	}
	
	public static String dateToString() {
		LocalDate today=LocalDate.now();
		return today.toString().replace("-", "");
	}
	
	public static boolean isCheck(String date, int rid) throws Exception {
		// DB연결
		Class.forName("com.mysql.jdbc.Driver"); // 라이브러리를 찾아라
		String db="jdbc:mysql://localhost:3306/pension";
		Connection conn=DriverManager.getConnection(db,"root","1234");
		
		String sql="select count(*) as cnt from reserve where inday <= ?  and outday > ? and rid=?";
		PreparedStatement pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, date);
		pstmt.setString(2, date);
		pstmt.setInt(3, rid);
		
		ResultSet rs=pstmt.executeQuery();
		rs.next();
		int cnt=rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		conn.close();
		
		if(cnt==0) {
			return false;
		}
		else {
			return true;
		}
	}
	
	public static boolean dayBefore(String date) {
		String[] imsi=date.split("-");
		int y=Integer.parseInt(imsi[0]);
		int m=Integer.parseInt(imsi[1]);
		int d=Integer.parseInt(imsi[2]);
		LocalDate xday=LocalDate.of(y, m, d);
		
		LocalDate today=LocalDate.now();
		
		if(today.isBefore(xday)||today.isEqual(xday)) {
			return true;
		}
		else {
			return false;
		}
	}
	
	public static boolean dayBefore2(String date) {
		String[] imsi=date.split("-");
		int y=Integer.parseInt(imsi[0]);
		int m=Integer.parseInt(imsi[1]);
		int d=Integer.parseInt(imsi[2]);
		LocalDate xday=LocalDate.of(y, m, d);
		
		LocalDate today=LocalDate.now();
		
		if(today.isBefore(xday)) {
			return true;
		}
		else {
			return false;
		}
	}
	
}
