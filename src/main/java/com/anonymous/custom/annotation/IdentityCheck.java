package com.anonymous.custom.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 自定义
 * @author  lujiawei
 * @version V1.0
 * @date    2018年2月12日下午3:46:38
 */
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface IdentityCheck {

	/**
	 * 默认为true
	 * @return
	 */
	boolean check() default true;
}
