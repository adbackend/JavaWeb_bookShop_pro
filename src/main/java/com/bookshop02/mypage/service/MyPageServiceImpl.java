package com.bookshop02.mypage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bookshop02.member.vo.MemberVO;
import com.bookshop02.mypage.dao.MyPageDAO;
import com.bookshop02.order.vo.OrderVO;

@Service("myPageService")
@Transactional(propagation=Propagation.REQUIRED)
public class MyPageServiceImpl implements MyPageService{
	
	@Autowired
	private MyPageDAO myPageDAO;
	
	//마이페이지 메인
	public List<OrderVO> listMyOrderGoods(String member_id) throws Exception{
		return myPageDAO.selectMyOrderGoodsList(member_id);
	}
	
	//주문 취소
	@Override
	public void cancelOrder(String order_id) throws Exception {
		myPageDAO.updateMyOrderCancel(order_id);
	}
	
	//마이페이지 - 내정보 수정
	@Override
	public MemberVO modifyMyInfo(Map memberMap) throws Exception {
		
		String member_id = (String)memberMap.get("member_id");
		myPageDAO.updateMyInfo(memberMap);
		return myPageDAO.selectMyDetailInfo(member_id);
	}
	

	@Override
	public List<OrderVO> listMyOrderHistory(Map dateMap) throws Exception {
		
		return myPageDAO.selectMyOrderHistoryList(dateMap);
	}
	
	@Override
	public List findMyOrderInfo(String order_id) throws Exception {

		return myPageDAO.selectMyOrderInfo(order_id);
	}
	
			
}
