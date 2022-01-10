package com.bookshop02.mypage.service;

import java.util.List;

import com.bookshop02.order.vo.OrderVO;

public interface MyPageService {

	public List<OrderVO> listMyOrderGoods(String member_id) throws Exception; //마이페이지 메인
	public void cancelOrder(String order_id) throws Exception; //주문 취소
}
