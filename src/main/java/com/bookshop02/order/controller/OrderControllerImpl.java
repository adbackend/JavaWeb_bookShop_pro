package com.bookshop02.order.controller;

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

		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		session = request.getSession();
		
		Boolean isLogOn = (Boolean)session.getAttribute("isLogOn");
		
		
		return null;
	}
	

}
