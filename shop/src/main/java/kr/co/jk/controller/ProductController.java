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
import kr.co.jk.dto.BaesongDto;
import kr.co.jk.dto.GumaeDto;
import kr.co.jk.service.ProductService;

@Controller
public class ProductController {

	@Autowired
	@Qualifier("ps")
	private ProductService service;
	
	@RequestMapping("/product/productList")
	public String productList(HttpServletRequest request, Model model) {
		return service.productList(request, model);
	}
	
	@RequestMapping("/product/productContent")
	public String productContent(HttpServletRequest request, Model model, HttpSession session) {
		return service.productContent(request, model, session);
	}
	
	@RequestMapping("/product/jjimOk")
	public @ResponseBody String jjimOk(HttpServletRequest request, HttpSession session) {
		return service.jjimOk(request, session);
	}
	
	@RequestMapping("/product/addCart")
	public @ResponseBody String addCart(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		return service.addCart(request, session, response);
	}
	
	@RequestMapping("/product/gumae")
	public String gumae(HttpSession session, HttpServletRequest request, Model model) {
		return service.gumae(session, request, model);
	}
	
	@RequestMapping("/product/jusoWrite")
	public String jusoWrite(HttpServletRequest request, Model model) {
		return service.jusoWrite(request, model);
	}
	
	@RequestMapping("/product/jusoWriteOk")
	public String jusoWriteOk(BaesongDto bdto, Model model, HttpSession session) {
		return service.jusoWriteOk(bdto, model, session);
	}
	
	@RequestMapping("/product/jusoList")
	public String jusoList(HttpServletRequest request, Model model, HttpSession session) {
		System.out.println(request.getHeader("referer"));
		
		return service.jusoList(model, session);
	}
	
	@RequestMapping("/product/chgPhone")
	public @ResponseBody String chgPhone(HttpServletRequest request, HttpSession session) {
		return service.chgPhone(request, session);
	}
	
	@RequestMapping("/product/jusoDel")
	public String jusoDel(HttpServletRequest request) {
		return service.jusoDel(request);
	}
	
	@RequestMapping("/product/jusoUpdate")
	public String jusoUpdate(HttpServletRequest request, Model model) {
		return service.jusoUpdate(request, model);
	}
	
	@RequestMapping("/product/jusoUpdateOk")
	public String jusoUpdateOk(BaesongDto bdto, HttpSession session) {
		// 보안관련으로 세션을 보낼수도 있다
		return service.jusoUpdateOk(bdto, session);
	}
	
	@RequestMapping("/product/gumaeOk")
	public String gumaeOk(GumaeDto gdto, HttpSession session) {
		return service.gumaeOk(gdto, session);
	}
}
