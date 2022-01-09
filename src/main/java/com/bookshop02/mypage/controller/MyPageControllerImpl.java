package com.bookshop02.mypage.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop02.common.base.BaseController;
import com.bookshop02.member.vo.MemberVO;
import com.bookshop02.mypage.service.MyPageService;
import com.bookshop02.mypage.vo.MyPageVO;
import com.bookshop02.order.vo.OrderVO;

@Controller("myPageController")
@RequestMapping(value="/mypage")
public class MyPageControllerImpl extends BaseController implements MyPageController{
	
	@Autowired
	private MyPageService myPageService;
	
	@Autowired
	private MemberVO memberVO;
	
	@Override
	public ModelAndView myPageMain(@RequestParam(required=false, value="message") String message, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		HttpSession session = request.getSession();
		session = request.getSession();
		session.setAttribute("side_menu", "my_page"); //마이페이지 사이드 메뉴로 설정한다.
		
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		memberVO = (MemberVO)session.getAttribute("memberInfo");
		
		String member_id = memberVO.getMember_id();
		
		List<OrderVO> myOrderList = myPageService.listMyOrderGoods(member_id);
		
		mav.addObject("message",message);
		mav.addObject("myOrderList",myOrderList);
		
		return mav;
	}
	

}
