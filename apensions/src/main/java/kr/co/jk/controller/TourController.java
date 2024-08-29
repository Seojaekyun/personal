package kr.co.jk.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.jk.dto.TourDto;
import kr.co.jk.mapper.TourMapper;

@Controller
public class TourController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/tour/list")
	public String list(Model model) {
		TourMapper tdao=sqlSession.getMapper(TourMapper.class);
		ArrayList<TourDto> tlist=tdao.list();
		
		model.addAttribute("tlist",tlist);
		
		return "/tour/list";
	}
	
	@RequestMapping("/tour/write")
	public String write() {
		return "/tour/write";
	}
	
	@RequestMapping("/tour/writeOk")
	public String writeOk(MultipartHttpServletRequest request, HttpSession session) throws Exception {
		String path = request.getServletContext().getRealPath("resources/tour");
		File dir = new File(path);
	        if (!dir.exists()) {
	            dir.mkdirs();
	        }

	        List<MultipartFile> files = request.getFiles("file");
	        StringBuilder timg = new StringBuilder();

	        for (MultipartFile file : files) {
	            String originalFilename = file.getOriginalFilename();
	            if (originalFilename != null && !originalFilename.isEmpty()) {
	                File destinationFile = new File(path + File.separator + originalFilename);
	                file.transferTo(destinationFile);
	                timg.append(originalFilename).append("/");
	            }
	        }
		
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		String userid=session.getAttribute("userid").toString();
		
		TourDto tdto=new TourDto();
		tdto.setTimg(timg);
		tdto.setTitle(title);
		tdto.setContent(content);
		tdto.setUserid(userid);
		tdto.setTimg(timg.toString().replace("null/", ""));
		
		TourMapper tdao=sqlSession.getMapper(TourMapper.class);
		tdao.writeOk(tdto);
		
		return "redirect:/tour/list";
	}
	
	@RequestMapping("/tour/readnum")
	public String readnum(HttpServletRequest request, HttpSession session) {
		String id=request.getParameter("id");
		TourMapper tdao=sqlSession.getMapper(TourMapper.class);
		if(session.getAttribute("userid")==null) {
			tdao.readnum("id");
		}
		else {
			String userid=session.getAttribute("userid").toString();
			if(!tdao.isWriter(id, userid)) {
				tdao.readnum(id);
			}
		}
		
		return "redirect:/tour/content?id="+id;
	}
	
	@RequestMapping("/tour/content")
	public String content(HttpServletRequest request, Model model) {
		String id=request.getParameter("id");
		
		TourMapper tdao=sqlSession.getMapper(TourMapper.class);
		TourDto tdto=tdao.content(id);
		
		tdto.setContent(tdto.getContent().replace("\r\n", "<br>"));
		model.addAttribute("tdto", tdto);
		
		String writer=tdao.getName(tdto.getUserid());
		model.addAttribute("writer", writer);
		
		String[] timg=tdto.getTimg().split("/");
		model.addAttribute("timg", timg);
		
		return "/tour/content";
	}
	
	@RequestMapping("/tour/update")
	public String update(HttpServletRequest request, Model model) {
		String id=request.getParameter("id");
		TourMapper tdao=sqlSession.getMapper(TourMapper.class);
		TourDto tdto=tdao.content(id);
		
		String[] timg=tdto.getTimg().split("/");
		model.addAttribute("timg", timg);
		model.addAttribute("tdto", tdto);
		
		return "/tour/update";
	}
	
	@RequestMapping("/tour/updateOk")
	public String updateOk(MultipartHttpServletRequest request, HttpSession session) throws Exception {
		String path = request.getServletContext().getRealPath("resources/tour");
		File dir = new File(path);
	        if (!dir.exists()) {
	            dir.mkdirs();
	        }

	        List<MultipartFile> files = request.getFiles("file");
	        StringBuilder timg = new StringBuilder();

	        for (MultipartFile file : files) {
	            String originalFilename = file.getOriginalFilename();
	            if (originalFilename != null && !originalFilename.isEmpty()) {
	                File destinationFile = new File(path + File.separator + originalFilename);
	                file.transferTo(destinationFile);
	                timg.append(originalFilename).append("/");
	            }
	        }
	        
	    timg = new StringBuilder(timg.toString().replace("null/", ""));
		
		String userid=session.getAttribute("userid").toString();
		String delimg=request.getParameter("delimg");
        String safeimg = request.getParameter("safeimg");
		
		String[] delfile=delimg.split("/");
		for(int i=0;i<delfile.length;i++) {
			File file=new File(path+"/"+delfile[i]);
			if(file.exists())
				file.delete();
		}
		
		timg.insert(0, safeimg);
		
		int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
		
		TourDto tdto=new TourDto();
		tdto.setId(id);
		tdto.setTimg(timg);
		tdto.setTitle(title);
		tdto.setContent(content);
		tdto.setTimg(timg.toString());
		
		TourMapper tdao=sqlSession.getMapper(TourMapper.class);
		tdao.updateOk(tdto);
	
		return "redirect:/tour/content?id="+id;
	}
	
	@RequestMapping("/tour/delete")
	public String delete(HttpServletRequest request) {
		String id=request.getParameter("id");
		
		TourMapper tdao=sqlSession.getMapper(TourMapper.class);
		
		String path = request.getServletContext().getRealPath("resources/tour");
		
		String timg=tdao.getTimg(id);
		String[] imgs=timg.split("/");
		
		for(int i=0;i<imgs.length;i++) {
			File file=new File(path+"/"+imgs[i]);
			if(file.exists())
				file.delete();	
		}
		
		tdao.delete(id);
		
		return "redirect:/tour/list";
	}
	
} // 클래스 끝