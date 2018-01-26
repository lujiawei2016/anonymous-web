package com.anonymous.card.comment.service;

/**
 * 卡片评论接口
 * @author  lujiawei
 * @version V1.0
 * @date    2018年1月26日上午11:14:55
 */
public interface CardCommentService {

	/**
	 * 获取卡片评论内容
	 * @param anonymId
	 * @param cardId
	 * @return
	 * @throws Exception
	 */
	public Object getCardComment(String anonymId,String cardId) throws Exception;
}
