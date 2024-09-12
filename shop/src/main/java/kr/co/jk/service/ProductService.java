package kr.co.jk.service;

import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dto.BaesongDto;
import kr.co.jk.dto.GumaeDto;

public interface ProductService {
	String productList(HttpServletRequest request, Model model);
	String productContent(HttpServletRequest request, Model model, HttpSession session);
	String jjimOk(HttpServletRequest request, HttpSession session);
	String addCart(HttpServletRequest request, HttpSession session, HttpServletResponse response);
	String gumae(HttpSession session, HttpServletRequest request, Model model);
	String jusoWriteOk(BaesongDto bdto, Model model, HttpSession session);
	String jusoList(Model model, HttpSession session);
	String jusoWrite(HttpServletRequest request, Model model);
	String chgPhone(HttpServletRequest request, HttpSession sessio);
	String jusoDel(HttpServletRequest request);
	String jusoUpdate(HttpServletRequest request, Model model);
	String jusoUpdateOk(BaesongDto bdto, HttpSession session);
	String gumaeOk(GumaeDto gdto, HttpSession session);
	String gumaeView(HttpServletRequest request, Model model);
	String gumaeView2(HttpServletRequest request, Model model);
	String reviewDel(HttpServletRequest request);
	String questWriteOk(HttpServletRequest request, HttpSession session);

}
