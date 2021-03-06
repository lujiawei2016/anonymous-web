package com.anonymous.story.controller;

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
import com.anonymous.custom.annotation.IdentityCheck;
import com.anonymous.story.service.StoryCollectionService;
import com.anonymous.story.service.StoryCommentService;
import com.anonymous.story.service.StoryFabulousService;
import com.anonymous.story.service.StoryService;
import com.anonymous.utils.FileUtils;

import net.coobird.thumbnailator.Thumbnails;
import net.sf.json.JSONObject;

/**
 * 故事controller
 * @author  lujiawei
 * @version V1.0
 * @date    2018年2月24日上午9:34:47
 */
@Controller
@RequestMapping(value="/story")
public class StoryController {
	
	private static final Logger logger = Logger.getLogger(StoryController.class);
	
	@Autowired
	private StoryService storyService;
	
	@Autowired
	private StoryFabulousService storyFabulousService;
	
	@Autowired
	private StoryCollectionService storyCollectionService;
	
	@Autowired
	private StoryCommentService storyCommentService;
	
	/**
	 * 查找最新故事
	 * @return
	 */
	@RequestMapping(value="/searchNewStory",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck(check=false)
	public Object searchNewStory(){
		try {
			Object result = JSONObject.fromObject(storyService.searchNewStory());
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 分页查询故事
	 * @param anonymId
	 * @param offset
	 * @param length
	 * @return
	 */
	@RequestMapping(value="/pagingSearchStory/{offset}/{length}",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck(check=false)
	public Object pagingSearchStory(String anonymId,@PathVariable String offset,@PathVariable String length){
		try {
			Object result = JSONObject.fromObject(storyService.pagingSearchStory(anonymId, offset, length));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 发布故事
	 * @param anonymId
	 * @param story_title
	 * @param story_article
	 * @param story_article_summary
	 * @return
	 */
	@RequestMapping(value="/release/{anonymId}",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck
	public Object release(@PathVariable String anonymId,String story_title,String story_article,String story_article_summary){
		try {
			Object result = JSONObject.fromObject(storyService.release(anonymId, story_title, story_article, story_article_summary));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取故事
	 * @param storyId
	 * @param anonymId
	 * @return
	 */
	@RequestMapping(value="/getStory/{storyId}",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck(check=false)
	public Object getStory(@PathVariable String storyId,String anonymId){
		try {
			Object result = JSONObject.fromObject(storyService.findStoryById(storyId,anonymId));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 点赞故事
	 * @param anonymId
	 * @param storyId
	 * @return
	 */
	@RequestMapping(value="/storyFabulous",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck
	public Object storyFabulous(String anonymId,String storyId){
		try {
			Object result = JSONObject.fromObject(storyFabulousService.fabulous(anonymId, storyId));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 故事收藏
	 * @param anonymId
	 * @param storyId
	 * @return
	 */
	@RequestMapping(value="/collection",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck
	public Object collection(String anonymId,String storyId){
		try {
			Object result = JSONObject.fromObject(storyCollectionService.collection(storyId, anonymId));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 评论故事
	 * @param anonymId
	 * @param styroReplyCommentId   回复的用户
	 * @param storyId
	 * @param commentContent
	 * @return
	 */
	@RequestMapping(value="/storyComment",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck
	public Object storyComment(String anonymId,String storyReplyCommentId,String storyId,String commentContent){
		try {
			Object result = JSONObject.fromObject(storyCommentService.comment(anonymId, storyReplyCommentId, storyId, commentContent));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 查询评论
	 * @param storyId
	 * @param anonymId
	 * @param offset
	 * @param length
	 * @return
	 */
	@RequestMapping(value="/searchComment/{offset}/{length}",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck(check=false)
	public Object searchComment(String storyId,String anonymId,@PathVariable int offset,@PathVariable int length){
		try {
			Object result = JSONObject.fromObject(storyCommentService.searchComment(storyId, anonymId, offset, length));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 故事评论点赞
	 * @param storyCommentId
	 * @param anonymId
	 * @param password
	 * @return
	 */
	@RequestMapping(value="/storyCommentFabulous/{storyCommentId}",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck
	public Object storyCommentFabulous(@PathVariable String storyCommentId,String anonymId,String password){
		try {
			Object result = JSONObject.fromObject(storyCommentService.storyCommentFabulous(storyCommentId, anonymId));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 故事图片上传
	 * @param file
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/uploadImg",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck(check=false)
	public Object uploadImg(@RequestParam MultipartFile file,HttpServletRequest request,HttpServletResponse response){
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
	                Map<String, Object> result = new HashMap<>();
	                result.put("imgPath", imgPath);
	                
	    			logger.info("故事图片上传成功");
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
			e.printStackTrace();
		}
		
		return null;
	}
	
}
