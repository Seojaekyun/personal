package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import com.example.demo.dto.MemberDto;
import com.example.demo.mapper.LoginMapper;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("ls")
public class LoginServiceImpl implements LoginService {
    @Autowired
    private LoginMapper mapper;

	@Override
	public String login(HttpServletRequest request,Model model) 
	{
		String err=request.getParameter("err");
		String pcode=request.getParameter("pcode");
		model.addAttribute("pcode",pcode);
		model.addAttribute("err",err);
		return "/login/login";
	}

	@Override
	public String loginOk(MemberDto mdto,HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response)
	{
		// 아이디, 비밀번호가 dto에 저장
		String name=mapper.loginOk(mdto);
		//System.out.println(name);
		if(name != null) // 로그인성공
		{
			// pcode쿠키변수에 있는 상품과 수량을 cart테이블에 저장하기
			Cookie cookie=WebUtils.getCookie(request, "pcode");
			
			if(cookie != null  && !cookie.getValue().equals("")) // 쿠키의 값이 비어있지 않을때
			{
				String[] pcodes=cookie.getValue().split("/");  // 상품코드-수량/상품코드-수량/상품코드-수량/
				
				for(int i=0;i<pcodes.length;i++)
				{
					String pcode=pcodes[i].substring(0,12);
					int su=Integer.parseInt( pcodes[i].substring(13) );
					
					// cart테이블에 존재한다면 수량증가
					if(mapper.isCart(pcode,mdto.getUserid()))
					{
					    mapper.upCart(pcode,mdto.getUserid(),su);
					}
					else
					{
						mapper.addCart(pcode,su,mdto.getUserid());
					}
					
					
				}
				
				// 쿠키변수 pcode의 값을 없애기
				Cookie cookie2=new Cookie("pcode","");
				cookie2.setMaxAge(0);
				cookie2.setPath("/");
				response.addCookie(cookie2);
			}
			
			
			
			
			// 세션변수 만들기
			session.setAttribute("userid", mdto.getUserid());
			session.setAttribute("name", name);
			if(mdto.getPcode().length()==0)
			{
			    return "redirect:/main/index";
			}
			else
			{
				return "redirect:/product/productContent?pcode="+mdto.getPcode();
			}
		} // 로그인 성공 if문
		else
		{
			return "redirect:/login/login?err=1&pcode="+mdto.getPcode();
		}
		 
	}

	@Override
	public String logout(HttpSession session)
	{
		session.invalidate();
		return "redirect:/main/index";
	}
}









