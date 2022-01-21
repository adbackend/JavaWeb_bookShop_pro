package com.bookshop02.mypage.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface MyPageController {

	//마이페이지 메인
	public ModelAndView myPageMain(@RequestParam(required=false, value="message") String message, HttpServletRequest request, HttpServletResponse response)  throws Exception ;

	//주문 취소
	public ModelAndView cancelMyOrder(@RequestParam("order_id") String order_id, HttpServletRequest request, HttpServletResponse response) throws Exception;

	//마이페이지 내정보
	public ModelAndView myDetailInfo(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//마이페이지 - 정보 수정하기
	public ResponseEntity modifyMyInfo(@RequestParam("attribute") String attribute, @RequestParam("value") String value, HttpServletRequest request, HttpServletResponse reponse) throws Exception;

	// 주문내역,배송조회
	public ModelAndView listMyOrderHistory(@RequestParam Map<String, String> dateMap, HttpServletRequest request, HttpServletResponse reponse) throws Exception;

	public ModelAndView myOrderDetail(@RequestParam("order_id") String order_id, HttpServletRequest request, HttpServletResponse reponse) throws Exception;
}
