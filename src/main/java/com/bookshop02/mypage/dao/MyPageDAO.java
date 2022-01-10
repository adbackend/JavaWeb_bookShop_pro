package com.bookshop02.mypage.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.bookshop02.order.vo.OrderVO;

public interface MyPageDAO {

	//마이페이지 메인
	public List<OrderVO> selectMyOrderGoodsList(String member_id) throws DataAccessException;
	
	//주문 취소
	public void updateMyOrderCancel(String order_id) throws DataAccessException;
}
