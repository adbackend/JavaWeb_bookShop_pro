package com.bookshop02.cart.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.bookshop02.cart.vo.CartVO;
import com.bookshop02.goods.vo.GoodsVO;

public interface CartDAO {
	
	//장바구니에 상품이 이미 존재 하는지
	public boolean selectCountInCart(CartVO cartVO) throws DataAccessException;
	
	//장바구니 추가
	public void insertGoodsInCart(CartVO cartVO) throws DataAccessException;
	
	//장바구니 목록
	public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException;
	
	public List<GoodsVO> selectGoodsList(List<CartVO> cartList) throws DataAccessException;
	
	//장바구니 상품 삭제
	public void deleteCart(int cart_id) throws DataAccessException;
}
