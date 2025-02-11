package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.example.demo.MyUtil;
import com.example.demo.dto.MemberDto;
import com.example.demo.mapper.LoginMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("ls")
public class LoginServiceImpl implements LoginService{
	
	@Autowired
	private LoginMapper mapper;

	@Override
	public String login(HttpServletRequest request,Model model) {
		String err=request.getParameter("err");
		
		model.addAttribute("err",err);
		
 		return "/login/login";
	}
	
	@Override
	public String loginOk(MemberDto mdto,HttpSession session) {
		String name=mapper.loginOk(mdto);
		if(name==null) {
			return "redirect:/login/login?err=1";
		}
		else {
			session.setAttribute("userid", mdto.getUserid());
			session.setAttribute("name", name);
			
			return "redirect:/main/index";
		}
		 
	}

	@Override
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/main/index";
	}

	@Override
	public String getUserid(MemberDto mdto) {
		String userid=mapper.getUserid(mdto);
		return userid;
	}

	@Override
	public String getPwd(MemberDto mdto) throws Exception {
		String pwd=mapper.getPwd(mdto);
		
		if(pwd!=null) {
			String imsiPwd=MyUtil.getNewPwd2();
			
			mapper.chgPwd(mdto.getUserid(),imsiPwd,pwd);
			
			return "임시 비밀번호 : "+imsiPwd;
		}
		else
			return "정보가 일치하지 않습니다";
	}
	
	
}
