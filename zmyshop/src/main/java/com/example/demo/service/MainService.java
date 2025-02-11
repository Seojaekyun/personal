package com.example.demo.service;

import java.util.List;

import org.springframework.ui.Model;

import com.example.demo.dto.DaeDto;
import com.example.demo.dto.JungDto;
import com.example.demo.dto.SoDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public interface MainService {

	List<DaeDto> getDae();
	List<JungDto> getJung(HttpServletRequest request);
	List<SoDto> getSo(HttpServletRequest request);
	String cartNum(HttpServletRequest request, HttpSession session);
	String index(Model model);
	

}
