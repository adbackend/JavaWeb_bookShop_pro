package com.bookshop02.admin.order.controller;

import java.util.Map;

import javax.management.ConstructorParameters;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface AdminOrderController {
	
	//메인페이지
	public ModelAndView adminOrderMain(@RequestParam Map<String, String> dateMap,
									   HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//배송지 수정
	public ResponseEntity modifyDeliveryState(@RequestParam Map<String,String> deliveryMap,
										HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//주문 상세페이지
	public ModelAndView orderDetail(@RequestParam("order_id") int order_id,
									HttpServletRequest request, HttpServletResponse response ) throws Exception;

}
