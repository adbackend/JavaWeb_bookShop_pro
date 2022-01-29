package com.bookshop02.admin.goods.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bookshop02.admin.goods.dao.AdminGoodsDAO;
import com.bookshop02.goods.vo.GoodsVO;
import com.bookshop02.goods.vo.ImageFileVO;

@Service("adminGoodsService")
@Transactional(propagation = Propagation.REQUIRED)
public class AdminGoodsServiceImpl implements AdminGoodsService{
	
	@Autowired
	private AdminGoodsDAO adminGoodsDAO;
	
	@Override
	public List<GoodsVO> listNewGoods(Map condMap) throws Exception {

		return adminGoodsDAO.selectNewGoodsList(condMap);
	}
	
	//상품등록
	@Override
	public int addNewGoods(Map newGoodsMap) throws Exception {
		
		int goods_id = adminGoodsDAO.insertNewGoods(newGoodsMap);
		
		System.out.println("service단 goods_id값은..?"+goods_id);
		
		ArrayList<ImageFileVO> imageFileList = (ArrayList)newGoodsMap.get("imageFileList");
		
		for(ImageFileVO imageFileListVO : imageFileList) {
			imageFileListVO.setGoods_id(goods_id);
		}
		
		adminGoodsDAO.insertGoodsImageFile(imageFileList);
		
		return goods_id;
	}
	
	@Override
	public Map goodsDetail(int goods_id) throws Exception {
		
		Map goodsMap = new HashMap();
		
		GoodsVO goodsVO = adminGoodsDAO.selectGoodsDetail(goods_id);
		List imageFileList = adminGoodsDAO.selectGoodsImageFileList(goods_id);
		
		goodsMap.put("goods", goodsVO);
		goodsMap.put("imageFileList", imageFileList);
		
		return goodsMap;
	}
	
	//수정
	@Override
	public void modifyGoodsInfo(Map goodsMap) throws Exception {
		adminGoodsDAO.updateGoodsInfo(goodsMap);
	}

}
