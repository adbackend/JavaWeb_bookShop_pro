package com.bookshop02.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.coobird.thumbnailator.Thumbnails;

@Controller
public class FileDownloadController {
	
	private static String CURR_IMAGE_REPO_PATH = "C:\\shopping\\file_repo";
	
	@RequestMapping("/download.do")
	protected void download(@RequestParam("goods_id") String goods_id, 
						 @RequestParam("fileName") String fileName,
						 HttpServletResponse response) throws Exception{
		
		OutputStream out = response.getOutputStream(); //외부로 데이터를 출력하는 역활
		
		String filePath = CURR_IMAGE_REPO_PATH+"\\"+goods_id+"\\"+fileName;
		
		System.out.println("다운로드 컨트롤러 도달하냐..? 그럼 파일경로는 뭔데..??"+filePath);

		File image = new File(filePath);
		
		//다운로드 준비로 서버에서 클라이언트에게 다운로드 준비를 시키는 부분(다운로드 창을 띄운다)
		response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment; fileName="+fileName);
		
		//실제 다운로드를 하는 부분
		FileInputStream in = new FileInputStream(image);
		
		byte[] buffer = new byte[1024*8];
		
		while(true) {
			int count = in.read(buffer); //버퍼에 읽어들인 문자개수
			
			if(count==-1) { //버퍼의 마지막에 도달했는지 체크
				break;
			}
			
			out.write(buffer,0,count);
		}
		
		in.close();
		
		
	}
	
	@RequestMapping("/thumbnails.do")
	protected void thumbnail(@RequestParam("goods_id") String goods_id,
							 @RequestParam("fileName") String fileName,
							 HttpServletResponse response) throws Exception{
		
		System.out.println("썸네일 아이디, 파일이름 받냐..?"+goods_id+","+fileName);
		OutputStream out = response.getOutputStream();
		
		String filePath = CURR_IMAGE_REPO_PATH+"\\"+goods_id+"\\"+fileName;
		
		File image = new File(filePath);
		
		if(image.exists()) {
			Thumbnails.of(image).size(121, 154).outputFormat("png").toOutputStream(out);
		}
		
		byte[] buffer = new byte[1024*8];
		
		out.write(buffer);
		out.close();
	}

}
