package com.bookshop02.mypage.service;

import java.util.List;
import java.util.Map;

import com.bookshop02.member.vo.MemberVO;
import com.bookshop02.order.vo.OrderVO;

public interface MyPageService {

	public List<OrderVO> listMyOrderGoods(String member_id) throws Exception; //마이페이지 메인
	public void cancelOrder(String order_id) throws Exception; //주문 취소
	public MemberVO modifyMyInfo(Map memberMap) throws Exception; //마이페이지 - 내정보 수정
	
	public List<OrderVO> listMyOrderHistory(Map dateMap) throws Exception;
	public List findMyOrderInfo(String order_id) throws Exception;
}
