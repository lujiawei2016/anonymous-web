package com.anonymous.card.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 卡片controller
 * @author  lujiawei
 * @version V1.0
 * @date    2017年12月23日下午6:17:36
 */
@Controller
@RequestMapping(value="/card")
public class CardController {

	/**
	 * 发布
	 * @param content
	 * @return
	 */
	@RequestMapping(value="/release")
	@ResponseBody
	public Object release(String cardContent){
		System.out.println(cardContent);
		Map<String, Object> map = new HashMap<>();
		map.put("name", "lujiawei");
		return map;
	}
}
