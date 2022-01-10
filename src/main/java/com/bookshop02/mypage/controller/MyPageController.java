package com.bookshop02.mypage.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface MyPageController {

	//마이페이지 메인
	public ModelAndView myPageMain(@RequestParam(required=false, value="message") String message, HttpServletRequest request, HttpServletResponse response)  throws Exception ;

	//주문 취소
	public ModelAndView cancelMyOrder(@RequestParam("order_id") String order_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
}
