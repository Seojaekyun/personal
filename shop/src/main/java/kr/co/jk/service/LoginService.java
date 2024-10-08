package kr.co.jk.service;

import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dto.MemberDto;

public interface LoginService {
	public String login(HttpServletRequest request, Model model);

	public String loginOk(MemberDto mdto, HttpSession session, HttpServletRequest request,
			HttpServletResponse response);

	public String logout(HttpSession session);
}
