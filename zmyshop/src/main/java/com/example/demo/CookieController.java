package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.WebUtils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@RestController
public class CookieController {
	
	@GetMapping("/firstCookie")
	public String firstCookie(HttpServletResponse response) {
		try {
			Cookie cookie=new Cookie("fcook", "1");
			cookie.setMaxAge(60);
			cookie.setPath("/");
			response.addCookie(cookie);
			
			return "1";
		}
		catch(Exception e) {
			return "0";
		}
	}
	
	@GetMapping("/fcookOk")
	public String fcookOk(HttpServletRequest request) {
		Cookie cookie=WebUtils.getCookie(request, "fcook");
		if(cookie==null) {
			return "0";
		}
		else {
			return "1";
		}
	}
	
}
