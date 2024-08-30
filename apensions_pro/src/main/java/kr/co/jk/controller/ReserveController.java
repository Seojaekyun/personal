package kr.co.jk.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.pension.dao.ReserveDao;
import kr.co.pension.dto.ReserveDto;
import kr.co.pension.dto.RoomDto;
import kr.co.pension.util.Utils;

@Controller
public class ReserveController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/reserve/reserve")
	public String reserve(HttpServletRequest request, Model model) {
		int year, month;
		if(request.getParameter("year")==null) {
			LocalDate today = LocalDate.now(); // 오늘 날짜를 생성
			year=today.getYear(); // 오늘 기준 해당 년도
			month=today.getMonthValue(); // 오늘 기준 해당 월
		}
		else {
			year=Integer.parseInt(request.getParameter("year"));
			month=Integer.parseInt(request.getParameter("month"));
			
			if(month==0) {
				year=year-1;
				month=12;
			}
			if(month==13) {
				year=year+1;
				month=1;
			}
		}
		
		LocalDate xday= LocalDate.of(year, month, 1); // 오늘 기준 해당월의 시작일
		
		int yoil=xday.getDayOfWeek().getValue();
		if(yoil==7) // 일요일 부터 시작되도록
			yoil=0;
		
		int chong=xday.lengthOfMonth(); // 해당 월의 총 일수
		int ju=(int)Math.ceil((yoil+chong)/7.0); // 해당 월의 주의 수
				
		model.addAttribute("yoil", yoil);
		model.addAttribute("chong", chong);
		model.addAttribute("ju", ju);
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		
		ReserveDao rdao=sqlSession.getMapper(ReserveDao.class);
		ArrayList<RoomDto> rlist=rdao.getRooms();
		model.addAttribute("rlist", rlist);
		
		HashMap<String, Integer> map=new HashMap<String, Integer>();
		for(int i=0;i<rlist.size();i++) {
			for(int j=1;j<=chong;j++) {
				String date=year+"-"+month+"-"+j;
				int id=rlist.get(i).getId();
				int cnt;
				if(rdao.isCheck(date, id)) {
					cnt=1;
					map.put(j+"-"+id, cnt);
				}
				else {
					cnt=0;
					map.put(j+"-"+id, cnt);
				}
			}
		}
		model.addAttribute("map", map);
		return "/reserve/reserve";
	}
	
	@RequestMapping("/reserve/reserveNext")
	public String reserveNext(HttpServletRequest request, Model model, HttpSession session) {
		int year=Integer.parseInt(request.getParameter("year"));
		int month=Integer.parseInt(request.getParameter("month"));
		int day=Integer.parseInt(request.getParameter("day"));
		int id=Integer.parseInt(request.getParameter("id")); // room테이블 id
		
		if(session.getAttribute("userid")==null) {
			return "redirect:/member/login?year="+year+"&month="+month+"&day="+day+"&id="+id;
		}
		else {
			// 입실날짜 출력 => ????-??-??   , ????년 ??월 ??일  
			String month2=String.format("%02d",month);
			String day2=String.format("%02d", day);
			String date=year+"-"+month2+"-"+day2;  //입실일
			
			ReserveDao rdao=sqlSession.getMapper(ReserveDao.class);
			RoomDto rdto=rdao.getRoom(id);
			
			// 뷰에 전달하기전에 옵션추가
			// br태그추가
			String content=rdto.getContent().replace("\r\n","<br>");
			rdto.setContent(content);
			// 사진을 분리해서 뷰에 전달
			String[] imgs=rdto.getRimg().split("/");
			rdto.setImgs(imgs);
			
			// 1박 가격을 ,를 붙여서 dto에 저장
	 	    String price2=Utils.comma(rdto.getPrice());
	 	    rdto.setPrice2(price2);
			
	 	    // reserveNext에서 몇박을 선택할때 가는한 일수를 구해서 전달
	 	    // 입실날짜를 구한다 2024-08-11
	 	    // 위의 체크가 1이 나올때까지
	 	    int suk=0;
	 	    LocalDate xday=LocalDate.of(year, month, day);
	 	    for(int i=1;i<=8;i++) {
	 	    	// 8월 11일이 가능한지
	 	    	if(rdao.isCheck(xday.toString(),id)) {
	 	    		break;
	 	    	}
	 	    	else { // 예약 가능
	 	    		suk++;
	 	    	}
	 	    	
	 	    	xday=xday.plusDays(1); // 날짜를 하루 증가시킨다.
	 	    }
	 	    model.addAttribute("suk", suk);
	 	    
			model.addAttribute("rdto", rdto);
			model.addAttribute("date", date);
			//System.out.println(date);
			return "/reserve/reserveNext";
		}
	}
	
	@RequestMapping("/reserve/reserveOk")
	public String reserveOk(ReserveDto rdto, HttpSession session) {
		LocalDate dday=Utils.getDate(rdto.getInday(), rdto.getSuk());
		/* System.out.println(dday.toString()); 출력 테스트 */
		rdto.setOutday(dday.toString());
		
		String jumuncode="j"+Utils.dateToString();
		
		ReserveDao rdao=sqlSession.getMapper(ReserveDao.class);
		int num=rdao.getJumuncode(jumuncode)+1;
		
		jumuncode=jumuncode+String.format("%03d", num);
		rdto.setJumuncode(jumuncode);
		rdto.setUserid(session.getAttribute("userid").toString());
		
		rdao.reserveOk(rdto);
		
		return "redirect:/reserve/reserveView";
	}
	
	@RequestMapping("/reserve/reserveView")
	public String reserveView(HttpServletRequest request, Model model) {
		String jumuncode=request.getParameter("jumuncode");
		
		ReserveDao rdao=sqlSession.getMapper(ReserveDao.class);
		ReserveDto rdto=rdao.reserveView(jumuncode);
		
		String price2=Utils.comma(rdto.getChgprice());
		model.addAttribute("price2", price2);
		
		RoomDto rdto2=rdao.getRoom(rdto.getRid());
		
		model.addAttribute("title", rdto2.getTitle());
		model.addAttribute("rdto", rdto);
		
		return "/reserve/reserveView";
	}
	
	
}