package com.bookshop02.cart.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bookshop02.cart.dao.CartDAO;
import com.bookshop02.cart.vo.CartVO;
import com.bookshop02.goods.vo.GoodsVO;

@Service("cartService")
@Transactional(propagation=Propagation.REQUIRED)
public class CartServiceImpl implements CartService{

	@Autowired
	private CartDAO cartDAO;
	
	@Autowired
	private CartVO cartVO;
	
	//테이블에 추가하기 전에 동일한 상품 번호의 개수를 조회
	@Override
	public boolean findCartGoods(CartVO cartVO) throws Exception {
		
		return cartDAO.selectCountInCart(cartVO);
	}
	
	//장바구니에 추가
	@Override
	public void addGoodsInCart(CartVO cartVO) throws Exception {
		cartDAO.insertGoodsInCart(cartVO);
	}
	
	//장바구니 목록
	@Override
	public Map<String, List> myCartList(CartVO cartVO) throws Exception {
		
		Map<String,List> cartMap = new HashMap<String, List>();
		List<CartVO> myCartList = cartDAO.selectCartList(cartVO);
		
		if(myCartList.size()==0) { //카트에 저장된 상품이 없는 경우
			return null;
		}
		
		List<GoodsVO> myGoodsList = cartDAO.selectGoodsList(myCartList);
		cartMap.put("myCartList", myCartList);
		cartMap.put("myGoodsList", myGoodsList);
		
		return cartMap;
	}
	
	//장바구니 상품 삭제
	@Override
	public void removeCartGoods(int cart_id) throws Exception {
		
		cartDAO.deleteCart(cart_id);
	}
	
	
}
