package com.example.demo.service;

import org.springframework.ui.Model;

import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ReviewDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public interface MemberService {
    String member();
    String useridCheck(HttpServletRequest request);
    String memberOk(MemberDto mdto);
	String cartView(HttpSession session, HttpServletRequest request, Model model);
	String cartDel(HttpServletRequest request, HttpSession session, HttpServletResponse response);
	int[] chgSu(HttpServletRequest request, HttpSession session, HttpServletResponse response);
	String jjimList(HttpSession session, Model model);
	String jjimDel(HttpServletRequest request, HttpSession session);
	String addCart(HttpServletRequest request, HttpSession session);
	String jumunList(HttpSession session, Model model, HttpServletRequest request);
	String monthView(HttpServletRequest request, Model model, HttpSession session);
	String chgState(HttpServletRequest request);
	String reviewWrite(HttpServletRequest request, Model model);
	String reviewWriteOk(ReviewDto rdto, HttpSession session);
	String memberView(HttpSession session, Model model, HttpServletRequest request);
	String chgEmail(HttpSession session, HttpServletRequest request);
	String chgPhone(HttpSession session, HttpServletRequest request);
	String pwdChg(HttpServletRequest request, HttpSession session);
	String myBaesong(HttpSession session, Model model);
	String baeDel(HttpServletRequest request, HttpSession session);
	String baeUpdate(HttpServletRequest request, HttpSession session, Model model);
	String baeUpdateOk(BaesongDto bdto, HttpSession session);
	String jusoWrite();
	String jusoWriteOk(BaesongDto bdto, HttpSession session);
	String myReview(HttpSession session, Model model);
	String reviewDel(HttpSession session, HttpServletRequest request);
	String reviewUpdate(HttpServletRequest request, HttpSession session, Model model);
	String reviewUpdateOk(ReviewDto rdto, HttpSession session);
	String myQna(HttpSession session, Model model);
	String qnaDel(HttpServletRequest request, HttpSession session);
	String viewAnswer(HttpServletRequest request);
    
    
}
