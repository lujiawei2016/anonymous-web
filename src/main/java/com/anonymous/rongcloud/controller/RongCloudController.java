package com.anonymous.rongcloud.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anonymous.custom.annotation.IdentityCheck;
import com.anonymous.rongcloud.service.RongCloudService;

import net.sf.json.JSONObject;

/**
 * 融云controller
 * @author  lujiawei
 * @version V1.0
 * @date    2018年3月8日上午9:49:59
 */
@Controller
@RequestMapping(value="/rongCloud")
public class RongCloudController {
	
	@Autowired
	private RongCloudService rongCloudService;

	/**
	 * 获取token
	 * @param anonymId
	 * @return
	 */
	@RequestMapping(value="/getToken",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck
	public Object getToken(String anonymId){
		try {
			Object result = JSONObject.fromObject(rongCloudService.getToken(anonymId));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
