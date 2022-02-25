package com.bookshop02.admin.order.service;

import java.util.List;
import java.util.Map;

import com.bookshop02.order.vo.OrderVO;

public interface AdminOrderService {
	
	List<OrderVO> listNewOrder(Map comdMap) throws Exception;

}
