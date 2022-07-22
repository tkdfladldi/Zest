package com.spring.member.controller;

import java.util.Locale;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.board.HomeController;

@Controller
public class MemberController {
	
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/member/login.do", method = RequestMethod.GET)
	public String loginGet() throws Exception{
		
		
		return "member/login";
	}
	@RequestMapping(value = "/member/register.do", method = RequestMethod.GET)
	public String registerGet() throws Exception{
		
		
		return "member/register";
	}
	
	
}
