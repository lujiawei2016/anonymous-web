package com.anonymous.interceptor;

import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.dubbo.common.utils.StringUtils;
import com.anonymous.utils.RedisUtils;

/**
 * 
 * @author  lujiawei
 * @version V1.0
 * @date    2018年1月10日上午10:02:10
 */
public class RepeatSubmit implements HandlerInterceptor {
	
	private static final Logger logger = Logger.getLogger(RepeatSubmit.class);
	
	@Autowired
	private RedisUtils redisUtils;
	
	/**
	 * 执行之前判断表单是否重复提交
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String token = request.getParameter("token");
		if(!StringUtils.isBlank(token)){
			String tokenValue = redisUtils.get(token);
			if(StringUtils.isBlank(tokenValue)){
				//redis中token值为空，非表单重复提交
				redisUtils.put(token, token, 1, TimeUnit.HOURS);
				redisUtils.exec();
				return true;
			}else{
				//表单重复提交
				logger.info("表单重复提交");
				return false;
			}
		}else{
			//token为空
			logger.info("请求token为空，不通过");
			return false;
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	/**
	 * 完成之后将redis中的值删除
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		String token = request.getParameter("token");
		if(!StringUtils.isBlank(token)){
			redisUtils.deleteKey(token);
			redisUtils.exec();
		}
	}
}
