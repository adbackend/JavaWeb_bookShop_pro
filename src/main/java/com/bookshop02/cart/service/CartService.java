package com.bookshop02.cart.service;

import java.util.List;
import java.util.Map;

import com.bookshop02.cart.vo.CartVO;

public interface CartService {
	
	public boolean findCartGoods(CartVO cartVO) throws Exception; //장바구니에 이미 상품이 존재하는지 검사
	
	public void addGoodsInCart(CartVO cartVO) throws Exception; //장바구니에 상품을 추가
	
	public Map<String, List> myCartList(CartVO cartVO) throws Exception; //장바구니 목록
	

}
