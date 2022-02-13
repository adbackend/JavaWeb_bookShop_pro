package com.bookshop02.admin.goods.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.bookshop02.goods.vo.GoodsVO;

public interface AdminGoodsDAO {
	
	public List<GoodsVO> selectNewGoodsList(Map condMap) throws DataAccessException;
	
	public int insertNewGoods(Map newGoodsMap) throws DataAccessException;
	
	//파일 업로드
	public void insertGoodsImageFile(List fileList) throws DataAccessException;
	
	public GoodsVO selectGoodsDetail(int goods_id) throws DataAccessException;

	public List selectGoodsImageFileList(int goods_id) throws DataAccessException;
	
	public void updateGoodsInfo(Map goodsMap) throws DataAccessException; //상품수정
	
	public void deleteGoodsImage(int image_id) throws DataAccessException; //이미지 삭제
}
