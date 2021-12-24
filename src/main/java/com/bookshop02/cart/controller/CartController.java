package com.bookshop02.cart.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

public interface CartController {

	//카트 추가
	public @ResponseBody String addGoodsInCart(@RequestParam("goods_id") int goods_id, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	//카트(장바구니) 목록
	public ModelAndView	myCartMain(HttpServletRequest request, HttpServletResponse response) throws Exception; 
	
	
}
