package com.bookshop02.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	//마이페이지 메인
	@Override
	@RequestMapping(value="/myPageMain.do", method=RequestMethod.GET)
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
		
		System.out.println("myOrderList size"+myOrderList.size());
		mav.addObject("message",message);
		mav.addObject("myOrderList",myOrderList);
		
		return mav;
	}
	
	//주문 취소
	@Override
	@RequestMapping(value="cancelMyOrder.do", method = RequestMethod.POST)
	public ModelAndView cancelMyOrder(@RequestParam("order_id") String order_id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		myPageService.cancelOrder(order_id);
		mav.addObject("message","cancel_order");
		mav.setViewName("redirect:/mypage/myPageMain.do");
		
		return mav;
	}
	
	//마이페이지 내정보
	@Override
	@RequestMapping(value="/myDetailInfo.do", method=RequestMethod.GET)
	public ModelAndView myDetailInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String viewName = (String)request.getAttribute("viewName");
		System.out.println(viewName+"오지");
		ModelAndView mav = new ModelAndView(viewName);
		
		return mav;
	}
	
	//마이페이지 - 내정보 수정
	@Override
	@RequestMapping(value="/modifyMyInfo.do", method=RequestMethod.POST)
	public ResponseEntity modifyMyInfo(@RequestParam("attribute")String attribute, @RequestParam("value") String value, HttpServletRequest request,
			HttpServletResponse reponse) throws Exception {
		
		Map<String, String> memberMap = new HashMap<String, String>();
		
		String val[] = null;
		HttpSession session = request.getSession();
		
		memberVO = (MemberVO)session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
		
		if(attribute.equals("member_birth")) {
			val = value.split(",");
			memberMap.put("member_birth_y", val[0]);
			memberMap.put("member_birth_m", val[1]);
			memberMap.put("member_birth_d", val[2]);
			memberMap.put("member_birth_gn", val[3]);
		}else if(attribute.equals("tel")) {
			val = value.split(",");
			memberMap.put("tel1",val[0]);
			memberMap.put("tel2",val[1]);
			memberMap.put("tel3",val[2]);
		}else if(attribute.equals("hp")) {
			val = value.split(",");
			memberMap.put("hp1",val[0]);
			memberMap.put("hp2",val[1]);
			memberMap.put("hp3",val[2]);
			memberMap.put("smssts_yn", val[3]);
		}else if(attribute.equals("email")) {
			val = value.split(",");
			memberMap.put("email1", val[0]);
			memberMap.put("email2", val[1]);
			memberMap.put("emailsts_yn", val[2]);
		}else if(attribute.equals("address")) {
			val = value.split(",");
			memberMap.put("zipcode", val[0]);
			memberMap.put("roadAddress", val[1]);
			memberMap.put("jibunAddress", val[2]);
			memberMap.put("numujiAddress", val[3]);
		}else {
			memberMap.put(attribute, value);
		}
		
		memberMap.put("member_id", member_id);
		
		//수정된 회원정보를 다시 세션에 저장한다.
		memberVO = (MemberVO)myPageService.modifyMyInfo(memberMap);
		session.removeAttribute("memberInfo");
		session.setAttribute("memberInfo", memberVO);
		
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		
		message = "mod_success";
		
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		
		return resEntity;
	}
	
	
	

}
