package com.example.demo.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.DaeDto;
import com.example.demo.dto.JungDto;
import com.example.demo.dto.SoDto;
import com.example.demo.service.MainService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
 
@Controller
public class MainController {
   
	@Autowired
	@Qualifier("ms")
	private MainService service;
	
	@RequestMapping("/")
	public String home()
	{
		return "redirect:/main/index";
	}
	
	@RequestMapping("/main/index")
	public String index(Model model)
	{
		return service.index(model);
	}
	
	@RequestMapping("/main/getDae")
	public @ResponseBody ArrayList<DaeDto> getDae()
	{
		return service.getDae();
	}
	
	@RequestMapping("/main/getJung")
	public @ResponseBody ArrayList<JungDto> getJung(HttpServletRequest request)
	{
		return service.getJung(request);
	}
	
	@RequestMapping("/main/getSo")
	public @ResponseBody ArrayList<SoDto> getSo(HttpServletRequest request)
	{
		return service.getSo(request);
	}
	
	@RequestMapping("/main/category")
	public String category()
	{
		return "/main/category";
	}
	
	@RequestMapping("/main/spinner")
	public String spinner()
	{
		return "/main/spinner";
	}
	
	@RequestMapping("/main/cartNum")
	public @ResponseBody String cartNum(HttpServletRequest request,HttpSession session)
	{
		return service.cartNum(request,session);
	}
	
	@RequestMapping("/main/this")
	public String this1()
	{
		return "/main/this";
	}
	
	@RequestMapping("/main/this2")
	public String this2()
	{
		return "/main/this2";
	}
	 
	@RequestMapping("/main/imgTest")
	public String imgTest()
	{
		return "/main/imgTest";
	}
	
	@RequestMapping("/main/timeTest")
	public String timeTest()
	{
		return "/main/timeTest";
	}
	@RequestMapping("/main/timeTest2")
	public String timeTest2()
	{
		return "/main/timeTest2";
	}
	@RequestMapping("/main/timeTest3")
	public String timeTest3()
	{
		return "/main/timeTest3";
	}
}






