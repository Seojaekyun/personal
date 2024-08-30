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
	
}
