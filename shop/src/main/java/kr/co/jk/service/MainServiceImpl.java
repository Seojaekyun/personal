package kr.co.jk.service;

import java.time.LocalDate;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dto.DaeDto;
import kr.co.jk.dto.JungDto;
import kr.co.jk.dto.ProductDto;
import kr.co.jk.dto.SoDto;
import kr.co.jk.mapper.MainMapper;
import kr.co.jk.utils.MyUtil;

@Service
@Qualifier("ms")
public class MainServiceImpl implements MainService{
	@Autowired
	private MainMapper mapper;
	
	public ArrayList<ProductDto> calPro(ArrayList<ProductDto> plist) {
		for(int i=0;i<plist.size();i++)	{
			ProductDto pdto=plist.get(i);
			// 할인후 상품금액 => 상품금액-(상품금액*(할인율/100))
			int halinPrice=(int)(pdto.getPrice()-( pdto.getPrice()*( pdto.getHalin()/100.0) ));
			// 적립금액 => 상품금액*(적립률/100)
			int jukPrice=(int)(pdto.getPrice()*(pdto.getJuk()/100.0));
			
			// 배송예정일 =>  내일(요일) 배송예정  ,  모레(요일) 배송예정 ,  월/일(요일) 배송예정
			// 오늘기준으로 배송예정일의 날짜객체를 생성
			LocalDate today=LocalDate.now(); // 오늘날짜 객체생성
			// 오늘 기준 몇일 후의 날짜 객체
			LocalDate xday=today.plusDays(pdto.getBaeday());
			String yoil=MyUtil.getYoil(xday);
		
			String baeEx=null;
			if(pdto.getBaeday()==1) {
				baeEx="내일("+yoil+") 도착예정";  // 내일(화) 도착예정
			}
			else if(pdto.getBaeday()==2) {
				baeEx="모레("+yoil+") 도착예정"; // 모레(수) 도착예정
			}
			else {
				int m=xday.getMonthValue();
				int d=xday.getDayOfMonth();
				baeEx=m+"/"+d+"("+yoil+") 도착예정";
			}	
			
			// ArrayList내부에 있는 DTO에 새로운 값을 저장
			plist.get(i).setHalinPrice(halinPrice);
			plist.get(i).setJukPrice(jukPrice);
			plist.get(i).setBaeEx(baeEx);
			
			// 하나의 pdto에 있는 star값을 이용하여
			// 노란별,회색별,반별의 갯수를 dto에 저장하기
			double star=pdto.getStar(); // 4.8
			int ystar=0,hstar=0,gstar=0;
			
			ystar=(int)star;        // 4
			star=star-ystar; // 소수부분   // 0.8
			
			if(star>=0.8) {
				ystar++;            // 5
			}
			if(star<0.8 && star>=0.3) {
				hstar++;
			}
			gstar=5-(ystar+hstar);
			
			// 구한 노란별,회색별,반별의 값을 plist에 저장
			plist.get(i).setYstar(ystar);
			plist.get(i).setHstar(hstar);
			plist.get(i).setGstar(gstar);
			
			
		} // ArrayList의 for끝
		
		return plist;
	}
	
	@Override
	public String index(Model model) {
		ArrayList<ProductDto> plist1=mapper.getProduct1();
		ArrayList<ProductDto> plist2=mapper.getProduct2();
		ArrayList<ProductDto> plist3=mapper.getProduct3();
		ArrayList<ProductDto> plist4=mapper.getProduct4();
		
		plist1=this.calPro(plist1); // 타임
		//System.out.println(plist1.get(1).getBaeEx());
		plist2=this.calPro(plist2); // 특가
		plist3=this.calPro(plist3); // 최신
		plist4=this.calPro(plist4); // 판매량
		
	    model.addAttribute("plist1",plist1);
	    model.addAttribute("plist2",plist2);
	    model.addAttribute("plist3",plist3);
	    model.addAttribute("plist4",plist4);
		
		return "/main/index";
	}
	
	@Override
	public ArrayList<DaeDto> getDae() {		
		return mapper.getDae();
	}
	
	@Override
	public ArrayList<JungDto> getJung(HttpServletRequest request) {
		int imsi=Integer.parseInt(request.getParameter("daecode"));
		String daecode=String.format("%02d", imsi);
		
		return mapper.getJung(daecode);
	}
	
	@Override
	public ArrayList<SoDto> getSo(HttpServletRequest request) {
		int imsi=Integer.parseInt(request.getParameter("daejung"));
		String daejung=String.format("%04d", imsi);
		
		return mapper.getSo(daejung);
	}
	
	@Override
	public String cartNum(HttpServletRequest request, HttpSession session) {
		String cnum=null;
		if(session.getAttribute("userid")==null) {
			Cookie cookie=WebUtils.getCookie(request, "pcode");
			if(cookie!=null&&!cookie.getValue().equals("")) {
				String[] pcodes=cookie.getValue().split("/");
				cnum=pcodes.length+"";
			}
			else {
				cnum="0";
			}
		}
		else {
			String userid=session.getAttribute("userid").toString();
			cnum=mapper.getCartNum(userid);
		}
		
		return cnum;
	}
	
	
}