package kr.co.jk.controller;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.pension.dao.BoardDao;
import kr.co.pension.dto.BoardDto;

@Controller
public class BoardController {
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/board/list")
	public String list(Model model) {
		BoardDao bdao=sqlSession.getMapper(BoardDao.class);
		ArrayList<BoardDto> blist=bdao.list();
		model.addAttribute("blist",blist);
		
		return "/board/list";
	}
	
	@RequestMapping("/board/write")
	public String write() {
		return "/board/write";
	}
	
	@RequestMapping("/board/writeOk")
	public String writeOk(BoardDto bdto, HttpSession session) {
		String userid=session.getAttribute("userid").toString();
		
		// dto에 userid값을 넣기
		bdto.setUserid(userid);
		
		BoardDao bdao=sqlSession.getMapper(BoardDao.class);
		bdao.writeOk(bdto);
		
		return "redirect:/board/list";
	}
	
	@RequestMapping("/board/readnum")
	public String readnum(HttpServletRequest request, HttpSession session) {
		String id=request.getParameter("id");
		BoardDao bdao=sqlSession.getMapper(BoardDao.class);
		
		// 로그인 하지 않은사람
		if(session.getAttribute("userid")==null) {
			bdao.readnum(id);
		}
		else {
			String userid=session.getAttribute("userid").toString();
			if(!bdao.isWriter(id, userid)) {
				bdao.readnum(id);
			}
		}
		return "redirect:/board/content?id="+id;
	}
    
    @RequestMapping("/board/content")
    public String content(HttpServletRequest request, Model model) {
    	String id=request.getParameter("id");
    	
    	BoardDao bdao=sqlSession.getMapper(BoardDao.class);
        BoardDto bdto=bdao.content(id);
       
        bdto.setContent(bdto.getContent().replace("\r\n", "<br>"));
        
        model.addAttribute("bdto",bdto);
        
        String writer=bdao.getName(bdto.getUserid());
        model.addAttribute("writer",writer);
        
    	return "/board/content";
    }
    
    @RequestMapping("/board/delete")
    public String delete(HttpServletRequest request) {
        String id=request.getParameter("id");
        
        BoardDao bdao=sqlSession.getMapper(BoardDao.class);
        bdao.delete(id);
        
        return "redirect:/board/list";
    }
    
    @RequestMapping("/board/update")
    public String update(HttpServletRequest request, Model model) {
        String id=request.getParameter("id");
        
        BoardDao bdao=sqlSession.getMapper(BoardDao.class);
        BoardDto bdto=bdao.content(id);
        
        model.addAttribute("bdto",bdto);
        
        return "/board/update";
    }
    
    @RequestMapping("/board/updateOk")
    public String updateOk(BoardDto bdto) {
    	BoardDao bdao=sqlSession.getMapper(BoardDao.class);
    	bdao.updateOk(bdto);
    	
    	return "redirect:/board/content?id="+bdto.getId();
    }
}







