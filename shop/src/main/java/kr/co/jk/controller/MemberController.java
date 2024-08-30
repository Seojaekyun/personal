package kr.co.jk.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dto.MemberDto;
import kr.co.jk.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	@Qualifier("ms2")
	private MemberService service;
	
	@RequestMapping("/member/member")
	public String member() {
		return service.member();
	}
	
	@RequestMapping("/member/useridCheck")
	public @ResponseBody String useridCheck(HttpServletRequest request) {
		String userid=request.getParameter("userid");
		
		return service.useridCheck(userid);
	}
	
	@RequestMapping("/member/memberOk")
	public String memberOk(MemberDto mdto) {
		return service.memberOk(mdto);
	}
	
	@RequestMapping("/member/cartView")
    public String cartView(HttpSession session, HttpServletRequest request, Model model) {
		return service.cartView(session,request,model);
	}
	
	@RequestMapping("/member/cartDel")
    public String cartDel(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		return service.cartDel(session,request,response);
	}
	

}
