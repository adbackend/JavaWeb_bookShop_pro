package com.bookshop02.cart.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop02.cart.vo.CartVO;

public interface CartController {

	//카트 추가
//	public @ResponseBody String addGoodsInCart(@RequestParam("goods_id") int goods_id, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public @ResponseBody String addGoodsInCart(@ModelAttribute CartVO cart, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	//카트(장바구니) 목록
	public ModelAndView	myCartMain(HttpServletRequest request, HttpServletResponse response) throws Exception; 
	
	//장바구니 상품 삭제
	public ModelAndView removeCartGoods(@RequestParam("cart_id") int cart_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
}
