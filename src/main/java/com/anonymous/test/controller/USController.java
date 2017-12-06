package com.anonymous.test.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.anonymous.test.pojo.User;
import com.anonymous.test.service.IUserService;

@Controller
@RequestMapping(value="/user")
public class USController {
	
	@Autowired
	private IUserService userService;

	@RequestMapping(value="/test1")
	public String test1(){
		User user = userService.getUserById(1);
		System.out.println(user);
		return "test";
	}
}
