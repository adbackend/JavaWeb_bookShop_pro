package com.bookshop02.cart.controller;

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

import com.bookshop02.cart.service.CartService;
import com.bookshop02.cart.vo.CartVO;
import com.bookshop02.common.base.BaseController;
import com.bookshop02.member.vo.MemberVO;

@Controller("cartController")
@RequestMapping(value="/cart")
public class CartControllerImpl extends BaseController implements CartController{
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private CartVO cartVO;
	
	@Autowired
	private MemberVO memberVO;
	
	@Override
	@RequestMapping(value="/addGoodsInCart.do", method=RequestMethod.POST, produces="application/text; charset=utf-8")
	public @ResponseBody String addGoodsInCart(@RequestParam("goods_id") int goods_id,
											HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		HttpSession session = request.getSession();
		memberVO = (MemberVO)session.getAttribute("memberInfo");
		
		String member_id = memberVO.getMember_id();
		
		cartVO.setMember_id(member_id);
		cartVO.setGoods_id(goods_id);
		
		//카트 등록전에 이미 등록된 제품인지 판별
		boolean isAreadyExisted = cartService.findCartGoods(cartVO);
		System.out.println("isAreadExisted...값은...?"+isAreadyExisted);
		
		if(isAreadyExisted==true) {
			return "already_existed";
		}else {
			cartService.addGoodsInCart(cartVO);
			return "add_success";
		}
		
	}
	
	//장바구니 목록
	@Override
	@RequestMapping(value="/myCartList.do", method=RequestMethod.GET)
	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String viewName = (String)request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session = request.getSession();
		
		MemberVO memberVO = (MemberVO)session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
		
		System.out.println("MemberVO에는 뭐가..?"+memberVO.toString());
		
		//장바구니 페이지에 표시할 상품 정보를 조회
		Map<String, List> cartMap = cartService.myCartList(cartVO);
		
		return null;
	}

}














