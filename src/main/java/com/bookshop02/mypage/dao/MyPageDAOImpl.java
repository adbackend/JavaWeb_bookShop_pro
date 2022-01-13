package com.bookshop02.mypage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bookshop02.member.vo.MemberVO;
import com.bookshop02.order.vo.OrderVO;

@Repository("myPageDAO")
public class MyPageDAOImpl implements MyPageDAO{

	@Autowired
	private SqlSession sqlSession;
	
	//마이페이지 메인
	@Override
	public List<OrderVO> selectMyOrderGoodsList(String member_id) throws DataAccessException {
		
		List<OrderVO> orderGoodsList = (List)sqlSession.selectList("mapper.mypage.selectMyOrderGoodsList",member_id);
		System.out.println(orderGoodsList.size()+"사이즈");
		return orderGoodsList;
	}
	
	//주문취소
	@Override
	public void updateMyOrderCancel(String order_id) throws DataAccessException {
		sqlSession.update("mapper.mypage.updateMyOrderCancel",order_id);
	}
	
	//마이페이지 - 내정보 수정
	@Override
	public void updateMyInfo(Map memberMap) throws DataAccessException {
		sqlSession.update("mapper.mypage.updateMyInfo", memberMap);
	}
	
	//마이페이지 - 상세 정보
	@Override
	public MemberVO selectMyDetailInfo(String member_id) throws DataAccessException {
		
		MemberVO memberVO = (MemberVO)sqlSession.selectOne("mapper.mypage.selectMyDetailInfo",member_id);
		
		return memberVO;
	}

	
	
	
	
}
