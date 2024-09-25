package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.mapper.EtcMapper;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class EtcController {
 
	@Autowired
	private EtcMapper mapper;
	
	@RequestMapping("/etc/busList")
	public String busList(HttpServletRequest request,Model model)
	{
		model.addAttribute("bdto", mapper.getBus("20240906001"));
		
		return "/etc/busList";
	}
	
}
