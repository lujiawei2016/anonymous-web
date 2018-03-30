package com.anonymous.anonym.controller;

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
import com.anonymous.anonym.service.AnonymService;
import com.anonymous.custom.annotation.IdentityCheck;
import com.anonymous.utils.FileUtils;

import net.coobird.thumbnailator.Thumbnails;
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
	
	private static final Logger logger = Logger.getLogger(AnonymController.class);
	
	@Autowired
	private AnonymService anonymService;

	/**
	 * 获取用户信息
	 * @param anonymId
	 * @return
	 */
	@RequestMapping(value="/getAnonymInfoById/{anonymId}",method=RequestMethod.POST)
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
	
	/**
	 * 获取个人信息
	 * @param anonymId
	 * @return
	 */
	@RequestMapping(value="/getMeInfo",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck
	public Object getMeInfo(String anonymId){
		try {
			Object result = JSONObject.fromObject(anonymService.getAnonymInfoById(anonymId));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 更新用户
	 * @param anonymId
	 * @param nickName
	 * @param personalSignature
	 * @param sex
	 * @return
	 */
	@RequestMapping(value="/updateMe",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck
	public Object updateMe(String anonymId,String nickName,String personalSignature,String sex){
		try {
			Object result = JSONObject.fromObject(anonymService.updateMe(anonymId, nickName, personalSignature, sex));
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 上传头像并保存
	 * @param file
	 * @param anonymId
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/saveHeadImg",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck
	public Object saveHeadImg(@RequestParam MultipartFile file,String anonymId,
			HttpServletRequest request,HttpServletResponse response){
		try {
			
			String imgPath = uploadImg(request, response, file);
			if(imgPath != null){
				//保存头像
				Object result = JSONObject.fromObject(anonymService.saveHeadImg(imgPath, anonymId));
				
				logger.info("头像上传成功");
				
				return result;
			}
			
		} catch (Exception e) {
			logger.error("保存头像异常："+e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 上传个人背景并保存
	 * @param file
	 * @param anonymId
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/saveBackgroundImg",method=RequestMethod.POST)
	@ResponseBody
	@IdentityCheck
	public Object saveBackgroundImg(@RequestParam MultipartFile file,String anonymId,
			HttpServletRequest request,HttpServletResponse response){
		try {
			
			String headerImg = uploadImg(request, response, file);
			if(headerImg != null){
				//保存头像
				Object result = JSONObject.fromObject(anonymService.saveBackgroundImg(headerImg, anonymId));
				
				logger.info("背景图片上传成功");
				
				return result;
			}
			
		} catch (Exception e) {
			logger.error("保存头像异常："+e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 图片上传
	 * @param request
	 * @param response
	 * @param file
	 * @return
	 * @throws Exception
	 */
	public String uploadImg(HttpServletRequest request,HttpServletResponse response,MultipartFile file) throws Exception{
		
		String imgPath = "";
		
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
                
                imgPath = FileUtils.upload(multipartFile);
                
    			logger.info("文件上传成功");
                
        	}else{
        		Map<String, Object> resultMap = new HashMap<>();
        		resultMap.put("result", "00");
        		resultMap.put("msg", "图片格式错误");
        		return null;
        	}
        }
        return imgPath;
	}
}
