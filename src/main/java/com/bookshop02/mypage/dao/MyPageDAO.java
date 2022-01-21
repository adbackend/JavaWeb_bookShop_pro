package com.bookshop02.mypage.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.bookshop02.member.vo.MemberVO;
import com.bookshop02.order.vo.OrderVO;

public interface MyPageDAO {

	//마이페이지 메인
	public List<OrderVO> selectMyOrderGoodsList(String member_id) throws DataAccessException;
	
	//주문 취소
	public void updateMyOrderCancel(String order_id) throws DataAccessException;
	
	//마이페이지 - 내정보 수정
	public void updateMyInfo(Map memberMap) throws DataAccessException;
	
	public MemberVO selectMyDetailInfo(String member_id) throws DataAccessException;
	
	public List<OrderVO> selectMyOrderHistoryList(Map dateMap) throws DataAccessException;
	
	public List selectMyOrderInfo(String order_id) throws DataAccessException;
}
