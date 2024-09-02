package kr.co.jk.service;

import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dto.MemberDto;

public interface MemberService {
	String member();
	String useridCheck(String userid);
	String memberOk(MemberDto mdto);
	String cartView(HttpSession session, HttpServletRequest request, Model model);
	String cartDel(HttpSession session, HttpServletRequest request, HttpServletResponse response);
	int[] chgSu(HttpServletRequest request, HttpSession session, HttpServletResponse response);
	String jjimList(HttpSession session, Model model);
	String addCart(HttpServletRequest request, HttpSession session);
	String jjimDel(HttpServletRequest request, HttpSession session);
	
}
