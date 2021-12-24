package com.bookshop02.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop02.common.base.BaseController;
import com.bookshop02.member.service.MemberService;
import com.bookshop02.member.vo.MemberVO;


/**
  * @FileName : MemberControllerImpl.java
  * @Date : 2021. 12. 22. 
  * @Author : 최유정
  * @Description : 
  */

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
			System.out.println("memberInfo 세션에 저장된 컬럼....?"+memberVO.toString());
			
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
		String message="로그아웃 되었습니다.";
		mav.addObject("message",message);
		mav.setViewName("redirect:/main/main.do");
		
		return mav;
	}
	
	//아이디 중복체크 
	@Override
	@RequestMapping(value="/overlapped.do" , method=RequestMethod.POST)
	public ResponseEntity overlapped(@RequestParam("id") String id, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ResponseEntity resEntity = null;
		
		String result = memberService.overlapped(id);
		
		resEntity = new ResponseEntity(result,HttpStatus.OK);
		
		return resEntity;
	}
	
	@Override
	@RequestMapping(value="/addMember.do", method=RequestMethod.POST)
	public ResponseEntity addMember(@ModelAttribute("member") MemberVO _memberVO,
									HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		String message = null;
		
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		System.out.println("회원가입 정보 받아오긴하냐...?"+_memberVO.toString());
		System.out.println("disabled 값을 안받아..?"+_memberVO.getEmail2());
		System.out.println("readonly 값을 받고....?"+_memberVO.getEmail2());
		
		try {
			
			memberService.addMember(_memberVO);
			message="<script>";
			message+="alert('회원가입을 마쳤습니다. 로그인 창으로 이동합니다');";
			message+="location.href='"+request.getContextPath()+"member/loginForm';";
			message+="</script>";
			
		}catch (Exception e) {
			message = "<script>";
			message += "alert('작업중 오류발생, 다시 시도해주세요');";
			message += "location.href='"+request.getContextPath()+"/member/memberForm.do';";
			message += "</script>";
			
			e.printStackTrace();
		}
		
		resEntity = new ResponseEntity(message,responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	

}







