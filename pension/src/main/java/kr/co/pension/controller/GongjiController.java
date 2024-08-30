package kr.co.pension.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.pension.dao.GongjiDao;
import kr.co.pension.dto.GongjiDto;

@Controller
public class GongjiController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/gongji/list")
	public String list(Model model) {
		GongjiDao gdao=sqlSession.getMapper(GongjiDao.class);
		ArrayList<GongjiDto> glist=gdao.list();
		model.addAttribute("glist",glist);
		
		return "/gongji/list";
	}
	
	@RequestMapping("/gongji/write")
	public String write() {
		return "/gongji/write";
	}
	
	@RequestMapping("/gongji/writeOk")
	public String writeOk(GongjiDto gdto) {
		GongjiDao gdao=sqlSession.getMapper(GongjiDao.class);
		gdao.writeOk(gdto);
		
		return "redirect:/gongji/list";
	}
	
	@RequestMapping("/gongji/readnum")
	public String readnum(HttpServletRequest request) {
		String id=request.getParameter("id");
		
		GongjiDao gdao=sqlSession.getMapper(GongjiDao.class);
		gdao.readnum(id);
		
		return "redirect:/gongji/content?id="+id;
	}
	
	@RequestMapping("/gongji/content")
	public String content(HttpServletRequest request, Model model) {
		String id=request.getParameter("id");
		
		GongjiDao gdao=sqlSession.getMapper(GongjiDao.class);
		GongjiDto gdto=gdao.content(id);
		
		// content에 br태그 넣기
		gdto.setContent(gdto.getContent().replace("\r\n", "<br>"));
		
		model.addAttribute("gdto",gdto);
		
		return "/gongji/content";
	}
	
	@RequestMapping("/gongji/delete")
	public String delete(HttpServletRequest request) {
		String id=request.getParameter("id");	
		
		GongjiDao gdao=sqlSession.getMapper(GongjiDao.class);
		gdao.delete(id);
		
		return "redirect:/gongji/list";
	}
	
	@RequestMapping("/gongji/update")
	public String update(HttpServletRequest request, Model model) {
		String id=request.getParameter("id");
		
		GongjiDao gdao=sqlSession.getMapper(GongjiDao.class);
		GongjiDto gdto=gdao.content(id); // 동일한 동작
		
		model.addAttribute("gdto",gdto);
		
		return "/gongji/update";
	}
	
	@RequestMapping("/gongji/updateOk")
	public String updateOk(GongjiDto gdto) {
		GongjiDao gdao=sqlSession.getMapper(GongjiDao.class);
		gdao.updateOk(gdto);
		
		return "redirect:/gongji/content?id="+gdto.getId();
	}

}