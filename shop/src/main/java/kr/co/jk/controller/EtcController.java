package kr.co.jk.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import jakarta.servlet.http.HttpServletRequest;
import kr.co.jk.mapper.EtcMapper;

@Controller
public class EtcController {

	@Autowired
	private EtcMapper mapper;

	@GetMapping("/etc/busList")
	public String busList(HttpServletRequest request, Model model) {
		model.addAttribute("bdto", mapper.getBus("20240906001"));

		return "/etc/busList";
	}

}
