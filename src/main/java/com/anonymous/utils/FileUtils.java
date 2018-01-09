package com.anonymous.utils;

import org.csource.common.NameValuePair;
import org.springframework.web.multipart.MultipartFile;

import com.anonymous.fastdfs.FastDFSFile;
import com.anonymous.fastdfs.FileManager;

/**
 * 文件工具类
 * @author  lujiawei
 * @version V1.0
 * @date    2018年1月9日上午10:02:47
 */
public class FileUtils {

	/**
	 * 文件上传
	 * @param attach
	 * @return
	 */
	public static String upload(MultipartFile attach){
		try {
			// 获取文件后缀名 
		    String ext = attach.getOriginalFilename().substring(attach.getOriginalFilename().lastIndexOf(".")+1);
		    FastDFSFile file = new FastDFSFile(attach.getBytes(),ext);
		    NameValuePair[] meta_list = new NameValuePair[4];
		    meta_list[0] = new NameValuePair("fileName", attach.getOriginalFilename());
		    meta_list[1] = new NameValuePair("fileLength", String.valueOf(attach.getSize()));
		    meta_list[2] = new NameValuePair("fileExt", ext);
		    meta_list[3] = new NameValuePair("fileAuthor", "lujiawei");
		    String filePath = FileManager.upload(file,meta_list);
		    return filePath;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
