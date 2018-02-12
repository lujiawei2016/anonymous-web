package com.anonymous.login.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anonymous.login.service.LoginService;

import net.sf.json.JSONObject;

/**
 * 登陆controller
 * @author  lujiawei
 * @version V1.0
 * @date    2018年2月12日上午10:44:10
 */
@Controller
@RequestMapping(value="/login")
public class LoginController {
	
	private static final Logger logger = Logger.getLogger(LoginController.class);
	
	@Autowired
	private LoginService loginService;

	/**
	 * 快捷登陆
	 * @param phone
	 * @param code
	 * @param deviceId
	 * @return
	 */
	@RequestMapping(value="/quickLogin/phone/{phone}/code/{code}/deviceId/{deviceId}",method=RequestMethod.GET)
	@ResponseBody
	public Object quickLogin(@PathVariable String phone,@PathVariable String code,@PathVariable String deviceId){
		try {
			Object result = JSONObject.fromObject(loginService.quickLogin(phone, code, deviceId));
			return result;
		} catch (Exception e) {
			logger.info("快捷登陆异常，异常信息为："+e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
}
