package com.bookshop02.order.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.bookshop02.order.vo.OrderVO;

public interface OrderDAO {
	
	//결제
	public void insertNewOrder(List<OrderVO> myOrderList) throws DataAccessException;
	
	//카트에서 주문 상품 삭제
	public void removeGoodsFromCart(List<OrderVO> myOrderList) throws DataAccessException;

}
