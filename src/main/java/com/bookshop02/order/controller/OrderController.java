package com.bookshop02.order.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop02.order.vo.OrderVO;

public interface OrderController {

	//상품 상세 페이지(바로주문)에서 주문
	public ModelAndView orderEachGoods(@ModelAttribute("orderVO") OrderVO _orderVO,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	
	//최종결제
	public ModelAndView payToOrderGoods(@RequestParam Map<String, String> orderMap ,HttpServletRequest request, HttpServletResponse response)  throws Exception;

}
