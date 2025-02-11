package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EtcController {
    // 이것저것 연습할때 사용할 클래스
	@GetMapping("/etc/thisEx")
	public String thisEx() {
		return "/etc/thisEx";
	}
}
