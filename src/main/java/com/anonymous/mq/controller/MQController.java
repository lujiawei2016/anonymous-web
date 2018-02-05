package com.anonymous.mq.controller;

import java.util.HashMap;
import java.util.Map;

import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.TextMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anonymous.activemq.ConsumerService;
import com.anonymous.activemq.ProducerService;
import com.anonymous.test.pojo.User;

@Controller
@RequestMapping(value="/mq")
public class MQController {
	
	@Autowired
	private Destination destination;
	
	@Autowired
	private ProducerService producerService;
	
	@Autowired
	private ConsumerService consumerService;

	@RequestMapping(value="/send1")
	@ResponseBody
	public String send1(String msg){
		String desName = "lujiawei666";
		producerService.sendMessage(desName, msg);
		return "123";
	}
	
	@RequestMapping(value="/send2")
	@ResponseBody
	public String send2(){
		String desName = "lujiawei666";
		User user = new User();
		user.setUserId(123);
		user.setUserAge(18);
		user.setUserName("卢嘉威");
		HashMap<String, Object> hp = new HashMap<>();
		hp.put("msg", user);
		producerService.sendMessage(desName, hp);
		return "123";
	}
	
	@RequestMapping(value="/send3")
	@ResponseBody
	public String send3(String msg){
		producerService.sendMessage(msg);
		return "123";
	}
	
	@RequestMapping(value="/send4")
	@ResponseBody
	public String send4(String msg){
		String desName = "lujiawei123";
		producerService.sendMessage(desName, msg);
		return "123";
	}
	
	@RequestMapping(value="/receive")
	@ResponseBody
	public String receive(){
		consumerService.receive(destination);
		return "123";
	}
}
