package com.example.demo.service;

import org.springframework.ui.Model;

import com.example.demo.dto.MemberDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public interface LoginService {
    public String login(HttpServletRequest request,Model model);
    public String loginOk(MemberDto mdto,HttpSession session,HttpServletRequest request,HttpServletResponse response);
    public String logout(HttpSession session);
}
