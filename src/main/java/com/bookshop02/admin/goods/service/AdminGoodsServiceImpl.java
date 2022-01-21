package com.bookshop02.admin.goods.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bookshop02.admin.goods.dao.AdminGoodsDAO;
import com.bookshop02.goods.vo.GoodsVO;

@Service("adminGoodsService")
@Transactional(propagation = Propagation.REQUIRED)
public class AdminGoodsServiceImpl implements AdminGoodsService{
	
	@Autowired
	private AdminGoodsDAO adminGoodsDAO;
	
	@Override
	public List<GoodsVO> listNewGoods(Map condMap) throws Exception {

		return adminGoodsDAO.selectNewGoodsList(condMap);
	}

}
