package com.bookshop02.goods.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop02.common.base.BaseController;
import com.bookshop02.goods.service.GoodsService;
import com.bookshop02.goods.vo.GoodsVO;

import net.sf.json.JSONObject;

@Controller("goodsController")
@RequestMapping(value="/goods")
public class GoodsControllerImpl extends BaseController implements GoodsController{

	@Autowired
	private GoodsService goodsService;
	
	@Override
	@RequestMapping(value="/goodsDetail.do", method=RequestMethod.GET)
	public ModelAndView goodsDetail(@RequestParam("goods_id")String goods_id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String viewName = (String)request.getAttribute("viewName");
		
		System.out.println("상세페이지 뷰네임 ....?"+viewName);
		HttpSession session = request.getSession();
		
		Map goodsMap = goodsService.goodsDetail(goods_id);

		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsMap",goodsMap);
		
		GoodsVO goodsVO = (GoodsVO)goodsMap.get("goodsVO");
		addGoodsInQuick(goods_id, goodsVO, session);
		
		return mav;
	}
	
	private void addGoodsInQuick(String goods_id, GoodsVO goodVO, HttpSession session) {
		
		boolean already_existed = false;
		
		List<GoodsVO> quickGoodsList; //최근 본 상품 저장 ArrayList
		
		quickGoodsList = (ArrayList<GoodsVO>)session.getAttribute("quickGoodsList");
		
		if(quickGoodsList!=null) { //최근 본 상품이 있는 경우
			if(quickGoodsList.size()<4) { //미리본 상품 리스트에 상품개수가 세개 이하인 경우
				for(int i=0; i<quickGoodsList.size(); i++) {
					GoodsVO _goodsBean = (GoodsVO)quickGoodsList.get(i);
					if(goods_id.equals(Integer.toString(_goodsBean.getGoods_id()))) {
						already_existed=true;
//						break;
						return;
					}
				}
				if(already_existed==false) {
					quickGoodsList.add(goodVO);
				}
			}
		}else {  //최근 본 상품 목록이 없으면 생성하여 상품 정보를 저장
			quickGoodsList = new ArrayList<GoodsVO>();
			quickGoodsList.add(goodVO);
		}
		
		session.setAttribute("quickGoodsList", quickGoodsList); //최근 본 상품 목록을 세션에 저장
		session.setAttribute("quickGoodsListNum", quickGoodsList.size());
		
	}
	
	@Override
	@RequestMapping(value="/keywordSearch.do", method=RequestMethod.GET, produces = "application/text; charset=utf-8") //브라우저에 전송하는 JSON 데이터의 한글 인코딩
	public @ResponseBody String keywordSearch(@RequestParam("keyword") String keyword, 
							HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		response.setContentType("text/html; charset=utf-8");
		response.setCharacterEncoding("utf-8");
		System.out.println("입력한 키워드 값"+keyword);
		
		if(keyword==null || keyword.equals("")) {
			return null;
		}
		
		keyword = keyword.toUpperCase(); //대문자로 변환
		
		List<String> keywordList = goodsService.keywordSearch(keyword);
		
		System.out.println("키워드 사이즈는....?"+keywordList.size());
		
		//최종 완성될 JSONObject 선언(객체)
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("keyword", keywordList);
		
		String jsonInfo = jsonObject.toString();
		
		return jsonInfo;
	}
	
	@Override
	@RequestMapping(value="/searchGoods.do", method=RequestMethod.GET)
	public ModelAndView searchGoods(@RequestParam("searchWord") String searchWord, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String viewName = (String)request.getAttribute("viewName");
		
		List<GoodsVO> goodsList = goodsService.searchGoods(searchWord);
		
		System.out.println("검색결과 사이즈...?"+goodsList.size());
		ModelAndView mav = new ModelAndView(viewName);
		
		mav.addObject("goodsList",goodsList);
		
		
		return mav;
	}
}



























