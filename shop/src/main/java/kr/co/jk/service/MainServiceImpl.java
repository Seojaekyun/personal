package kr.co.jk.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dto.DaeDto;
import kr.co.jk.dto.JungDto;
import kr.co.jk.dto.SoDto;
import kr.co.jk.mapper.MainMapper;

@Service
@Qualifier("ms")
public class MainServiceImpl implements MainService{
	@Autowired
	private MainMapper mapper;
	
	@Override
	public String index() {
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