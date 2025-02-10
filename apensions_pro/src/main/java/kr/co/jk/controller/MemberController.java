package kr.co.jk.controller;

import java.util.List;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dao.MemberDao;
import kr.co.jk.dto.InquiryDto;
import kr.co.jk.dto.MemberDto;
import kr.co.jk.dto.ReserveDto;
import kr.co.jk.dto.TourDto;
import kr.co.jk.util.Utils;

@Controller
public class MemberController {
    
	@Autowired
	private SqlSession sqlSession;
	
	@GetMapping("/")
	public String home() {
		return "redirect:/main/index";
	}
	
	@GetMapping("/main/index")
	public String index(Model model, HttpSession session, HttpServletRequest request) {
		String stateParam = request.getParameter("state");
	    
		if(session.getAttribute("userid")==null||!session.getAttribute("userid").toString().equals("admin")) {
			MemberDao mdao=sqlSession.getMapper(MemberDao.class);
			// 공지사항 5개
			model.addAttribute("glist" ,mdao.getGongji());
			// 게시판 5개
			model.addAttribute("blist" ,mdao.getBoard());
			// 여행후기 5개
	   	    List<TourDto> tlist=mdao.getTour();
			model.addAttribute("tlist" ,tlist);
			
			if (stateParam != null) {
				int state = Integer.parseInt(stateParam);
				model.addAttribute("state", state);
			}
			
			return "/main/index";
		}
		else {
			return "redirect:/adminRoom/index";
		}
	}
	
	@GetMapping("/member/member")
	public String member() {
		return "/member/member";
	}
	
	@GetMapping("/member/dupCheck")
	public @ResponseBody String dupCheck(HttpServletRequest request) {
	    String userid=request.getParameter("userid");
	    
	    MemberDao mdao=sqlSession.getMapper(MemberDao.class);
	    return mdao.dupCheck(userid);
	}
	
	@PostMapping("/member/memberOk")
	public String memberOk(MemberDto mdto) {
		MemberDao mdao=sqlSession.getMapper(MemberDao.class);
		mdao.memberOk(mdto);
		
		return "redirect:/member/login";
	}
	
	@GetMapping("/member/login")
	public String login(HttpServletRequest request, Model model) {
		String err=request.getParameter("err");
	    model.addAttribute("err",err);
	    
	    if(request.getParameter("year")!=null) {
		    int year=Integer.parseInt(request.getParameter("year"));
			int month=Integer.parseInt(request.getParameter("month"));
			int day=Integer.parseInt(request.getParameter("day"));
			int id=Integer.parseInt(request.getParameter("id"));
			
			model.addAttribute("year", year);
			model.addAttribute("month", month);
			model.addAttribute("day", day);
			model.addAttribute("id", id);
	    }
	    
		return "/member/login";
	}
	
	@PostMapping("/member/loginOk")
	public String loginOk(MemberDto mdto, HttpSession session, HttpServletRequest request, Model model) {
		MemberDao mdao=sqlSession.getMapper(MemberDao.class);
		MemberDto member=mdao.loginOk(mdto);
				
		if(member!=null) {
			session.setAttribute("userid", mdto.getUserid());
			session.setAttribute("name", member.getName());
            session.setAttribute("state", member.getState());
            
			if(request.getParameter("year")==null) {
				
	            
				if(session.getAttribute("userid").equals("admin")) {
					return "redirect:/adminRoom/index";
				}
				else {
					return "redirect:/main/index";
				}
			}
			else {
				int year=Integer.parseInt(request.getParameter("year"));
				int month=Integer.parseInt(request.getParameter("month"));
				int day=Integer.parseInt(request.getParameter("day"));
				int id=Integer.parseInt(request.getParameter("id"));
				
				return "redirect:/reserve/reserveNext?year="+year+"&month="+month+"&day="+day+"&id="+id;
			}
		}
		else {
			return "redirect:/member/login?err=1";
		}
	}
	
	@GetMapping("/member/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/main/index";
	}
	
	@GetMapping("/member/usForm")
	public String usForm() {
		return "/member/usForm";
	}
	
	@GetMapping("/member/useridSearch")
	public String useridSearch(MemberDto mdto, Model model) {
		MemberDao mdao=sqlSession.getMapper(MemberDao.class);
		String userid=mdao.useridSearch(mdto);
		
		model.addAttribute("userid",userid);
		
		return "/member/useridSearch";
	}
	
	@GetMapping("/member/psForm")
	public String psForm() {
		return "/member/psForm";
	}
	
	@GetMapping("/member/pwdSearch")
	public String pwdSearch(MemberDto mdto, Model model) {
		MemberDao mdao=sqlSession.getMapper(MemberDao.class);
		String pwd=mdao.pwdSearch(mdto);
		
		model.addAttribute("pwd",pwd);
		return "/member/pwdSearch";
	}
	
	@GetMapping("/member/reForm")
	public String reForm() {
		return "/member/reForm";
	}
	
	@GetMapping("/member/reMember")
	public String reMember(MemberDto mdto, Model model) {
		MemberDao mdao = sqlSession.getMapper(MemberDao.class);
		
		int updateCount = mdao.reMember(mdto); // 업데이트 실행
		System.out.println("Update count: " + updateCount); // 디버깅 로그
		
		if (updateCount > 0) {
			model.addAttribute("msg", "업데이트 성공!");
		}
		else {
			model.addAttribute("err", "업데이트에 실패했습니다.");
		}
		
		return "/member/reMember";
	}
	
	@GetMapping("/member/memberView")
	public String memberView(HttpSession session, Model model) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/member/login";
		}
		else {
			String userid=session.getAttribute("userid").toString();
			
			MemberDao mdao=sqlSession.getMapper(MemberDao.class);
			MemberDto mdto=mdao.memberView(userid);
			
			model.addAttribute("mdto",mdto);
			
			return "/member/memberView";
		}
	}
	
	@GetMapping("/member/emailEdit")
	public String emailEdit(HttpServletRequest request, HttpSession session) {
		String email=request.getParameter("email");
		String userid=session.getAttribute("userid").toString();
		
		MemberDao mdao=sqlSession.getMapper(MemberDao.class);
		mdao.emailEdit(email, userid);
		
		return "redirect:/member/memberView";
	}
	
	@GetMapping("/member/phoneEdit")
	public String phoneEdit(HttpServletRequest request, HttpSession session) {
		String userid=session.getAttribute("userid").toString();
		String phone=request.getParameter("phone");
		
		MemberDao mdao=sqlSession.getMapper(MemberDao.class);
		mdao.phoneEdit(phone,userid);
		
		return "redirect:/member/memberView";
	}
	
	@GetMapping("/member/pwdChg")
	public String pwdChg(HttpServletRequest request, HttpSession session) {
		String oldPwd=request.getParameter("oldPwd");
		String pwd=request.getParameter("pwd");
		String userid=session.getAttribute("userid").toString();
		
		MemberDao mdao=sqlSession.getMapper(MemberDao.class);
		if(mdao.isPwd(oldPwd, userid)) {
			mdao.pwdChg(pwd,userid);
			return "redirect:/member/memberView";
		}
		else {
			return "redirect:/member/memberView?err=1";
		}
	}
	
	@GetMapping("/member/myWrite")
	public String myWrite(HttpSession session, Model model) {
		if(session.getAttribute("userid")!=null) {
			String userid=session.getAttribute("userid").toString();
			MemberDao mdao=sqlSession.getMapper(MemberDao.class);
			
			List<InquiryDto> ilist=mdao.getInquirys(userid);
			
			for(int i=0;i<ilist.size();i++) {
				InquiryDto idto=ilist.get(i);
				switch(idto.getTitle()) {
					case 0: idto.setTitle2("펜션예약 관련문의"); break;
					case 1: idto.setTitle2("입/퇴실 관련문의"); break;
					case 2: idto.setTitle2("주변맛집 관련문의"); break;
					case 3: idto.setTitle2("웹사이트 관련문의"); break;
					case 4: idto.setTitle2("커뮤니티 관련문의"); break;
					default: idto.setTitle2("");
				}
				
				if(idto.getState()==0) {
					idto.setAnswer("답변 대기중");
				}
				else {
					String answer=idto.getAnswer().replace("\r\n", "<br>");
					idto.setAnswer(answer);
				}
				
				String content=idto.getContent().replace("\r\n", "<br>");
				idto.setContent(content);
			}
			
			model.addAttribute("ilist", ilist);
			
			return "/member/myWrite";
		}
		else {
			return "redirect:/member/login";
		}
	}
	
	@SuppressWarnings("rawtypes")
	@GetMapping("/member/mapEx")
	public String mapEx(Model model) {
		MemberDao mdao=sqlSession.getMapper(MemberDao.class);
	
		List<HashMap> mapAll=mdao.getMembers2();
		model.addAttribute("mapAll",mapAll);
		return "/member/mapEx";
	}
	
	@GetMapping("/member/outMember")
	public String outMember(HttpSession session) {
		String userid=session.getAttribute("userid").toString();
		
		MemberDao mdao=sqlSession.getMapper(MemberDao.class);
		mdao.outMember(userid);
		
		session.invalidate();
				
		return "redirect:/main/index";
	}
	
	@GetMapping("/member/clsMember")
	public String clsMember(HttpSession session) {
		String userid=session.getAttribute("userid").toString();
		
		MemberDao mdao=sqlSession.getMapper(MemberDao.class);
		mdao.clsMember(userid);
				
		return "redirect:/main/index";
	}
	
	@GetMapping("/member/reserveList")
	public String reserveList(HttpSession session, Model model) {
		String userid=session.getAttribute("userid").toString();
		
		MemberDao mdao=sqlSession.getMapper(MemberDao.class);
		List<ReserveDto> rlist=mdao.reserveList(userid);
		
		for(int i=0;i<rlist.size();i++) {
			boolean chk=Utils.dayBefore(rlist.get(i).getOutday()); // 퇴실일
			System.out.println(chk);
		}
    	
		model.addAttribute("rlist", rlist);
		
		return "/member/reserveList";
    }
	
	@GetMapping("/adminRoom/cancelRe")
    public String cancelRe(HttpServletRequest request) {
		System.out.println("cancelRe");
		String id=request.getParameter("id");
		String state=request.getParameter("state");
		
		MemberDao mdao=sqlSession.getMapper(MemberDao.class);
		mdao.cancelRe(state,id);
		
		return "redirect:/adminRoom/reserveList";
    }
	
}