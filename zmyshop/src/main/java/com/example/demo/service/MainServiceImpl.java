package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import com.example.demo.MyUtil;
import com.example.demo.dto.DaeDto;
import com.example.demo.dto.JungDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.SoDto;
import com.example.demo.mapper.MainMapper;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("ms")
public class MainServiceImpl implements MainService {
	@Autowired
	private MainMapper mapper;
	
	public List<ProductDto> calPro(List<ProductDto> plist) {
		for (int i=0;i<plist.size();i++) {
			ProductDto pdto=plist.get(i);
			// 할인후 상품금액 => 상품금액-(상품금액*(할인율/100))
			int halinPrice=(int)(pdto.getPrice()-(pdto.getPrice()*(pdto.getHalin()/100.0)));
			// 적립금액 => 상품금액*(적립률/100)
			int jukPrice=(int)(pdto.getPrice()*(pdto.getJuk()/100.0));
			
			MyUtil.getBaesong(pdto);
			MyUtil.getStar(pdto.getStar(),pdto);
			
			plist.get(i).setHalinPrice(halinPrice);
			plist.get(i).setJukPrice(jukPrice);
		}
		
		return plist;
	}
	
	@Override
	public String index(Model model) {
		// 특가상품, 최신상품, 타임세일,최다판매 =>4개씩 가져오기
		List<ProductDto> plist1=mapper.getProduct1();
		List<ProductDto> plist2=mapper.getProduct2();
		List<ProductDto> plist3=mapper.getProduct3();
		List<ProductDto> plist4=mapper.getProduct4();
		
		plist1=this.calPro(plist1); // 타임
		plist2=this.calPro(plist2); // 특가
		plist3=this.calPro(plist3); // 최신
		plist4=this.calPro(plist4); // 판매량

		model.addAttribute("plist1", plist1);
		model.addAttribute("plist2", plist2);
		model.addAttribute("plist3", plist3);
		model.addAttribute("plist4", plist4);

		return "/main/index";
	}

	@Override
	public List<DaeDto> getDae() {
		return mapper.getDae();
	}

	@Override
	public List<JungDto> getJung(HttpServletRequest request) {
		int imsi=Integer.parseInt(request.getParameter("daecode"));
		
		String daecode=String.format("%02d", imsi); // 2자리 만들기
		
		return mapper.getJung(daecode);
	}
	
	@Override
	public List<SoDto> getSo(HttpServletRequest request) {
		int imsi=Integer.parseInt(request.getParameter("daejung"));
		String daejung=String.format("%04d", imsi);
		
		return mapper.getSo(daejung);
	}
	
	@Override
	public String cartNum(HttpServletRequest request, HttpSession session) {
		String cnum=null;
		if (session.getAttribute("userid")==null) {
			Cookie cookie=WebUtils.getCookie(request, "pcode");
			
			if(cookie!=null&&!cookie.getValue().equals("")) {
				String[] pcodes=cookie.getValue().split("/");
				
				cnum=pcodes.length + "";
			}
			else {
				// 0으로 처리
				cnum = "0";
			}
		}
		else {
			String userid=session.getAttribute("userid").toString();
			cnum=mapper.getCartNum(userid);
		}
		
		return cnum;
	}
	
}
