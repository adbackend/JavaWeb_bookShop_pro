package com.bookshop02.order.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bookshop02.order.vo.OrderVO;

@Repository("orderDAO")
public class OrderDAOImpl implements OrderDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertNewOrder(List<OrderVO> myOrderList) throws DataAccessException {
		
		int order_id = selectOrderID();
		
		System.out.println("결제 DAO, 주문번호(order_id): "+order_id);
		
		for(int i=0; i<myOrderList.size(); i++) {
			OrderVO orderVO = (OrderVO)myOrderList.get(i);
			orderVO.setOrder_id(order_id);
			
			sqlSession.insert("mapper.order.insertNewOrder",orderVO);
		}
		
	}
	
	private int selectOrderID() throws DataAccessException{
		
		return sqlSession.selectOne("mapper.order.selectOrderID");
	}
	
	public void removeGoodsFromCart(List<OrderVO> myOrderList) throws DataAccessException{
			
		for(int i=0; i<myOrderList.size(); i++) {
			OrderVO orderVO = (OrderVO)myOrderList.get(i);
			sqlSession.delete("mapper.order.deleteGoodsFromCart",orderVO);
		}
	}

}




