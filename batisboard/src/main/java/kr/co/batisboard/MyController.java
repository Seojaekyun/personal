package kr.co.batisboard;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class MyController {
    
    @Autowired
    private SqlSession sqlSession;
    
    private BoardDao getBoardDao() {
        return sqlSession.getMapper(BoardDao.class);
    }
    
    @RequestMapping("/")
    public String main() {
        return "redirect:/login";
    }
    
    @RequestMapping("/member")
    public String member() {
        return "/member";
    }
    
    @RequestMapping("/uidChk")
    public @ResponseBody String uidChk(String uid) {
        BoardDao mdao = getBoardDao();
        int chk = mdao.uidChk(uid);
        return chk + "";
    }
    
    @RequestMapping("/memberOk")
    public String memberOk(BoardDto mdto) {
        BoardDao mdao = getBoardDao();
        mdao.memberOk(mdto);
        return "redirect:/login";
    }
    
    @RequestMapping("/login")
    public String login(HttpServletRequest request, Model model) {
        String err = request.getParameter("err");
        model.addAttribute("err", err);
        return "/login";
    }
    
    @RequestMapping("/loginOk")
    public String loginOk(BoardDto bdto, HttpSession session) {
        BoardDao mdao = getBoardDao();
        if (mdao.loginOk(bdto)) {
            session.setAttribute("uid", bdto.getUid());
            return "redirect:/list";
        } else {
            return "redirect:/login?err=1";
        }
    }
    
    @RequestMapping("/list")
    public String list(Model model, HttpServletRequest request) {
        BoardDao bdao = getBoardDao();
        
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        
        int rec = 10;
        if (request.getParameter("rec") != null) {
            rec = Integer.parseInt(request.getParameter("rec"));
        }
        
        int pstart, pend, chong;
        chong = bdao.getChong(rec);
        pstart = ((page - 1) / 10) * 10 + 1;
        pend = pstart + 9;
        
        if (pend > chong) {
            pend = chong;
        }
        
        int index = (page - 1) * rec;
        ArrayList<BoardDto> list = bdao.list(index, rec);
        
        model.addAttribute("list", list);
        model.addAttribute("page", page);
        model.addAttribute("pstart", pstart);
        model.addAttribute("pend", pend);
        model.addAttribute("chong", chong);
        model.addAttribute("rec", rec);
        
        return "/list";
    }
    
    @RequestMapping("/write")
    public String write() {
        return "/write";
    }
        
    @RequestMapping("/writeOk")
    public String writeOk(HttpServletRequest request, BoardDto bdto) {
    	BoardDao bdao = getBoardDao();
        bdao.writeOk(bdto);
        return "redirect:/list";
    }
    
    @RequestMapping("/rnum")
    public String rnum(HttpServletRequest request) {
        String id = request.getParameter("id");
        String page = request.getParameter("page");
        String rec = request.getParameter("rec");
        
        BoardDao bdao = getBoardDao();
        bdao.rnum(id);
        
        return "redirect:/content?id=" + id + "&page=" + page + "&rec=" + rec;
    }
    
    @RequestMapping("/content")
    public String content(HttpServletRequest request, Model model) {
        String id = request.getParameter("id");
        String page = request.getParameter("page");
        String rec = request.getParameter("rec");
        
        BoardDao bdao = getBoardDao();
        BoardDto bdto = bdao.content(id);
        bdto.setContent(bdto.getContent().replace("\r\n", "<br>"));
        
        model.addAttribute("bdto", bdto);
        model.addAttribute("rec", rec);
        model.addAttribute("page", page);
        
        ArrayList<DatDto> dlist = bdao.dat(id);
        model.addAttribute("dlist", dlist);
        return "/content";
    }
    
    @RequestMapping("/update")
    public String update(HttpServletRequest request, Model model) {
        String id = request.getParameter("id");
        String page = request.getParameter("page");
        String rec = request.getParameter("rec");
        
        BoardDao bdao = getBoardDao();
        BoardDto bdto = bdao.update(id);
        
        model.addAttribute("bdto", bdto);
        model.addAttribute("page", page);
        model.addAttribute("rec", rec);
        
        return "/update";
    }
    
    @RequestMapping("/updateOk")
    public String updateOk(BoardDto bdto, HttpServletRequest request) {
        String page = request.getParameter("page");
        String rec = request.getParameter("rec");
        
        BoardDao bdao = getBoardDao();
        
        if (bdao.isPwd(bdto.getId(), bdto.getPwd())) {
            bdao.updateOk(bdto);
            return "redirect:/content?id=" + bdto.getId() + "&page=" + page + "&rec=" + rec;
        } else {
            return "redirect:/update?err=1&id=" + bdto.getId() + "&page=" + page + "&rec=" + rec;
        }
    }
    
    @RequestMapping("/delete")
    public String delete(BoardDto bdto, HttpServletRequest request) {
        String page = request.getParameter("page");
        String rec = request.getParameter("rec");
        
        BoardDao bdao = getBoardDao();
        
        if (bdao.isPwd(bdto.getId(), bdto.getPwd())) {
            bdao.delete(bdto);
            return "redirect:/list?page=" + page + "&rec=" + rec;
        } else {
            return "redirect:/content?id=" + bdto.getId() + "&page=" + page + "&rec=" + rec;
        }
    }
    
    @RequestMapping("/datOk")
    public String datOk(DatDto ddto, HttpServletRequest request) {
        String page = request.getParameter("page");
        String rec = request.getParameter("rec");
        
        BoardDao bdao = getBoardDao();
        bdao.datOk(ddto);
        
        return "redirect:/content?id="+ddto.getBid()+"&page="+page+"&rec="+rec;
    }
    
    @RequestMapping("/datUp")
    public @ResponseBody DatDto datUp(String id, HttpServletRequest request) {
    	String page = request.getParameter("page");
        String rec = request.getParameter("rec");
        BoardDao bdao = getBoardDao();
        DatDto ddto = bdao.datUp(id);
        return ddto;
    }
    
    @RequestMapping("/datupOk")
    public String datupOk(DatDto ddto, BoardDto bdto, HttpServletRequest request) {
    	String page = request.getParameter("page");
        String rec = request.getParameter("rec");
        BoardDao bdao = getBoardDao();
        if (bdao.isdatPwd(ddto.getId(), ddto.getPwd())) {
            bdao.datupOk(ddto);
            return "redirect:/content?id="+ddto.getBid()+"&page="+page+"&rec="+rec;
        }
        else {
            return "redirect:/content?err=1&id="+ddto.getBid()+"&page="+page+"&rec="+rec;	
        }
    }
    @RequestMapping("/datDel")
    public String datDel(DatDto ddto, BoardDto bdto, HttpServletRequest request) {
    	String page = request.getParameter("page");
        String rec = request.getParameter("rec");
        BoardDao bdao = getBoardDao();
        if (bdao.isdatPwd(ddto.getId(), ddto.getPwd())) {
            bdao.datDel(ddto);
            return "redirect:/content?id="+ddto.getBid()+"&page="+page+"&rec="+rec;
        }
        else {
            return "redirect:/content?err=1&id="+ddto.getBid()+"&page="+page+"&rec="+rec;	
        }
    }
}