package kr.co.jk.controller;

import java.time.LocalDate;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.jk.dto.InquiryDto;
import kr.co.jk.mapper.InquiryMapper;

@Controller
public class InquiryController {
    @Autowired
    private SqlSession sqlSession;
    
    @RequestMapping("/inquiry/write")
    public String write(HttpServletRequest request, Model model)
    {
    	model.addAttribute("err", request.getParameter("err"));
    	return "/inquiry/write";
    }
    
    @RequestMapping("/inquiry/writeOk")
    public String writeOk(InquiryDto idto, HttpSession session)
    {
    	InquiryMapper idao=sqlSession.getMapper(InquiryMapper.class);
    	
    	String userid,inum="";
    	LocalDate today=LocalDate.now();
		String year=today.getYear()+"";
		year=year.substring(2);
		int month=today.getMonthValue();
		String month2=String.format("%02d", month);
		
		int day=today.getDayOfMonth();
		String day2=String.format("%02d", day);
		
		inum="m"+year+month2+day2;
		
		int num=idao.getNumber(inum)+1; 
		inum=inum+String.format("%03d",num);
    	if(session.getAttribute("userid")==null)
    	{
    		userid="guest";
    	}
    	else
    	{
    	    userid=session.getAttribute("userid").toString();	
    	}
    	
    	idto.setUserid(userid);
    	idto.setInqNumber(inum);
    	
    	idao.writeOk(idto);
    	
    	return "/inquiry/writeOk";
    }
    
    @RequestMapping("/inquiry/nonMemberView")
    public String nonMemberView(HttpServletRequest request,
    		Model model)
    {
        String inqNumber=request.getParameter("inqNumber");
        
        InquiryMapper idao=sqlSession.getMapper(InquiryMapper.class);
        InquiryDto idto=idao.getInquiry(inqNumber);
        
        if(idto==null)
        {
        	return "redirect:/inquiry/write?err=1";
        }
        else
        {
	        switch( idto.getTitle() )
	    	{    
	    	    case 0: idto.setTitle2("펜션예약 관련문의"); break;
	    	    case 1: idto.setTitle2("입실퇴실 관련문의"); break;
	    	    case 2: idto.setTitle2("주변맛집 관련문의"); break;
	    	    case 3: idto.setTitle2("웹사이트 관련문의"); break;
	    	    case 4: idto.setTitle2("커뮤니티 관련문의"); break;
	    	    default: idto.setTitle2("");
	    	}
	        
	        String content=idto.getContent().replace("\r\n", "<br>");
	        idto.setContent(content);
	        
	        if(idto.getState()==0)
	        {
	        	idto.setAnswer("답변 대기중");
	        }
	        else
	        {
	            String answer=idto.getAnswer().replace("\r\n", "<br>");
	            idto.setAnswer(answer);
	        }
	        
	        model.addAttribute("idto",idto);
	        
	        return "/inquiry/nonMemberView";
        }
    }
}