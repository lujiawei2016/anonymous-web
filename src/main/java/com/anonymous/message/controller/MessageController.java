package com.anonymous.message.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anonymous.message.service.MessageService;

import net.sf.json.JSONObject;

/**
 * 
 * @author  lujiawei
 * @version V1.0
 * @date    2018年1月5日上午11:12:09
 */
@Controller
@RequestMapping(value="/message")
public class MessageController {
	
	private static final Logger logger = Logger.getLogger(MessageController.class);
	
	@Autowired
	private MessageService messageService;

	/**
	 * 发送登陆短信验证码
	 * @param phone
	 * @return
	 */
	@RequestMapping(value="/sendLoginMsg/phone/{phone}",method=RequestMethod.GET)
	@ResponseBody
	public Object sendLoginMsg(@PathVariable String phone){
		try {
			Object result = JSONObject.fromObject(messageService.sendLoginMsg(phone));
			return result;
		} catch (Exception e) {
			logger.error("发送登录短信异常，异常信息为："+e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 快捷登陆
	 * @param phone
	 * @param code
	 * @param deviceId
	 * @return
	 */
	@RequestMapping(value="/quickLogin/phone/{phone}/code/{code}/deviceId/{deviceId}")
	public Object quickLogin(@PathVariable String phone,@PathVariable String code,@PathVariable String deviceId){
		try {
			Object result = JSONObject.fromObject(messageService.quickLogin(phone, code, deviceId));
			return result;
		} catch (Exception e) {
			logger.info("快捷登陆异常，异常信息为："+e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
}
