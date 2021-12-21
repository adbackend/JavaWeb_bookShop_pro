package com.bookshop02.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop02.common.base.BaseController;
import com.bookshop02.member.service.MemberService;
import com.bookshop02.member.vo.MemberVO;

@Controller("memberController")
@RequestMapping(value="/member")
public class MemberControllerImpl extends BaseController implements MemberController{
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MemberVO memberVO;
	
	//로그인
	@Override
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public ModelAndView login(@RequestParam Map<String, String> loginMap, 
						HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("login.do 컨트롤러에 오냐...?");
		ModelAndView mav = new ModelAndView();
		
		memberVO = memberService.login(loginMap);
		
		if(memberVO != null && memberVO.getMember_id()!=null) {
			
			System.out.println("memberVO존재..?"+memberVO.getMember_id());
			HttpSession session = request.getSession();
			
			session=request.getSession();
			session.setAttribute("isLogOn", true);
			session.setAttribute("memberInfo", memberVO);
			
			String action=(String)session.getAttribute("action");
			System.out.println("action값...?"+action);
			
			//상품주문 과정에서 로그인했으면 로그인 후 다시 주문화면으로 진행하고 그외에는 메인페이지 표시
			if(action != null && action.equals("/order/orderEachGoods.do")) {
				mav.setViewName("forward:"+action);
			}else {
				mav.setViewName("redirect:/main/main.do");
			}
			
		}else {
			String message = "아이디나 비밀번호가 일치하지않습니다. 다시로그인해주세요";
			mav.addObject("message",message);
			mav.setViewName("/member/loginForm");
		}
		return mav;
	}
	
	//로그아웃 처리
	@Override
	@RequestMapping(value="/logout.do", method=RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");
		mav.setViewName("redirect:/main/main.do");
		
		return mav;
	}

}
