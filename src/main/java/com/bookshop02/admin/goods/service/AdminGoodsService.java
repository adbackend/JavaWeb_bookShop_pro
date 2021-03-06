package com.bookshop02.admin.goods.service;

import java.util.List;
import java.util.Map;

import com.bookshop02.goods.vo.GoodsVO;
import com.bookshop02.goods.vo.ImageFileVO;

public interface AdminGoodsService {
	
	public List<GoodsVO> listNewGoods(Map condMap) throws Exception; //메인페이지
	
	public int addNewGoods(Map newGoodsMap) throws Exception; //상품등록
	
	public Map goodsDetail(int goods_id) throws Exception;
	
	public void modifyGoodsInfo(Map goodsMap) throws Exception; //수정
	
	public void addNewGoodsImage(List<ImageFileVO> imageFileList) throws Exception; //이미지 수정

	public void removeGoodsImageFile(int image_id) throws Exception; //이미지 삭제
}
