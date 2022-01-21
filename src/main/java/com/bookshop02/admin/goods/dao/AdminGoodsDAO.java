package com.bookshop02.admin.goods.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.bookshop02.goods.vo.GoodsVO;

public interface AdminGoodsDAO {
	
	public List<GoodsVO> selectNewGoodsList(Map condMap) throws DataAccessException;

}
