package kr.co.jk.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartRequest;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.pension.dao.AdminDao;
import kr.co.pension.dao.MemberDao;
import kr.co.pension.dto.InquiryDto;
import kr.co.pension.dto.MemberDto;
import kr.co.pension.dto.ReserveDto;
import kr.co.pension.dto.RoomDto;
import kr.co.pension.util.Utils;

@Controller
public class AdminController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/adminRoom/index")
	public String index(HttpSession session) {
		if(session.getAttribute("userid")==null||!session.getAttribute("userid").toString().equals("admin")) {
			return "redirect:/member/login";
		}
		else {
			return "/adminRoom/index";
		}
	}
	
	@RequestMapping("/adminRoom/list")
	public String list(Model model)
	{
		AdminDao adao=sqlSession.getMapper(AdminDao.class);
		ArrayList<RoomDto> rlist=adao.list();
		
		// ArrayList에 요소로 저장된 dto의 값을 수정
		for(int i=0;i<rlist.size();i++)
		{
			RoomDto rdto=rlist.get(i);
			String price2=Utils.comma(rdto.getPrice());
			rdto.setPrice2(price2);
		}
		
		model.addAttribute("rlist",rlist);
		
		return "/adminRoom/list";
	}
	@RequestMapping("/adminRoom/write")
	public String write()
	{
		return "/adminRoom/write";
	}
	
	@RequestMapping("/adminRoom/writeOk")
	public String writeOk(HttpServletRequest request) throws Exception
	{
	    // System.out.println(rdto.getTitle());
		String path=request.getRealPath("resources/room");
		int size=1024*1024*30;
		MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());
		
		// 업로드한 파일을  /를 구분자로 하여 문자열로 만들기
		// 폼태그의 name을 가져오는 메소드를 이용하여 처리
		Enumeration files=multi.getFileNames(); // type="file" name="???"을 알아야 저장된 파일명을 확인
		
		String rimg="";
		while(files.hasMoreElements())
		{
			// 저장된 파일이름을 가져오겠다..  => multi.getFilesystemName("이름")
			String name=files.nextElement().toString(); // type="file"에서의 name의 값		
			//System.out.print(name+" : ");
			//System.out.println(multi.getFilesystemName(name));
			rimg=multi.getFilesystemName(name)+"/"+rimg;
		}
		//System.out.println(rimg);
		rimg=rimg.replace("null/", "");
		//System.out.println(rimg);
		
		// 폼에 입력값 가져오기
		String title=multi.getParameter("title");
		int min=Integer.parseInt( multi.getParameter("min") );
		int max=Integer.parseInt( multi.getParameter("max") );
		int price=Integer.parseInt( multi.getParameter("price") );
		String content=multi.getParameter("content");
		
		RoomDto rdto=new RoomDto();
		rdto.setTitle(title);
		rdto.setMin(min);
		rdto.setMax(max);
		rdto.setPrice(price);
		rdto.setContent(content);
		rdto.setRimg(rimg);
		
		AdminDao adao=sqlSession.getMapper(AdminDao.class);
		adao.writeOk(rdto);
		
		return "redirect:/adminRoom/list";
	}
	
	@RequestMapping("/adminRoom/content")
	public String content(HttpServletRequest request,
			Model model)
	{
	    String id=request.getParameter("id");
	    
	    AdminDao adao=sqlSession.getMapper(AdminDao.class);
	    RoomDto rdto=adao.content(id);
	    rdto.setContent(rdto.getContent().replace("\r\n","<br>"));
	    
	    String price2=Utils.comma(rdto.getPrice());
	    rdto.setPrice2(price2);
	    
	    // rimg필드의 값에서  '/'를 구분자하여 그림파일명을 나누다
	    String[] imgs=rdto.getRimg().split("/");  // a.jfif/l.jfif/n.jfif/
	    rdto.setImgs(imgs); // rdto에 포함
	    
	    // 따로 보내도 된다.
	    model.addAttribute("imgs",imgs);
	   	    
	    model.addAttribute("rdto",rdto);
	    return "/adminRoom/content";
	}
	
	@RequestMapping("/adminRoom/delete")
	public String delete(HttpServletRequest request)
	{
	    String id=request.getParameter("id");
	    
	    AdminDao adao=sqlSession.getMapper(AdminDao.class);
	   	    
	    // 삭제하는 레코드의 사진파일을 삭제하기
	    String path=request.getRealPath("resources/room");
	    
	    // 삭제하기 위한 그림파일명을 가져오기
	    String rimg=adao.getRimg(id);
	    String[] imgs=rimg.split("/");
	    
	    for(int i=0;i<imgs.length;i++)
	    {
	    	File file=new File(path+"/"+imgs[i]);
		    if(file.exists())
		    	file.delete();
	    }
	    // 삭제하기
	    adao.delete(id);
	    
	    return "redirect:/adminRoom/list";
	}
	
	@RequestMapping("/adminRoom/update")
	public String update(HttpServletRequest request,
			Model model)
	{
	    String id=request.getParameter("id");
	    AdminDao adao=sqlSession.getMapper(AdminDao.class);
	    RoomDto rdto=adao.content(id);
		
	    String[] imgs=rdto.getRimg().split("/");
	    model.addAttribute("imgs",imgs);
	    model.addAttribute("rdto",rdto);
		return "/adminRoom/update";
	}
	
	@RequestMapping("/adminRoom/updateOk")
	public String updateOk(HttpServletRequest request) throws Exception
	{
	    String path=request.getRealPath("resources/room");
	    int size=1024*1024*30;
	    
	    MultipartRequest multi=new MultipartRequest(request, path, size, "utf-8",new DefaultFileRenamePolicy());
	    
	    Enumeration files=multi.getFileNames(); // type="file" 태그의 name의 집합
	    
	    // 업로드한 파일을 문자열로 처리 =>  파일명/파일명/파일명/
	    String rimg=""; 
	    while(files.hasMoreElements())
	    {
	    	String name=files.nextElement().toString(); // type="file" 태그의 name
	    	rimg=rimg+multi.getFilesystemName(name)+"/";
	    }
	    
	    rimg=rimg.replace("null/", ""); // 새로 추가한 이미지 파일들
	    
	    String delimg=multi.getParameter("delimg");
	    String safeimg=multi.getParameter("safeimg");
	    // delimg에 있는 파일을 삭제
	    String[] delfile=delimg.split("/");
	    for(int i=0;i<delfile.length;i++)
	    {
	    	File file=new File(path+"/"+delfile[i]);
	    	
	    	if(file.exists())
	    		file.delete();
	    }
	    
	    // safeimg의 파일과 합쳐서 저장
	    rimg=safeimg+rimg;
	    int id=Integer.parseInt(multi.getParameter("id"));
	    String title=multi.getParameter("title");
	    int min=Integer.parseInt(multi.getParameter("min"));
	    int max=Integer.parseInt(multi.getParameter("max"));
	    int price=Integer.parseInt(multi.getParameter("price"));
	    String content=multi.getParameter("content");
	    
	    RoomDto rdto=new RoomDto();
	    rdto.setRimg(rimg);
	    rdto.setId(id);
	    rdto.setTitle(title);
	    rdto.setMax(max);
	    rdto.setMin(min);
	    rdto.setPrice(price);
	    rdto.setContent(content);
	    
	    AdminDao adao=sqlSession.getMapper(AdminDao.class);
	    adao.updateOk(rdto);
	    
	    return "redirect:/adminRoom/content?id="+id;
	}
	
	@RequestMapping("/adminRoom/inquiryList")
	public String inquiryList(HttpSession session, Model model)
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/member/login";
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			if(userid.equals("admin"))
			{
				AdminDao adao=sqlSession.getMapper(AdminDao.class);
				ArrayList<InquiryDto> ilist=adao.getInquirys();
				
				for(int i=0;i<ilist.size();i++)
				{
					InquiryDto idto=ilist.get(i);
					switch( idto.getTitle() )
	    	    	{
	    	    	    case 0: idto.setTitle2("펜션예약 관련문의"); break;
	    	    	    case 1: idto.setTitle2("입실퇴실 관련문의"); break;
	    	    	    case 2: idto.setTitle2("주변맛집 관련문의"); break;
	    	    	    case 3: idto.setTitle2("웹사이트 관련문의"); break;
	    	    	    case 4: idto.setTitle2("커뮤니티 관련문의"); break;
	    	    	    default: idto.setTitle2("");
	    	    	}
	    	    	
	    	    	if(idto.getState()==0)
	    	    	{
	    	    		idto.setAnswer("답변 대기중");
	    	    	}
	    	    	else
	    	    	{
	    	    		
	    	    	}
	    	    	
	    	    	String content=idto.getContent().replace("\r\n", "<br>");
	    	    	idto.setContent(content);
				}
				
				model.addAttribute("ilist",ilist);
				
				return "/adminRoom/inquiryList";
			}
			else
			{
				return "/main/index";
			}
		}
		
	}
	
	@RequestMapping("/adminRoom/inquiryOk")
	public String inquiryOk(InquiryDto idto)
	{
		AdminDao adao=sqlSession.getMapper(AdminDao.class);
		adao.inquiryOk(idto);
		
		return "redirect:/adminRoom/inquiryList";
	}
	
	@RequestMapping("/adminRoom/memberList")
	public String memberList(Model model) {
		AdminDao adao=sqlSession.getMapper(AdminDao.class);
		ArrayList<HashMap> mapAll=adao.memberList();
		
		model.addAttribute("mapAll", mapAll);
		
		return "/adminRoom/memberList";
	}
	
	@RequestMapping("/adminRoom/memberUp")
	public String memberUp(MemberDto mdto) {
		AdminDao adao=sqlSession.getMapper(AdminDao.class);
		adao.memberUp(mdto);
		
		return "redirect:/adminRoom/memberList";
	}
	
	@RequestMapping("/adminRoom/reserveList")
	public String reserveList(Model model) {
		AdminDao adao=sqlSession.getMapper(AdminDao.class);
		ArrayList<ReserveDto> rlist=adao.reserveList();
		
		model.addAttribute("rlist",rlist);
		
		return "/adminRoom/reserveList";
	}
	 
	
	// 연습용
	@RequestMapping("/adminRoom/chuga1")
	public String chuga1()
	{
		return "/adminRoom/chuga1";
	}
	@RequestMapping("/adminRoom/chuga2")
	public String chuga2()
	{
		return "/adminRoom/chuga2";
	}
	@RequestMapping("/adminRoom/chuga3")
	public String chuga3()
	{
		return "/adminRoom/chuga3";
	}
	@RequestMapping("/adminRoom/chuga4")
	public String chuga4()
	{
		return "/adminRoom/chuga4";
	}
}
