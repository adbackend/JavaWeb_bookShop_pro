package com.bookshop02.admin.order.dao;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.bookshop02.member.vo.MemberVO;
import com.bookshop02.order.vo.OrderVO;

public interface AdminOrderDAO {
	
	public ArrayList<OrderVO> selectNewOrderList(Map condMap) throws DataAccessException;
	
	public void updateDeliveryState(Map deliveryMap) throws DataAccessException; //배송지 수정
	
	public ArrayList<OrderVO> selectOrderDetail(int order_id) throws DataAccessException;

	public MemberVO selectOrderer(String member_id) throws DataAccessException;
}
