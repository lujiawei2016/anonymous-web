package com.anonymous.test.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anonymous.test.pojo.Article;
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
	
	@RequestMapping(value="/test2")
	@ResponseBody
	public User test2(){
		User user = userService.getUserAndArticleByUserId(1);
		List<Article> articleList = user.getArticleList();
		for(Article article:articleList){
			System.out.println(article.getArticleId());
		}
		return user;
	}
	
	@RequestMapping(value="/test3")
	@ResponseBody
	public Article test3(){
		Article article = userService.getArticleById(1);
		System.out.println(article);
		return article;
	}
}
