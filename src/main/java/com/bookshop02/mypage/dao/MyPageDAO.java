package com.bookshop02.mypage.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.bookshop02.order.vo.OrderVO;

public interface MyPageDAO {

	public List<OrderVO> selectMyOrderGoodsList(String member_id) throws DataAccessException;
}
