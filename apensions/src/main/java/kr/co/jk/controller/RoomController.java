package kr.co.jk.controller;

import jakarta.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.jk.dto.RoomDto;
import kr.co.jk.mapper.RoomMapper;
import kr.co.jk.util.Utils;

@Controller
public class RoomController {
 
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/room/roomView")
	public String roomView(HttpServletRequest request, Model model) {
		String id=request.getParameter("id");
		
		RoomMapper rdao=sqlSession.getMapper(RoomMapper.class);
		RoomDto rdto=rdao.roomView(id);
		
		String price2=Utils.comma(rdto.getPrice()); // 숫자에 ,를 넣은 문자열
		rdto.setPrice2(price2);
		
		String content=rdto.getContent().replace("\r\n", "<br>");
		rdto.setContent(content);
		
		// 사진파일명을 ,로 구분하여 만들기
		String[] imgs=rdto.getRimg().split("/"); //    그림파일1/그림파일2/그림파일3/
		String imsi=""; // "그림파일1","그림파일2","그림파일3"
		for(int i=0;i<imgs.length;i++) // 크기가 3이면 마지막 요소는 인덱스가 2
		{
			imsi=imsi+"\""+imgs[i]+"\"";
			
			if(i!=imgs.length-1) // 마지막 배열의 요소가 아니라면
				imsi=imsi+",";	
		}
		model.addAttribute("imsi",imsi);
		// 여러개의 사진중 첫번째 그림을 rdto의 rimg필드에 값을 대체
		rdto.setRimg(imgs[0]);
		
		model.addAttribute("rdto",rdto);
		
		return "/room/roomView";
	}
}
