package com.bookshop02.admin.goods.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public interface AdminGoodsController {
	
	//관리자 메인
	public ModelAndView adminGoodsMain(@RequestParam Map<String, String> dateMap, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	//상품등록
	public ResponseEntity addNewGoods(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception;
	
	
	//상품수정
	public ResponseEntity modifyGoodsInfo(@RequestParam("goods_id") String goods_id,
										  @RequestParam("mod_type") String mod_type,
										  @RequestParam("value") String value, HttpServletRequest request, HttpServletResponse response) throws Exception;

	//이미지 수정
	public void addNewGoodsImage(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception;
	
	//이미지 삭제
	public void removeGoodsImage(@RequestParam("goods_id") int goods_id,
								 @RequestParam("image_id") int image_id,
								 @RequestParam("imageFileName") String imageFileName,
								 HttpServletRequest request, HttpServletResponse response) throws Exception;
}








