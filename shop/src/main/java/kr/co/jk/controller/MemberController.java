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
import kr.co.jk.dto.ReviewDto;
import kr.co.jk.service.MemberService;
import org.springframework.web.bind.annotation.GetMapping;


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
	
	@RequestMapping("/member/chgSu")
    public @ResponseBody int[] chgSu(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		return service.chgSu(request, session, response);
	}
	
	@RequestMapping("/member/jjimList")
    public String jjimList(HttpSession session, Model model) {
		return service.jjimList(session, model);
	}
	
	@GetMapping("/member/addCart")
	public @ResponseBody String addCart(HttpServletRequest request, HttpSession session) {
		return service.addCart(request, session);
	}
	
	@GetMapping("/member/jjimDel")
    public String jjimDel(HttpServletRequest request, HttpSession session) {
    	return service.jjimDel(request, session);
    }
	
	@RequestMapping("/member/jumunList")
	public String jumunList(HttpSession session, Model model) {
		return service.jumunList(session,model);
	}
	
	@RequestMapping("/member/chgState")
	public String chgState(HttpServletRequest request) {
		return service.chgState(request);
	}
	
	@RequestMapping("/member/reviewWrite")
    public String reviewWrite(HttpServletRequest request,Model model) {
		return service.reviewWrite(request,model);
	}
    
    @RequestMapping("/member/reviewWriteOk")
    public String reviewWriteOk(ReviewDto rdto,HttpSession session) {
    	return service.reviewWriteOk(rdto,session);
    }
	

}
