package com.anonymous.anonym.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anonymous.anonym.service.AnonymService;
import com.anonymous.custom.annotation.IdentityCheck;

import net.sf.json.JSONObject;

/**
 * 用户controller
 * @author  lujiawei
 * @version V1.0
 * @date    2017年12月23日下午6:17:36
 */
@Controller
@RequestMapping(value="/anonym")
public class AnonymController {
	
	@Autowired
	private AnonymService anonymService;

	/**
	 * 获取用户信息
	 * @param anonymId
	 * @return
	 */
	@RequestMapping(value="/getAnonymInfoById/{anonymId}")
	@ResponseBody
	@IdentityCheck(check=false)
	public Object getAnonymInfoById(@PathVariable String anonymId){
		try {
			Object result = JSONObject.fromObject(anonymService.getAnonymInfoById(anonymId));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
