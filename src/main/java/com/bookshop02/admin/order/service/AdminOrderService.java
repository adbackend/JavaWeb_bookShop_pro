package com.bookshop02.admin.order.service;

import java.util.List;
import java.util.Map;

import com.bookshop02.order.vo.OrderVO;

public interface AdminOrderService {
	
	List<OrderVO> listNewOrder(Map comdMap) throws Exception;
	
	//배송지 수정
	public void modifyDeliveryState(Map deliveryMap) throws Exception;
	
	//주문 상세
	public Map orderDetail(int order_id) throws Exception;

}
