package kr.co.jk.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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

	@GetMapping("/")
	public String home() {
		return "redirect:/main/index";
	}

	@GetMapping("/main/index")
	public String index(Model model) {
		return service.index(model);
	}

	@GetMapping("/main/getDae")
	public @ResponseBody ArrayList<DaeDto> getDae() {
		return service.getDae();
	}

	@GetMapping("/main/getJung")
	public @ResponseBody ArrayList<JungDto> getJung(HttpServletRequest request) {
		return service.getJung(request);
	}

	@GetMapping("/main/getSo")
	public @ResponseBody ArrayList<SoDto> getSo(HttpServletRequest request) {
		return service.getSo(request);
	}

	@GetMapping("/main/category")
	public String category() {
		return "/main/category";
	}

	@PostMapping("/main/spinner")
	public String spinner() {
		return "/main/spinner";
	}

	@GetMapping("/main/cartNum")
	public @ResponseBody String cartNum(HttpServletRequest request, HttpSession session) {
		return service.cartNum(request, session);
	}

	@GetMapping("/main/this")
	public String this1() {
		return "/main/this";
	}

	@GetMapping("/main/this2")
	public String this2() {
		return "/main/this2";
	}

	@GetMapping("/main/imgTest")
	public String imgTest() {
		return "/main/imgTest";
	}

	@GetMapping("/main/timeTest")
	public String timeTest() {
		return "/main/timeTest";
	}

	@GetMapping("/main/timeTest2")
	public String timeTest2() {
		return "/main/timeTest2";
	}

	@GetMapping("/main/timeTest3")
	public String timeTest3() {
		return "/main/timeTest3";
	}

}