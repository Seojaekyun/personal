package kr.co.jk.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dto.MemberDto;
import kr.co.jk.dto.ProductDto;
import kr.co.jk.mapper.MemberMapper;
import kr.co.jk.utils.MyUtil;

@Service
@Qualifier("ms2")
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberMapper mapper;
	
	@Override
	public String member() {
		return "/member/member";
	}
	
	@Override
	public String useridCheck(String userid) {
		return mapper.useridCheck(userid);
	}
	
	@Override
	public String memberOk(MemberDto mdto) {
		mapper.memberOk(mdto);
		
		return "redirect:/login/login";
	}
	
	@Override
	public String cartView(HttpSession session, HttpServletRequest request, Model model) {
		// 로그인의 유무에 따라 테이블, 쿠키변수
		ArrayList<HashMap> pMapAll=null;
		if(session.getAttribute("userid")==null) {
			Cookie cookie=WebUtils.getCookie(request, "pcode");
			if(cookie!=null) {
				String[] pcodes=cookie.getValue().split("/"); // 배열크기 3
				
				pMapAll=new ArrayList<HashMap>();
				
				for(int i=0;i<pcodes.length;i++) {
					String pcode=pcodes[i].substring(0,12);
					int su=Integer.parseInt(pcodes[i].substring(13));
					HashMap map=mapper.getProduct(pcode);
					
					map.put("csu", su);
					pMapAll.add(map);
				}
			}
		}
		else {
			String userid=session.getAttribute("userid").toString();
			pMapAll=mapper.getProductAll(userid);
			
			int a=Integer.parseInt(String.valueOf(pMapAll.get(0).get("csu")));
		}
		
		for(int i=0;i<pMapAll.size();i++) {
			HashMap map=pMapAll.get(i);
			int baeday=Integer.parseInt(map.get("baeday").toString());
			LocalDate today=LocalDate.now();
			LocalDate xday=today.plusDays(baeday);
			
			String yoil=MyUtil.getYoil(xday);
			String baeEx=null;
			
			if(baeday==1) {
				baeEx="내일("+yoil+") 도착 예정";
			}
			else if(baeday==2) {
				baeEx="모레("+yoil+") 도착 예정";
			}
			else {
				int m=xday.getMonthValue();
				int d=xday.getDayOfMonth();
				baeEx=m+"/"+d+"("+yoil+") 도착 예정";
			}
			
			pMapAll.get(i).put("baeEx", baeEx);
			
			int price=Integer.parseInt(map.get("price").toString());
			int halin=Integer.parseInt(map.get("halin").toString());
			int su=Integer.parseInt(map.get("csu").toString());
			int halinprice=(int)( price-(price*halin/100.0) )*su;
			pMapAll.get(i).put("halinprice", halinprice);
			
			int juk=Integer.parseInt(map.get("juk").toString());
			int jukprice=(int)(price*juk/100.0)*su;
			pMapAll.get(i).put("jukprice", jukprice);
		}
		
		model.addAttribute("pMapAll", pMapAll);
		return "/member/cartView";
	}
	
}