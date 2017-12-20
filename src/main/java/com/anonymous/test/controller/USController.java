package com.anonymous.test.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.csource.common.MyException;
import org.csource.common.NameValuePair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.anonymous.fastdfs.FastDFSFile;
import com.anonymous.fastdfs.FileManager;
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
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public String add(@RequestParam MultipartFile attach, HttpServletRequest request)
	        throws IOException, MyException {
	    // 获取文件后缀名 
	    String ext = attach.getOriginalFilename().substring(attach.getOriginalFilename().lastIndexOf(".")+1);
	    FastDFSFile file = new FastDFSFile(attach.getBytes(),ext);
	    NameValuePair[] meta_list = new NameValuePair[4];
	    meta_list[0] = new NameValuePair("fileName", attach.getOriginalFilename());
	    meta_list[1] = new NameValuePair("fileLength", String.valueOf(attach.getSize()));
	    meta_list[2] = new NameValuePair("fileExt", ext);
	    meta_list[3] = new NameValuePair("fileAuthor", "lujiawei");
	    String filePath = FileManager.upload(file,meta_list);
	    System.out.println(filePath);
	    return filePath;
	}
}
