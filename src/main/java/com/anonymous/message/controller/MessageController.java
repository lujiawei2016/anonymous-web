package com.anonymous.message.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anonymous.message.service.MessageService;

/**
 * 
 * @author  lujiawei
 * @version V1.0
 * @date    2018年1月5日上午11:12:09
 */
@Controller
@RequestMapping(value="/message")
public class MessageController {
	
	@Autowired
	private MessageService messageService;

	/**
	 * 发送登陆短信验证码
	 * @param phone
	 * @return
	 */
	@RequestMapping(value="/sendLoginMsg")
	@ResponseBody
	public Object sendLoginMsg(String phone){
		try {
			Object result = messageService.sendLoginMsg(phone);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
