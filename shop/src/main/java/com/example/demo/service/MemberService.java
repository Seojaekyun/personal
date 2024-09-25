package com.example.demo.service;

import org.springframework.ui.Model;

import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ReviewDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public interface MemberService {
    public String member();
    public String useridCheck(String userid);
    public String memberOk(MemberDto mdto);
    public String cartView(HttpSession session, HttpServletRequest request,Model model);
    public String cartDel(HttpServletRequest request,HttpSession session,HttpServletResponse response);
    public int[] chgSu(HttpServletRequest request,HttpSession session,HttpServletResponse response);
    public String jjimList(HttpSession session,Model model);
    public String addCart(HttpServletRequest request,HttpSession session);
    public String jjimDel(HttpServletRequest request, HttpSession session);
    public String jumunList(HttpSession session,Model model,HttpServletRequest request);
    public String chgState(HttpServletRequest request);
    //public String jumunList2(HttpSession session,Model model);
    //public String jumunList3(HttpSession session,Model model);
    public String reviewWrite(HttpServletRequest request,Model model);
    public String reviewWriteOk(ReviewDto rdto,HttpSession session);
    public String monthView(HttpServletRequest request,Model model,HttpSession session);
    public String memberView(HttpSession session, Model model,HttpServletRequest request);
    public String chgEmail(HttpSession session, HttpServletRequest request);
    public String chgPhone(HttpSession session, HttpServletRequest request);
    public String pwdChg(HttpServletRequest request,HttpSession session);
    public String myBaesong(HttpSession session,Model model);
    public String baeDel(HttpServletRequest request, HttpSession session);
    public String baeUpdate(HttpServletRequest request,HttpSession session,Model model);
    public String baeUpdateOk(BaesongDto bdto,HttpSession session);
    public String jusoWrite();
    public String jusoWriteOk(BaesongDto bdto,HttpSession session);
    public String myReview(HttpSession session, Model model);
    public String reviewDel(HttpSession session, HttpServletRequest request);
    public String reviewUpdate(HttpServletRequest request,
    		HttpSession session, Model model);
    public String reviewUpdateOk(ReviewDto rdto,HttpSession session);
    
    public String myQna(HttpSession session, Model model);
    public String qnaDel(HttpServletRequest request,HttpSession session);
    
    public String viewAnswer(HttpServletRequest request);
}
