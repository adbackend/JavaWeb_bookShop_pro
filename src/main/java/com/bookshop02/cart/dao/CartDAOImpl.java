package com.bookshop02.cart.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bookshop02.cart.vo.CartVO;
import com.bookshop02.goods.vo.GoodsVO;

@Repository("cartDAO")
public class CartDAOImpl implements CartDAO{

	@Autowired
	private SqlSession sqlSession;
	
	//이미 장바구니에 추가된 상품인지 조회
	@Override
	public boolean selectCountInCart(CartVO cartVO) throws DataAccessException {
		
		String result = sqlSession.selectOne("mapper.cart.selectCountInCart",cartVO);
		
		return Boolean.parseBoolean(result);
	}
	
	//장바구니에 추가
	@Override
	public void insertGoodsInCart(CartVO cartVO) throws DataAccessException {
		
		int cart_id = selectMaxCartId();
		cartVO.setCart_id(cart_id);
		
		sqlSession.insert("mapper.cart.insertGoodsInCart",cartVO);
		
	}
	
	private int selectMaxCartId() {
		
		int cart_id = sqlSession.selectOne("mapper.cart.selectMaxCartId");
		
		return cart_id;
	}
	
	//장바구니 목록
	@Override
	public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException {
		
		List<CartVO> cartList = (List)sqlSession.selectList("mapper.cart.selectCartList",cartVO);
		
		return cartList;
	}
	
	@Override
	public List<GoodsVO> selectGoodsList(List<CartVO> cartList) throws DataAccessException {

		List<GoodsVO> myGoodsList;
		myGoodsList = sqlSession.selectList("mapper.cart.selectGoodsList",cartList);
		
		return myGoodsList;
	}
	
	//장바구니 상품 삭제
	@Override
	public void deleteCart(int cart_id) throws DataAccessException {
		sqlSession.delete("mapper.cart.deleteCartGoods",cart_id);
	}
}




