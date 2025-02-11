package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ReviewDto;
import com.example.demo.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@Controller
public class MemberController {

	@Autowired
	@Qualifier("ms")
	private MemberService service;
	
	@GetMapping("/member/member")
	public String member() {
		return service.member();
	}
	
	@GetMapping("/member/useridCheck")
	public @ResponseBody String useridCheck(HttpServletRequest request) {
		return service.useridCheck(request);
	}
	
	@PostMapping("/member/memberOk")
	public String memberOk(MemberDto mdto) {
		return service.memberOk(mdto);
	}
	
	@GetMapping("/member/cartView")
	public String cartView(HttpSession session, HttpServletRequest request, Model model) {
		return service.cartView(session, request, model);
	}

	@GetMapping("/member/cartDel")
	public String cartDel(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		return service.cartDel(request, session, response);
	}

	@GetMapping("/member/chgSu")
	public @ResponseBody int[] chgSu(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		return service.chgSu(request, session, response);
	}
	
	@GetMapping("/member/jjimList")
	public String jjimList(HttpSession session, Model model) {
		return service.jjimList(session, model);
	}
	
	@GetMapping("/member/jjimDel")
	public String jjimDel(HttpServletRequest request, HttpSession session) {
		return service.jjimDel(request, session);
	}
	
	@GetMapping("/member/addCart")
	public @ResponseBody String addCart(HttpServletRequest request, HttpSession session) {
		return service.addCart(request, session);
	}
	
	@GetMapping("/member/jumunList")
	public String jumunList(HttpSession session, Model model, HttpServletRequest request) {
		return service.jumunList(session, model, request);
	}

	@GetMapping("/member/monthView")
	public String monthView(HttpServletRequest request, Model model, HttpSession session) {
		return service.monthView(request, model, session);
	}

	/*
	 * @RequestMapping("/member/jumunList2") public String jumunList2(HttpSession
	 * session, Model model) { return service.jumunList2(session,model); }
	 * 
	 * @RequestMapping("/member/jumunList3") public String jumunList3(HttpSession
	 * session, Model model) { return service.jumunList3(session,model); }
	 */
	@GetMapping("/member/chgState")
	public String chgState(HttpServletRequest request) {
		return service.chgState(request);
	}

	@GetMapping("/member/reviewWrite")
	public String reviewWrite(HttpServletRequest request, Model model) {
		return service.reviewWrite(request, model);
	}

	@PostMapping("/member/reviewWriteOk")
	public String reviewWriteOk(ReviewDto rdto, HttpSession session) {
		return service.reviewWriteOk(rdto, session);
	}

	@GetMapping("/member/eventTest")
	public String eventTest() {
		return "/member/eventTest";
	}

	@GetMapping("/member/memberView")
	public String memberView(HttpSession session, Model model, HttpServletRequest request) {
		return service.memberView(session, model, request);
	}

	@GetMapping("/member/chgEmail")
	public @ResponseBody String chgEmail(HttpSession session, HttpServletRequest request) {
		return service.chgEmail(session, request);
	}

	@GetMapping("/member/chgPhone")
	public @ResponseBody String chgPhone(HttpSession session, HttpServletRequest request) {
		return service.chgPhone(session, request);
	}

	@GetMapping("/member/pwdChg")
	public String pwdChg(HttpServletRequest request, HttpSession session) {
		return service.pwdChg(request, session);
	}

	@GetMapping("/member/myBaesong")
	public String myBaesong(HttpSession session, Model model) {
		return service.myBaesong(session, model);
	}

	@GetMapping("/member/baeDel")
	public String baeDel(HttpServletRequest request, HttpSession session) {
		return service.baeDel(request, session);
	}

	@GetMapping("/member/baeUpdate")
	public String baeUpdate(HttpServletRequest request, HttpSession session, Model model) {
		return service.baeUpdate(request, session, model);
	}

	@GetMapping("/member/baeUpdateOk")
	public String baeUpdateOk(BaesongDto bdto, HttpSession session) {
		return service.baeUpdateOk(bdto, session);
	}

	@GetMapping("/member/jusoWrite")
	public String jusoWrite() {
		return service.jusoWrite();
	}

	@PostMapping("/member/jusoWriteOk")
	public String jusoWriteOk(BaesongDto bdto, HttpSession session) {
		return service.jusoWriteOk(bdto, session);
	}

	@GetMapping("/member/myReview")
	public String myReview(HttpSession session, Model model) {
		return service.myReview(session, model);
	}

	@GetMapping("/member/reviewDel")
	public String reviewDel(HttpSession session, HttpServletRequest request) {
		return service.reviewDel(session, request);
	}

	@GetMapping("/member/reviewUpdate")
	public String reviewUpdate(HttpServletRequest request, HttpSession session, Model model) {
		return service.reviewUpdate(request, session, model);
	}

	@PostMapping("/member/reviewUpdateOk")
	public String reviewUpdateOk(ReviewDto rdto, HttpSession session) {
		return service.reviewUpdateOk(rdto, session);
	}

	@GetMapping("/member/myQna")
	public String myQna(HttpSession session, Model model) {
		return service.myQna(session, model);
	}

	@GetMapping("/member/qnaDel")
	public String qnaDel(HttpServletRequest request, HttpSession session) {
		return service.qnaDel(request, session);
	}

	@GetMapping("/member/viewAnswer")
	public @ResponseBody String viewAnswer(HttpServletRequest request) {
		return service.viewAnswer(request);
	}
	
	
}