package com.bookshop02.admin.goods.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bookshop02.goods.vo.GoodsVO;
import com.bookshop02.goods.vo.ImageFileVO;

@Repository("adminGoodsDAO")
public class AdminGoodsDAOImpl implements AdminGoodsDAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<GoodsVO> selectNewGoodsList(Map condMap) throws DataAccessException {
		
		ArrayList<GoodsVO> goodsList = (ArrayList)sqlSession.selectList("mapper.admin.goods.selectNewGoodsList",condMap);
		System.out.println(goodsList.size());
		return goodsList;
	}
	
	@Override
	public int insertNewGoods(Map newGoodsMap) throws DataAccessException {
		
		sqlSession.insert("mapper.admin.goods.insertNewGoods", newGoodsMap);
		
		System.out.println("니 뭐가 찍히냐...?"+Integer.parseInt((String)newGoodsMap.get("goods_id")));
		
		return Integer.parseInt((String)newGoodsMap.get("goods_id"));
	}
	
	// 파일 업로드
	@Override
	public void insertGoodsImageFile(List fileList) throws DataAccessException {
		
		for(int i=0; i<fileList.size(); i++) {
		
			ImageFileVO imageFileVO = (ImageFileVO)fileList.get(i);
			
			sqlSession.insert("mapper.admin.goods.insertGoodsImageFile",imageFileVO);
		}
		
	}
	
	@Override
	public GoodsVO selectGoodsDetail(int goods_id) throws DataAccessException {
		
		GoodsVO goodsBean = new GoodsVO();
		goodsBean = sqlSession.selectOne("mapper.admin.goods.selectGoodsDetail",goods_id);
		
		return goodsBean;
	}
	
	@Override
	public List selectGoodsImageFileList(int goods_id) throws DataAccessException {
		
		List imageList = new ArrayList();
		
		imageList = sqlSession.selectList("mapper.admin.goods.selectGoodsImageFileList", goods_id);
		
		return imageList;
	}
	
	//상품수정
	@Override
	public void updateGoodsInfo(Map goodsMap) throws DataAccessException {
		sqlSession.update("mapper.admin.goods.updateGoodsInfo",goodsMap);
	}
	
	//이미지 삭제
	@Override
	public void deleteGoodsImage(int image_id) throws DataAccessException {
		sqlSession.delete("mapper.admin.goods.deleteGoodsImage",image_id);
		
	}
	
}
