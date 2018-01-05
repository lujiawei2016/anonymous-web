package com.anonymous.utils;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Iterator;
import java.util.Properties;

/**
 * properties工具类
 * @author  lujiawei
 * @version V1.0
 * @date    2018年1月5日上午11:40:14
 */
public class PropertiesUtils {

	/**
	 * 获取properties的值
	 * @param key
	 * @return
	 */
	public static String getValue(String key,String proPath){
		try {
			Properties prop = new Properties();
			InputStream in = PropertiesUtils.class.getResourceAsStream(proPath);
			prop.load(in);     ///加载属性列表
			String value = prop.getProperty(key);
			return value;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static void main(String[] args) throws Exception {
		String value = PropertiesUtils.getValue("login", "/redis-key.properties");
		System.out.println(value);
	}
}
