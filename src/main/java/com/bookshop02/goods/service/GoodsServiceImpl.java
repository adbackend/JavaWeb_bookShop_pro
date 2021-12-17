package com.bookshop02.goods.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bookshop02.goods.dao.GoodsDAO;
import com.bookshop02.goods.vo.GoodsVO;
import com.bookshop02.goods.vo.ImageFileVO;

@Service("goodsService")
@Transactional(propagation=Propagation.REQUIRED)
public class GoodsServiceImpl implements GoodsService{

	@Autowired
	private GoodsDAO goodsDAO;
	
	@Override
	public Map<String, List<GoodsVO>> listGoods() throws Exception {
		
		Map<String, List<GoodsVO>> goodsMap = new HashMap<String, List<GoodsVO>>();
		
		List<GoodsVO> goodsList = goodsDAO.selectGoodsList("bestseller");
		goodsMap.put("bestseller", goodsList);

		System.out.println("사이즈"+goodsList.size());
		
		goodsList = goodsDAO.selectGoodsList("newbook");
		goodsMap.put("newbook", goodsList);
		
		goodsList = goodsDAO.selectGoodsList("steadyseller");
		goodsMap.put("steadyseller", goodsList);
		
		return goodsMap;
	}
	
	@Override
	public Map goodsDetail(String _goods_id) throws Exception {
		
		Map goodsMap = new HashMap();
		
		GoodsVO goodsVO = goodsDAO.selectGoodsDetail(_goods_id);
		goodsMap.put("goodsVO", goodsVO);  //(String, goodsVO)
		
		List<ImageFileVO> imageList = goodsDAO.selectGoodsDetailImage(_goods_id);
		goodsMap.put("imageList", imageList); // (String, List<ImageFileVO>)
		
		return goodsMap;
	}
	
	//자동완성검색
	@Override
	public List<String> keywordSearch(String keyword) throws Exception{
		
		List<String> list = goodsDAO.selectKeywordSearch(keyword);
		
		return list;
	}
	
	@Override
	public List<GoodsVO> searchGoods(String searchWord) throws Exception {
		List<GoodsVO> goodsList = goodsDAO.selectGoodsBySearchWord(searchWord);
		return goodsList;
	}
}
