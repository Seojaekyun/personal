package com.example.demo.service;

import org.springframework.ui.Model;

import com.example.demo.dto.MemberDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public interface LoginService {
    String login(HttpServletRequest request,Model model);
    String logout(HttpSession session);
    String getUserid(MemberDto mdto);
    String getPwd(MemberDto mdto) throws Exception;
	String loginOk(MemberDto mdto, HttpSession session, HttpServletRequest request, HttpServletResponse response);
}
