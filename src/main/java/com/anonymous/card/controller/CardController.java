package com.anonymous.card.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.anonymous.card.service.CardService;
import com.anonymous.utils.FileUtils;

import net.sf.json.JSONObject;

/**
 * 卡片controller
 * @author  lujiawei
 * @version V1.0
 * @date    2017年12月23日下午6:17:36
 */
@Controller
@RequestMapping(value="/card")
public class CardController {
	
	private static Logger logger = Logger.getLogger(CardController.class);
	
	@Autowired
	private CardService cardService;

	/**
	 * 发布卡片
	 * @param anonymId
	 * @param cardContent
	 * @param file
	 * @return
	 */
	@RequestMapping(value="/release",method=RequestMethod.POST)
	@ResponseBody
	public Object release(String anonymId,String cardContent,@RequestParam MultipartFile file){
		try {
			String imgPath = FileUtils.upload(file);
			Object result = JSONObject.fromObject(cardService.release(anonymId, cardContent, imgPath));
			return result;
		} catch (Exception e) {
			logger.error("发布卡片异常，异常信息为："+e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 查出主页最新卡片信息
	 * @param anonymId
	 * @return
	 */
	@RequestMapping(value="/searchNewCard/anonymId/{anonymId}",method=RequestMethod.POST)
	public Object searchNewCard(@PathVariable String anonymId){
		return null;
	}
}
