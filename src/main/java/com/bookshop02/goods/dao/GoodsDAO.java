package com.bookshop02.goods.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.bookshop02.goods.vo.GoodsVO;
import com.bookshop02.goods.vo.ImageFileVO;

public interface GoodsDAO {
	
	public List<GoodsVO> selectGoodsList(String goodsStatus) throws DataAccessException;

	public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException;
	
	public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException;
	
}
