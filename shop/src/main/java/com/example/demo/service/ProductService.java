package com.example.demo.service;

import org.springframework.ui.Model;

import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.GumaeDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public interface ProductService {
    public String productList(HttpServletRequest request,Model model);
    public String productContent(HttpServletRequest request,Model model,HttpSession session);
    public String jjimOk(HttpServletRequest request,HttpSession session);
    public String addCart(HttpServletRequest request,HttpSession session,HttpServletResponse response);
    public String gumae(HttpSession session,HttpServletRequest request,Model model);
    public String jusoWriteOk(BaesongDto bdto,Model model,HttpSession session);
    public String jusoList(Model model, HttpSession session);
    public String jusoWrite(HttpServletRequest request,Model model);
    public String chgPhone(HttpServletRequest request,HttpSession session);
    public String jusoDel(HttpServletRequest request);
    public String jusoUpdate(HttpServletRequest request,Model model);
    public String jusoUpdateOk(BaesongDto bdto,HttpSession session);
    public String gumaeOk(GumaeDto gdto,HttpSession session);
    public String gumaeView(HttpServletRequest request,Model model);
    public String gumaeView2(HttpServletRequest request,Model model);
    public String reviewDel(HttpServletRequest request);
    public String questWriteOk(HttpServletRequest requet,HttpSession session);
    public String questDel(HttpServletRequest request);
}

