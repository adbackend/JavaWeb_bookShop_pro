package com.bookshop02.admin.goods.controller;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.bookshop02.admin.goods.service.AdminGoodsService;
import com.bookshop02.common.base.BaseController;
import com.bookshop02.goods.vo.GoodsVO;
import com.bookshop02.goods.vo.ImageFileVO;
import com.bookshop02.member.vo.MemberVO;

@Controller("adminGoodsController")
@RequestMapping(value="/admin/goods")
public class AdminGoodsControllerImpl extends BaseController implements AdminGoodsController {
	
	private static final String CURR_IMAGE_REPO_PATH = "C:\\shopping\\file_repo";
	
	@Autowired
	private AdminGoodsService adminGoodsService;
	
	@Override
	@RequestMapping(value="/adminGoodsMain.do", method= {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView adminGoodsMain(@RequestParam Map<String, String> dateMap, 
								HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("안온다고....?...");
		String viewName = (String)request.getAttribute("viewName");
		
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session = request.getSession();
		session.setAttribute("side_menu", "admin_mode"); //마이페이지 사이드 메뉴로 설정한다.
		
		String fixedSearchPeriod = dateMap.get("fixedSearchPeriod");
		String section = dateMap.get("section");
		String pageNum = dateMap.get("pageNum");
		String beginDate=null,endDate=null;
		
		String [] tempDate=calcSearchPeriod(fixedSearchPeriod).split(",");
		beginDate=tempDate[0];
		endDate=tempDate[1];
		dateMap.put("beginDate", beginDate);
		dateMap.put("endDate", endDate);
		
		Map<String,Object> condMap=new HashMap<String,Object>();
		if(section== null) {
			section = "1";
		}
		condMap.put("section",section);
		if(pageNum== null) {
			pageNum = "1";
		}
		condMap.put("pageNum",pageNum);
		condMap.put("beginDate",beginDate);
		condMap.put("endDate", endDate);
		List<GoodsVO> newGoodsList=adminGoodsService.listNewGoods(condMap);
		mav.addObject("newGoodsList", newGoodsList);
		
		String beginDate1[]=beginDate.split("-");
		String endDate2[]=endDate.split("-");
		mav.addObject("beginYear",beginDate1[0]);
		mav.addObject("beginMonth",beginDate1[1]);
		mav.addObject("beginDay",beginDate1[2]);
		mav.addObject("endYear",endDate2[0]);
		mav.addObject("endMonth",endDate2[1]);
		mav.addObject("endDay",endDate2[2]);
		
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		return mav;
	}
	
	//상품등록
	@Override
	@RequestMapping(value="/addNewGoods.do", method=RequestMethod.POST)
	public ResponseEntity addNewGoods(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		
		System.out.println("도달은 하냐..?");
		multipartRequest.setCharacterEncoding("utf-8");
		
		response.setContentType("text/html; charset=utf-8");
		
		String imageFileName = null;
		Map newGoodsMap = new HashMap();
		
		Enumeration enu = multipartRequest.getParameterNames(); //id, name 파라미터 값을 불러온다
		while(enu.hasMoreElements()) {
			String name = (String)enu.nextElement(); //id
			String value = multipartRequest.getParameter(name);
			
			newGoodsMap.put(name, value);
		}
		
		HttpSession session = multipartRequest.getSession();
		MemberVO memberVO = (MemberVO)session.getAttribute("memberInfo");
		String reg_id = memberVO.getMember_id();
		
		List<ImageFileVO> imageFileList = upload(multipartRequest);
		
		
		if(imageFileList!=null && imageFileList.size()!=0) {
			for(ImageFileVO imageFileVO : imageFileList) {
				imageFileVO.setReg_id(reg_id);
			}
			newGoodsMap.put("imageFileList", imageFileList);
		}
		
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		try {
			
			int goods_id = adminGoodsService.addNewGoods(newGoodsMap);
			
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ImageFileVO imageFileVO : imageFileList) {
					imageFileName = imageFileVO.getFileName();
					
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					File destDir = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_id);
					FileUtils.moveFileToDirectory(srcFile, destDir,true);
				}
			}
			message = "<script>";
			message += "alert('새 상품을 추가 했습니다.');";
			message += "location.href='"+multipartRequest.getContextPath()+"/admin/goods/addNewGoodsForm.do';";
			message += ("</script>");
			
		} catch (Exception e) {
			
			if(imageFileList!=null && imageFileList.size()!=0 ) {
				for(ImageFileVO imageFileVO: imageFileList) {
					imageFileName = imageFileVO.getFileName();
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					srcFile.delete();
				}
			}
			
			message = "<script>";
			message += "alert('오류가 발생했습니다.');";
			message += "location.href='"+multipartRequest.getContextPath()+"/admin/goods/addNewGoodsForm.do';"; 
			message += "</script>";
			e.printStackTrace();
		}
		
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		
		return resEntity;
	}
	
	//상품수정 폼
	@RequestMapping(value="/modifyGoodsForm.do", method= {RequestMethod.POST, RequestMethod.GET})
	public ModelAndView modifyGoodsForm(@RequestParam("goods_id") int goods_id,
												HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		Map goodsMap = adminGoodsService.goodsDetail(goods_id);
		mav.addObject("goodsMap",goodsMap);
		
		
		return mav;
	}
	
	//상품수정
	@Override
	@RequestMapping(value="/modifyGoodsInfo.do", method={RequestMethod.POST})
	public ResponseEntity modifyGoodsInfo(@RequestParam String goods_id, 
										  @RequestParam String attribute, 
										  @RequestParam String value, 
								HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		Map<String, String> goodsMap = new HashMap<String, String>();
		goodsMap.put("goods_id", goods_id);
		goodsMap.put(attribute, value);
		
		adminGoodsService.modifyGoodsInfo(goodsMap);
		
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		
		message = "mod_success";
		
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		
		return resEntity;
	}
	
	//이미지 수정
	@RequestMapping(value="/addNewGoodsImage.do", method={RequestMethod.POST})
	@Override
	public void addNewGoodsImage(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {

		System.out.println("addNewGoodsImage");
		System.out.println(multipartRequest.getParameter("fileType"));
		
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String imageFileName = null;
		
		Map goodsMap = new HashMap();
		
		Enumeration enu = multipartRequest.getParameterNames();
		while(enu.hasMoreElements()) {
			String name = (String)enu.nextElement();
			String value = multipartRequest.getParameter(name);
			goodsMap.put(name,value);
		}
		
		HttpSession session = multipartRequest.getSession();
		
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String reg_id = memberVO.getMember_id(); //등록자 아이디
		
		List<ImageFileVO> imageFileList = null;
		
		int goods_id = 0;
		
		try {
			
			imageFileList = upload(multipartRequest);
			
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ImageFileVO imageFileVO : imageFileList) {
					goods_id = Integer.parseInt((String)goodsMap.get("goods_id"));
					imageFileVO.setGoods_id(goods_id);
					imageFileVO.setReg_id(reg_id);
				}
				
				adminGoodsService.addNewGoodsImage(imageFileList);
				
				for(ImageFileVO imageFileVO: imageFileList) {
					imageFileName = imageFileVO.getFileName();
					
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					File destDir = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_id);
					FileUtils.moveFileToDirectory(srcFile, destDir, true); //존재하지 않는 폴더 생성 true, false:존재하지 않는 폴더 생성하지 않음
				}
				
			}
			
		} catch (Exception e) {
			if(imageFileList!=null && imageFileList.size()!=0) {
				for(ImageFileVO imageFileVO : imageFileList) {
					imageFileName = imageFileVO.getFileName();
					
					File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+"temp"+"\\"+imageFileName);
					srcFile.delete();
				}
			}
			e.printStackTrace();
		}
	}
	
	@Override
	@RequestMapping(value="/removeGoodsImage.do", method=RequestMethod.POST)
	public void removeGoodsImage(@RequestParam("goods_id") int goods_id,
			                     @RequestParam("image_id") int image_id,
			                     @RequestParam("imageFileName") String imageFileName, 
			                     HttpServletRequest request, HttpServletResponse response) throws Exception {

		adminGoodsService.removeGoodsImageFile(image_id);
		
		try {
			
			File srcFile = new File(CURR_IMAGE_REPO_PATH+"\\"+goods_id+"\\"+imageFileName);
			srcFile.delete();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	

}










