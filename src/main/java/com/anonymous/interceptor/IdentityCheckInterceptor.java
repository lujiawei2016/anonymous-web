package com.anonymous.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.anonymous.anonym.service.AnonymService;
import com.anonymous.custom.annotation.IdentityCheck;

public class IdentityCheckInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	private AnonymService anonymService;

	/**
	 * 进行账号密码校验
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HandlerMethod handlerMethod = (HandlerMethod) handler;
		IdentityCheck auth = handlerMethod.getMethodAnnotation(IdentityCheck.class);
		
		//进行验证
		if(auth.check()){
			String anonymId = request.getParameter("anonymId");
			String password = request.getParameter("password");
			
			boolean b = anonymService.judgeAnonym(anonymId, password);
			if(b){
				//校验通过
				return true;
			}else{
				//校验不通过
				return false;
			}
		}
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}

}
