package com.bookshop02.admin.order.dao;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.bookshop02.order.vo.OrderVO;

public interface AdminOrderDAO {
	
	public ArrayList<OrderVO> selectNewOrderList(Map condMap) throws DataAccessException;

}
