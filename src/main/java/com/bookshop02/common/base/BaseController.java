package com.bookshop02.common.base;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

public abstract class BaseController {
	
	private static final String CURR_IMAGE_REPO_PATH = "C:\\shopping\\file_repo";
	
	

	//구체적으로 일치하는 요청명이 우선입니다. 책 앞부분 url pattern부분을 복습
	@RequestMapping(value="/*.do", method={RequestMethod.POST, RequestMethod.GET})
	protected ModelAndView viewForm(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String viewName = (String)request.getAttribute("viewName");
		
		System.out.println("뷰네임은...?"+viewName);
		
		ModelAndView mav = new ModelAndView(viewName);
		
		return mav;
	}
}
