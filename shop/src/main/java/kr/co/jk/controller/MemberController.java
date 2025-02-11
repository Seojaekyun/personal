package kr.co.jk.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dto.BaesongDto;
import kr.co.jk.dto.MemberDto;
import kr.co.jk.dto.ReviewDto;
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
		String userid = request.getParameter("userid");

		return service.useridCheck(userid);
	}

	@RequestMapping("/member/memberOk")
	public String memberOk(MemberDto mdto) {
		return service.memberOk(mdto);
	}

	@RequestMapping("/member/cartView")
	public String cartView(HttpSession session, HttpServletRequest request, Model model) {
		return service.cartView(session, request, model);
	}

	@RequestMapping("/member/cartDel")
	public String cartDel(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		return service.cartDel(request, session, response);
	}

	@RequestMapping("/member/chgSu")
	public @ResponseBody int[] chgSu(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		return service.chgSu(request, session, response);
	}

	@GetMapping("/member/jjimList")
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
	public String jumunList(HttpSession session, Model model, HttpServletRequest request) {
		return service.jumunList(session, model, request);
	}

	@RequestMapping("/member/monthView")
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

	@RequestMapping("/member/reviewWrite")
	public String reviewWrite(HttpServletRequest request, Model model) {
		return service.reviewWrite(request, model);
	}

	@RequestMapping("/member/reviewWriteOk")
	public String reviewWriteOk(ReviewDto rdto, HttpSession session) {
		return service.reviewWriteOk(rdto, session);
	}

	@RequestMapping("/member/eventTest")
	public String eventTest() {
		return "/member/eventTest";
	}

	@RequestMapping("/member/memberView")
	public String memberView(HttpSession session, Model model, HttpServletRequest request) {
		return service.memberView(session, model, request);
	}

	@RequestMapping("/member/chgEmail")
	public @ResponseBody String chgEmail(HttpSession session, HttpServletRequest request) {
		return service.chgEmail(session, request);
	}

	@RequestMapping("/member/chgPhone")
	public @ResponseBody String chgPhone(HttpSession session, HttpServletRequest request) {
		return service.chgPhone(session, request);
	}

	@RequestMapping("/member/pwdChg")
	public String pwdChg(HttpServletRequest request, HttpSession session) {
		return service.pwdChg(request, session);
	}

	@RequestMapping("/member/myBaesong")
	public String myBaesong(HttpSession session, Model model) {
		return service.myBaesong(session, model);
	}

	@RequestMapping("/member/baeDel")
	public String baeDel(HttpServletRequest request, HttpSession session) {
		return service.baeDel(request, session);
	}

	@RequestMapping("/member/baeUpdate")
	public String baeUpdate(HttpServletRequest request, HttpSession session, Model model) {
		return service.baeUpdate(request, session, model);
	}

	@RequestMapping("/member/baeUpdateOk")
	public String baeUpdateOk(BaesongDto bdto, HttpSession session) {
		return service.baeUpdateOk(bdto, session);
	}

	@RequestMapping("/member/jusoWrite")
	public String jusoWrite() {
		return service.jusoWrite();
	}

	@RequestMapping("/member/jusoWriteOk")
	public String jusoWriteOk(BaesongDto bdto, HttpSession session) {
		return service.jusoWriteOk(bdto, session);
	}

	@RequestMapping("/member/myReview")
	public String myReview(HttpSession session, Model model) {
		return service.myReview(session, model);
	}

	@RequestMapping("/member/reviewDel")
	public String reviewDel(HttpSession session, HttpServletRequest request) {
		return service.reviewDel(session, request);
	}

	@RequestMapping("/member/reviewUpdate")
	public String reviewUpdate(HttpServletRequest request, HttpSession session, Model model) {
		return service.reviewUpdate(request, session, model);
	}

	@RequestMapping("/member/reviewUpdateOk")
	public String reviewUpdateOk(ReviewDto rdto, HttpSession session) {
		return service.reviewUpdateOk(rdto, session);
	}

	@RequestMapping("/member/myQna")
	public String myQna(HttpSession session, Model model) {
		return service.myQna(session, model);
	}

	@RequestMapping("/member/qnaDel")
	public String qnaDel(HttpServletRequest request, HttpSession session) {
		return service.qnaDel(request, session);
	}

	@RequestMapping("/member/viewAnswer")
	public @ResponseBody String viewAnswer(HttpServletRequest request) {
		return service.viewAnswer(request);
	}
}
