package kr.co.jk.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dto.BoardDto;
import kr.co.jk.dto.DatDto;
import kr.co.jk.mapper.BoardMapper;

@Controller
public class MyController {
    
    @Autowired
    private SqlSession sqlSession;
    
    private BoardMapper getBoardDao() {
        return sqlSession.getMapper(BoardMapper.class);
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
        BoardMapper mdao = getBoardDao();
        int chk = mdao.uidChk(uid);
        return chk + "";
    }
    
    @RequestMapping("/memberOk")
    public String memberOk(BoardDto mdto) {
        BoardMapper mdao = getBoardDao();
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
        BoardMapper mdao = getBoardDao();
        if (mdao.loginOk(bdto)) {
            session.setAttribute("uid", bdto.getUid());
            return "redirect:/list";
        } else {
            return "redirect:/login?err=1";
        }
    }
    
    @RequestMapping("/list")
    public String list(Model model, HttpServletRequest request, HttpSession session) {
        BoardMapper bdao = getBoardDao();
        String uid=session.getAttribute("uid").toString();
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
        String name = bdao.getUserNameByUid(uid);
        model.addAttribute("list", list);
        model.addAttribute("page", page);
        model.addAttribute("pstart", pstart);
        model.addAttribute("pend", pend);
        model.addAttribute("chong", chong);
        model.addAttribute("rec", rec);
        model.addAttribute("name", name);
        
        return "/list";
    }
    
    @RequestMapping("/write")
    public String write(Model model, HttpServletRequest request, HttpSession session) {
    	BoardMapper bdao = getBoardDao();
    	String uid=(String) session.getAttribute("uid");
        String name = bdao.getUserNameByUid(uid);
        model.addAttribute("name", name); // uid를 모델에 추가
        return "write";
    }

    
    @RequestMapping("/writeOk")
    public String writeOk(
            @RequestParam("uid") String uid,
            @RequestParam("title") String title,
            @RequestParam("name") String writer,
            @RequestParam("pwd") String pwd,
            @RequestParam("content") String content,
            @RequestParam("files") List<MultipartFile> files,
            HttpSession session) {

        String path = session.getServletContext().getRealPath("/resources/pich");
        StringBuilder rimg = new StringBuilder();

        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                String filename = file.getOriginalFilename();
                try {
                    // 파일 저장
                    File dest = new File(path, filename);
                    file.transferTo(dest);
                    rimg.append(filename).append("/");
                } catch (IOException e) {
                    e.printStackTrace();  // 예외 처리 (필요에 따라 수정 가능)
                }
            }
        }

        String rimgStr = rimg.toString().replace("null/", "");

        // DTO 객체 생성 및 데이터 설정
        BoardDto bdto = new BoardDto();
        bdto.setUid(uid);
        bdto.setRimg(rimgStr);
        bdto.setTitle(title);
        bdto.setWriter(writer);
        bdto.setPwd(pwd);
        bdto.setContent(content);

        // MyBatis 매퍼를 통해 데이터베이스에 데이터 저장
        BoardMapper bdao = sqlSession.getMapper(BoardMapper.class);
        bdao.writeOk(bdto);

        return "redirect:/list";
    }

    
    @RequestMapping("/rnum")
    public String rnum(HttpServletRequest request, HttpSession session, Model model) {
        String id = request.getParameter("id");
        String page = request.getParameter("page");
        String rec = request.getParameter("rec");
        
        String uid= session.getAttribute("uid").toString();
        
        BoardMapper bdao = getBoardDao();
        
        String name = bdao.getUserNameByUid(uid);
        model.addAttribute("name", name);
        model.addAttribute("uid", uid);
        bdao.rnum(id);
        
        return "redirect:/content?id=" + id + "&page=" + page + "&rec=" + rec;
    }
    
    @RequestMapping("/content")
    public String content(HttpServletRequest request, Model model) {
        String id = request.getParameter("id");
        String page = request.getParameter("page");
        String rec = request.getParameter("rec");
        String name = request.getParameter("name");
        String uid = request.getParameter("uid");
                
        BoardMapper bdao = getBoardDao();
        BoardDto bdto = bdao.content(id);
        bdto.setContent(bdto.getContent().replace("\r\n", "<br>"));
        String[] imgs=bdto.getRimg().split("/");
        String wuid=bdto.getWuid();
        
        model.addAttribute("imgs", imgs);
        model.addAttribute("bdto", bdto);
        model.addAttribute("rec", rec);
        model.addAttribute("page", page);
        model.addAttribute("name", name);
        model.addAttribute("uid", uid);
        model.addAttribute("wuid", wuid);
        
        ArrayList<DatDto> dlist = bdao.dat(id);
        model.addAttribute("dlist", dlist);
        return "/content";
    }
    
    @RequestMapping("/update")
    public String update(HttpServletRequest request, Model model, HttpSession session) {
        String id = request.getParameter("id");
        String page = request.getParameter("page");
        String rec = request.getParameter("rec");
        
        BoardMapper bdao=sqlSession.getMapper(BoardMapper.class);
        BoardDto bdto = bdao.content(id);
        
        String[] imgs=bdto.getRimg().split("/");
        model.addAttribute("imgs", imgs);
        model.addAttribute("bdto", bdto);
        model.addAttribute("page", page);
        model.addAttribute("rec", rec);
        
        return "/update";
    }
    
    @RequestMapping("/updateOk")
    public String updateOk() {
    	return null;
    }
    
    @RequestMapping("/delete")
    public String delete(BoardDto bdto, HttpServletRequest request) {
        String page = request.getParameter("page");
        String rec = request.getParameter("rec");
        
        BoardMapper bdao = getBoardDao();
        
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
        
        BoardMapper bdao = getBoardDao();
        bdao.datOk(ddto);
        
        return "redirect:/content?id="+ddto.getBid()+"&page="+page+"&rec="+rec;
    }
    
    @RequestMapping("/datUp")
    public @ResponseBody DatDto datUp(String id, HttpServletRequest request) {
    	String page = request.getParameter("page");
        String rec = request.getParameter("rec");
        BoardMapper bdao = getBoardDao();
        DatDto ddto = bdao.datUp(id);
        return ddto;
    }
    
    @RequestMapping("/datupOk")
    public String datupOk(DatDto ddto, BoardDto bdto, HttpServletRequest request) {
    	String page = request.getParameter("page");
        String rec = request.getParameter("rec");
        BoardMapper bdao = getBoardDao();
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
        BoardMapper bdao = getBoardDao();
        if (bdao.isdatPwd(ddto.getId(), ddto.getPwd())) {
            bdao.datDel(ddto);
            return "redirect:/content?id="+ddto.getBid()+"&page="+page+"&rec="+rec;
        }
        else {
            return "redirect:/content?err=1&id="+ddto.getBid()+"&page="+page+"&rec="+rec;	
        }
    }
}