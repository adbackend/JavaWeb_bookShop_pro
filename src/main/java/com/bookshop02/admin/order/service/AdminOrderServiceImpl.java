package com.bookshop02.admin.order.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bookshop02.admin.order.dao.AdminOrderDAO;
import com.bookshop02.order.vo.OrderVO;

@Service("adminOrderService")
@Transactional(propagation=Propagation.REQUIRED)
public class AdminOrderServiceImpl implements AdminOrderService{
	
	@Autowired
	private AdminOrderDAO adminOrderDAO;
	
	@Override
	public List<OrderVO> listNewOrder(Map condMap) throws Exception {
		return adminOrderDAO.selectNewOrderList(condMap);
	}

}
