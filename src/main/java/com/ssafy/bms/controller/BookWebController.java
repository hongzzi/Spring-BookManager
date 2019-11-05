package com.ssafy.bms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BookWebController {
	
	@GetMapping("rest.do")
	public String restForm() {
		return "bookmanage";
	}
}
