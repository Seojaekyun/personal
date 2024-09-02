package kr.co.jk.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dto.DaeDto;
import kr.co.jk.dto.JungDto;
import kr.co.jk.dto.SoDto;
import kr.co.jk.service.MainService;

@Controller
public class MainController {
	@Autowired
	@Qualifier("ms")
	private MainService service;
	
	@RequestMapping("/")
	public String home() {
		return "redirect:/main/index";
	}
	
	@RequestMapping("/main/index")
	public String index() {
		return service.index();
	}
	
	@RequestMapping("/main/getDae")
	public @ResponseBody ArrayList<DaeDto> getDae() {
		return service.getDae();
	}
	
	@RequestMapping("/main/getJung")
	public @ResponseBody ArrayList<JungDto> getJung(HttpServletRequest request) {
		return service.getJung(request);
	}
	
	@RequestMapping("/main/getSo")
	public @ResponseBody ArrayList<SoDto> getSo(HttpServletRequest request) {
		return service.getSo(request);
	}
	
	@RequestMapping("/main/category")
	public String category() {
		return "/main/category";
	}
	
	@RequestMapping("/main/spinner")
	public String spinner() {
		return "/main/spinner";
	}
	
	@RequestMapping("/main/cartNum")
	public @ResponseBody String cartNum(HttpServletRequest request, HttpSession session) {
		return service.cartNum(request, session);
	}
	
	@RequestMapping("/main/this")
	public String this1() {
		return "/main/this";
	}
	
	@RequestMapping("/main/this2")
	public String this2() {
		return "/main/this2";
	}
	
}