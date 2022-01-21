package com.bookshop02.common.base;

import java.io.File;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop02.goods.vo.ImageFileVO;

public abstract class BaseController {
	
	private static final String CURR_IMAGE_REPO_PATH = "C:\\shopping\\file_repo";
	
	protected List<ImageFileVO> upload(MultipartHttpServletRequest multipartRequest) throws Exception{
		
		List<ImageFileVO> fileList = new ArrayList<ImageFileVO>();
		
		Iterator<String> fileNames = multipartRequest.getFileNames(); //파일 이름이 아니라->파라미터이름(file1, file2..)
		
		while(fileNames.hasNext()) {
			
			ImageFileVO imageFileVO = new ImageFileVO();
			
			String fileName = fileNames.next();
			imageFileVO.setFileType(fileName);
			
			MultipartFile mFile = multipartRequest.getFile(fileName); //파일(이름, 타입, 크기)
			
			String originalFileName = mFile.getOriginalFilename(); //실제 업로드된 파일 이름
			imageFileVO.setFileName(originalFileName);
			fileList.add(imageFileVO);
			
			//파일을 업로드할 경로 확인
			File file = new File(CURR_IMAGE_REPO_PATH+"\\"+fileName);
			
			if(mFile.getSize()!=0) { //file null check 티렉토리가 존재하는지 검사
				if(!file.exists()) { // 경로상에 파일이 존재하지 않을 경우
					if(file.getParentFile().mkdirs()) { //상위 티렉토리를 빠져나가 디렉토리 생성
						file.createNewFile(); //이후 파일 생성
					}
				}
				//임시로 저장된 multipartFile을 실제 파일로 전송
				mFile.transferTo(new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+originalFileName)); 
			}
		}
		
		return fileList;
	}
	
	private void deleteFile(String fileName) {
		File file = new File(CURR_IMAGE_REPO_PATH + "\\" + fileName);
		
		try {
			file.delete();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	//구체적으로 일치하는 요청명이 우선입니다. 책 앞부분 url pattern부분을 복습
	@RequestMapping(value="/*.do", method={RequestMethod.POST, RequestMethod.GET})
	protected ModelAndView viewForm(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String viewName = (String)request.getAttribute("viewName");
		
		System.out.println("뷰네임은...?"+viewName);
		
		ModelAndView mav = new ModelAndView(viewName);
		
		return mav;
	}
	
	//검색기간 설정
	protected String calcSearchPeriod(String fixedSearchPeriod) {
		
		String beginDate = null;
		
		String endDate = null;
		String endYear = null;
		String endMonth = null;
		String endDay = null;
		
		String beginYear = null;
		String beginMonth = null;
		String beginDay = null;
		
		DecimalFormat df = new DecimalFormat("00");
		Calendar cal = Calendar.getInstance();
		
		endYear = Integer.toString(cal.get(Calendar.YEAR));
		endMonth = df.format(cal.get(Calendar.MONTH+1));
		endDay = df.format(cal.get(Calendar.DATE));
		
		endDate = endYear + "-" + endMonth + "-" + endDay;
		
		if(fixedSearchPeriod == null) {
			cal.add(cal.MONTH, -4);
		}else if(fixedSearchPeriod.equals("one_week")) {
			cal.add(cal.DAY_OF_YEAR, -7);
		}else if(fixedSearchPeriod.equals("two_week")) {
			cal.add(Calendar.DAY_OF_YEAR, -14);
		}else if(fixedSearchPeriod.equals("one_month")) {
			cal.add(cal.MONTH, -1);
		}else if(fixedSearchPeriod.equals("two_month")) {
			cal.add(cal.MONTH, -2);
		}else if(fixedSearchPeriod.equals("three_month")) {
			cal.add(cal.MONTH, -3);
		}else if(fixedSearchPeriod.equals("four_month")) {
			cal.add(cal.MONTH, -4);
		}
		
		beginYear = Integer.toString(cal.get(Calendar.YEAR));
		beginMonth = df.format(cal.get(Calendar.MONTH)+1);
		beginDay = df.format(cal.get(Calendar.DATE));
		beginDate = beginYear + "-" + beginMonth + "-" + beginDay;
		
		return beginDate + "," + endDate;
		
	}
}









