package com.anonymous.card.controller;

import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.dubbo.common.utils.StringUtils;
import com.anonymous.card.service.CardCollectionService;
import com.anonymous.card.service.CardCommentFabulousService;
import com.anonymous.card.service.CardCommentService;
import com.anonymous.card.service.CardFabulousService;
import com.anonymous.card.service.CardService;
import com.anonymous.custom.annotation.IdentityCheck;
import com.anonymous.utils.FileUtils;

import net.coobird.thumbnailator.Thumbnails;
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
	
	@Autowired
	private CardCommentService cardCommentService;
	
	@Autowired
	private CardCommentFabulousService cardCommentFabulousService;
	
	@Autowired
	private CardFabulousService cardFabulousService;
	
	@Autowired
	private CardCollectionService cardCollectionService;
	
	/**
	 * 获取卡片评论
	 * @param anonymId
	 * @param cardId
	 * @return
	 */
	@RequestMapping(value="/getCardComment/{offset}/{length}")
	@ResponseBody
	@IdentityCheck(check=false)
	public Object getCardComment(String anonymId, String cardId,@PathVariable String offset,@PathVariable String length){
		try {
			Object result = JSONObject.fromObject(cardCommentService.getCardComment(anonymId, cardId,offset,length));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 保存评论
	 * @param anonymId
	 * @param cardId
	 * @param cardCommentContent
	 * @param carCommentReplyId
	 * @return
	 */
	@RequestMapping(value="/saveCardComment",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck
	public Object saveCardComment(String anonymId,String cardId,
			String cardCommentContent,String carCommentReplyId){
		try {
			Object result = JSONObject.fromObject(cardCommentService.saveCardComment(anonymId, cardId, cardCommentContent, carCommentReplyId));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 发布卡片
	 * @param anonymId
	 * @param cardContent
	 * @param file
	 * @return
	 */
	@RequestMapping(value="/release",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck
	public Object release(String anonymId,String cardContent,@RequestParam MultipartFile file,HttpServletRequest request,HttpServletResponse response){
		try {
			
			response.setCharacterEncoding("utf-8");
	        request.setCharacterEncoding("utf-8");
	        
	        String picName = null;//最终名字
	        
	        String realPath = request.getSession().getServletContext().getRealPath(""+File.separator+"uploadImage");
	        if(!(file.isEmpty())){
	        	
	        	String ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")+1);
	        	if(!StringUtils.isBlank(ext) && ("jpg".equals(ext)) || "jpeg".equals(ext) || "png".equals(ext) || "bmp".equals(ext)){
	        		//获取图片属性并保存
	                picName = UUID.randomUUID().toString();
	                
	                File targetFile = new File(realPath,picName+"."+ext);
	                file.transferTo(targetFile);
	                
	                if("png".equals(ext)){
	                	Thumbnails.of(realPath+File.separator+picName+"."+ext).outputFormat("jpg").scale(1f).outputQuality(0.25f).toFile(realPath+File.separator+picName+"_fuben.jpg");
	                }else{
	                	Thumbnails.of(realPath+File.separator+picName+"."+ext).scale(1f).outputQuality(0.25f).toFile(realPath+File.separator+picName+"_fuben.jpg");
	                }
	                
	                File fastdfsFile = new File(realPath,picName+"_fuben.jpg");
	                
	                FileInputStream inputStream = new FileInputStream(fastdfsFile);
	                MultipartFile multipartFile = new MockMultipartFile(picName+"_fuben.jpg", inputStream);
	                
	                String imgPath = FileUtils.upload(multipartFile);
	    			Object result = JSONObject.fromObject(cardService.release(anonymId, cardContent, imgPath));
	    			
	    			logger.info("文件上传成功");
	                
	    			return result;
	        	}else{
	        		Map<String, Object> resultMap = new HashMap<>();
	        		resultMap.put("result", "00");
	        		resultMap.put("msg", "图片格式错误");
	        		Object result = JSONObject.fromObject(resultMap);
	        		return result;
	        	}
                
            }
			
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
	@ResponseBody
	@IdentityCheck(check=false)
	public Object searchNewCard(@PathVariable String anonymId){
		try {
			Object result = JSONObject.fromObject(cardService.searchNewCard(anonymId));
			return result;
		} catch (Exception e) {
			logger.error("查出主页最新卡片信息异常");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 查出主页卡片
	 * @param anonymId
	 * @param offset
	 * @param length
	 * @return
	 */
	@RequestMapping(value="/mainCard/{offset}/{length}")
	@ResponseBody
	@IdentityCheck(check=false)
	public Object mainCard(String anonymId,@PathVariable String offset,@PathVariable String length){
		try {
			Object result = JSONObject.fromObject(cardService.pagingSearchCard(anonymId, offset, length));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 评论点赞
	 * @param anonymId
	 * @param cardCommentId
	 * @return
	 */
	@RequestMapping(value="/commentFabulous/{anonymId}/{cardCommentId}")
	@ResponseBody
	@IdentityCheck
	public Object commentFabulous(@PathVariable String anonymId,@PathVariable String cardCommentId){
		try {
			Object result = JSONObject.fromObject(cardCommentFabulousService.fabulous(anonymId, cardCommentId));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 点赞卡片
	 * @param anonymId
	 * @param cardId
	 * @return
	 */
	@RequestMapping(value="/cardFabulous/{anonymId}/{cardId}")
	@ResponseBody
	@IdentityCheck
	public Object cardFabulous(@PathVariable String anonymId,@PathVariable String cardId){
		try {
			Object result = JSONObject.fromObject(cardFabulousService.fabulous(anonymId, cardId));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 收藏卡片
	 * @param anonymId
	 * @param cardId
	 * @return
	 */
	@RequestMapping(value="/cardCollection/{anonymId}/{cardId}")
	@ResponseBody
	@IdentityCheck
	public Object cardCollection(@PathVariable String anonymId,@PathVariable String cardId){
		try {
			Object result = JSONObject.fromObject(cardCollectionService.collection(anonymId, cardId));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
