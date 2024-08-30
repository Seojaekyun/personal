package kr.co.pension.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.pension.dao.TourDao;
import kr.co.pension.dto.TourDto;

@Controller
public class TourController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/tour/list")
	public String list(Model model) {
		TourDao tdao=sqlSession.getMapper(TourDao.class);
		ArrayList<TourDto> tlist=tdao.list();
		
		model.addAttribute("tlist",tlist);
		
		return "/tour/list";
	}
	
	@RequestMapping("/tour/write")
	public String write() {
		return "/tour/write";
	}
	
	@RequestMapping("/tour/writeOk")
	public String writeOk(HttpServletRequest request, HttpSession session) throws Exception {
		String path=request.getRealPath("resources/tour");
		int size=1024*1024*30;
		
		MultipartRequest multi=new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		
		Enumeration files=multi.getFileNames(); // type="file"의 name을 다 가져온다.
		String timg="";
		while(files.hasMoreElements()) {
			String fname=files.nextElement().toString(); // 하나의 type="file"의 name
			timg=timg+multi.getFilesystemName(fname)+"/";
		}
		timg=timg.replace("null/", "");
		
		String title=multi.getParameter("title");
		String content=multi.getParameter("content");
		String userid=session.getAttribute("userid").toString();
		
		TourDto tdto=new TourDto();
		tdto.setTimg(timg);
		tdto.setTitle(title);
		tdto.setContent(content);
		tdto.setUserid(userid);
		
		TourDao tdao=sqlSession.getMapper(TourDao.class);
		tdao.writeOk(tdto);
		
		return "redirect:/tour/list";
	}
	
	@RequestMapping("/tour/readnum")
	public String readnum(HttpServletRequest request, HttpSession session) {
		String id=request.getParameter("id");
		TourDao tdao=sqlSession.getMapper(TourDao.class);
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
		
		TourDao tdao=sqlSession.getMapper(TourDao.class);
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
		TourDao tdao=sqlSession.getMapper(TourDao.class);
		TourDto tdto=tdao.content(id);
		
		String[] timg=tdto.getTimg().split("/");
		model.addAttribute("timg", timg);
		model.addAttribute("tdto", tdto);
		
		return "/tour/update";
	}
	
	@RequestMapping("/tour/updateOk")
	public String updateOk(HttpServletRequest request, HttpSession session) throws Exception {
		String path=request.getRealPath("resources/tour");
		int size=1024*1024*30;
		
		MultipartRequest multi=new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		
		Enumeration files=multi.getFileNames();
		String timg="";
		while(files.hasMoreElements()) {
			String fname=files.nextElement().toString();
			timg=timg+multi.getFilesystemName(fname)+"/";
		}
		
		timg=timg.replace("null/", "");
		int id=Integer.parseInt(multi.getParameter("id"));
		String title=multi.getParameter("title");
		String content=multi.getParameter("content");
		String userid=session.getAttribute("userid").toString();
		String delimg=multi.getParameter("delimg");
		
		String[] delfile=delimg.split("/");
		for(int i=0;i<delfile.length;i++) {
			File file=new File(path+"/"+delfile[i]);
			if(file.exists())
				file.delete();
		}
		
		String safeimg=multi.getParameter("safeimg");
		timg=timg+safeimg;
		
		TourDto tdto=new TourDto();
		tdto.setId(id);
		tdto.setTimg(timg);
		tdto.setTitle(title);
		tdto.setContent(content);
		
		TourDao tdao=sqlSession.getMapper(TourDao.class);
		tdao.updateOk(tdto);
	
		return "redirect:/tour/content?id="+id;
	}
	
	@RequestMapping("/tour/delete")
	public String delete(HttpServletRequest request) {
		String id=request.getParameter("id");
		
		TourDao tdao=sqlSession.getMapper(TourDao.class);
		
		String path=request.getRealPath("resources/tour");
		
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