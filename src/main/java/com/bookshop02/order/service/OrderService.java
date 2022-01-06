package com.bookshop02.order.service;

import java.util.List;

import com.bookshop02.order.vo.OrderVO;

public interface OrderService {
	
	//결제하기
	public void addNewOrder(List<OrderVO> myOrderList) throws Exception;
	
}
