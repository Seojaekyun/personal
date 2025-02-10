package kr.co.jk.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dto.MemberDto;
import kr.co.jk.service.LoginService;

@Controller
public class LoginController {

	@Autowired
	@Qualifier("ls")
	private LoginService service;

	@GetMapping("/login/login")
	public String login(HttpServletRequest request, Model model) {
		return service.login(request, model);
	}

	@PostMapping("/login/loginOk")
	public String loginOk(MemberDto mdto, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		return service.loginOk(mdto, session, request, response);
	}

	@GetMapping("/login/logout")
	public String logout(HttpSession session) {
		return service.logout(session);
	}
}
