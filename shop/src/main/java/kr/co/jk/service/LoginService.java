package kr.co.jk.service;

import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dto.MemberDto;

public interface LoginService {
	String login(HttpServletRequest request, Model model);
	String logout(HttpSession session);
	String loginOk(MemberDto mdto, HttpSession session, HttpServletRequest request, HttpServletResponse response);

}
