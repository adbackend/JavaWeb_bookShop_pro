package com.bookshop02.order.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop02.common.base.BaseController;
import com.bookshop02.member.vo.MemberVO;
import com.bookshop02.order.service.OrderService;
import com.bookshop02.order.vo.OrderVO;

@Controller("orderController")
@RequestMapping(value="/order")
public class OrderControllerImpl extends BaseController implements OrderController{
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private OrderVO orderVO;
	
	//상품 상세 페이지(바로주문)에서 주문
	@Override
	@RequestMapping(value="/orderEachGoods.do", method=RequestMethod.POST)
	public ModelAndView orderEachGoods(@ModelAttribute("orderVO") OrderVO _orderVO, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println(_orderVO.getGoods_id()+_orderVO.getGoods_title());
		
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		session = request.getSession();
		
		Boolean isLogOn = (Boolean)session.getAttribute("isLogOn");
		String action = (String)session.getAttribute("action");

		//로그인 여부체크
		//이전에 로그인 상태인 경우는 주문과정 진행
		//로그아웃 상태인 경우 로그인 화면으로 이동
		if(isLogOn==null || isLogOn==false) { //로그인을 하지 않으면 먼저 로그인후 주문을 처리, 주문정보와 주문 페이지 요청 URL을 세션에 저장
			
			session.setAttribute("orderInfo", _orderVO);
			session.setAttribute("action", "/order/orderEachGoods.do");
			
			return new ModelAndView("redirect:/member/loginForm.do");
			
		}else { //로그인 후 세션에 주문 정보를 가져와 바로 주문창으로 이동
			if(action!=null &&  action.equals("/order/orderEachGoods.do")) {
				orderVO = (OrderVO)session.getAttribute("orderInfo");
				session.removeAttribute("action");
			}else { //미리 로그인 했다면 바로 주문처리
				orderVO=_orderVO;
			}
		}
		
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		List<OrderVO> myOrderList = new ArrayList<OrderVO>(); //주문 정보를 저장할 주문 ArrayList를 생성
		myOrderList.add(orderVO); //브라우저에 전달할 주문 정보를 ArrayList에 저장
		
		MemberVO memberInfo = (MemberVO)session.getAttribute("memberInfo");
		
		session.setAttribute("myOrderList", myOrderList);
		session.setAttribute("orderer", memberInfo);
		
		return mav;
	}
	

}









