package com.bookshop02.admin.goods.service;

import java.util.List;
import java.util.Map;

import com.bookshop02.goods.vo.GoodsVO;

public interface AdminGoodsService {
	
	public List<GoodsVO> listNewGoods(Map condMap) throws Exception; //메인페이지

}
