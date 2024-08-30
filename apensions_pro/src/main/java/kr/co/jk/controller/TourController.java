package kr.co.jk.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dao.TourDao;
import kr.co.jk.dto.TourDto;


@Controller
public class TourController {

    @Autowired
    private SqlSession sqlSession;
    
    @Autowired
    private ServletContext servletContext;
    
    @RequestMapping("/tour/list")
    public String list(Model model) {
        TourDao tdao = sqlSession.getMapper(TourDao.class);
        ArrayList<TourDto> tlist = tdao.list();
        model.addAttribute("tlist", tlist);
        return "/tour/list";
    }
    
    @RequestMapping("/tour/write")
    public String write() {
        return "/tour/write";
    }
    
    @RequestMapping("/tour/writeOk")
    public String writeOk(MultipartHttpServletRequest request, HttpSession session) throws Exception {
        String path = servletContext.getRealPath("/resources/tour");
        int size = 1024 * 1024 * 30;
        
        List<MultipartFile> files = request.getFiles("file");
        StringBuilder timg = new StringBuilder();
        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                String filename = file.getOriginalFilename();
                file.transferTo(new File(path, filename));
                timg.append(filename).append("/");
            }
        }
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String userid = (String) session.getAttribute("userid");
        
        TourDto tdto = new TourDto();
        tdto.setTimg(timg.toString().replace("null/", ""));
        tdto.setTitle(title);
        tdto.setContent(content);
        tdto.setUserid(userid);
        
        TourDao tdao = sqlSession.getMapper(TourDao.class);
        tdao.writeOk(tdto);
        
        return "redirect:/tour/list";
    }
    
    @RequestMapping("/tour/readnum")
    public String readnum(HttpServletRequest request, HttpSession session) {
        String id = request.getParameter("id");
        TourDao tdao = sqlSession.getMapper(TourDao.class);
        if (session.getAttribute("userid") == null) {
            tdao.readnum(id);
        } else {
            String userid = (String) session.getAttribute("userid");
            if (!tdao.isWriter(id, userid)) {
                tdao.readnum(id);
            }
        }
        return "redirect:/tour/content?id=" + id;
    }
    
    @RequestMapping("/tour/content")
    public String content(HttpServletRequest request, Model model) {
        String id = request.getParameter("id");
        TourDao tdao = sqlSession.getMapper(TourDao.class);
        TourDto tdto = tdao.content(id);
        
        tdto.setContent(tdto.getContent().replace("\r\n", "<br>"));
        model.addAttribute("tdto", tdto);
        
        String writer = tdao.getName(tdto.getUserid());
        model.addAttribute("writer", writer);
        
        String[] timg = tdto.getTimg().split("/");
        model.addAttribute("timg", timg);
        
        return "/tour/content";
    }
    
    @RequestMapping("/tour/update")
    public String update(HttpServletRequest request, Model model) {
        String id = request.getParameter("id");
        TourDao tdao = sqlSession.getMapper(TourDao.class);
        TourDto tdto = tdao.content(id);
        
        String[] timg = tdto.getTimg().split("/");
        model.addAttribute("timg", timg);
        model.addAttribute("tdto", tdto);
        
        return "/tour/update";
    }
    
    @RequestMapping("/tour/updateOk")
    public String updateOk(MultipartHttpServletRequest request, HttpSession session) throws Exception {
        String path = servletContext.getRealPath("/resources/tour");
        List<MultipartFile> files = request.getFiles("file");
        StringBuilder timg = new StringBuilder();
        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                String filename = file.getOriginalFilename();
                file.transferTo(new File(path, filename));
                timg.append(filename).append("/");
            }
        }
        String delimg = request.getParameter("delimg");
        String[] delfile = delimg.split("/");
        for (String file : delfile) {
            File f = new File(path + "/" + file);
            if (f.exists()) f.delete();
        }
        String safeimg = request.getParameter("safeimg");
        timg.append(safeimg);
        
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String userid = (String) session.getAttribute("userid");
        
        TourDto tdto = new TourDto();
        tdto.setId(id);
        tdto.setTimg(timg.toString().replace("null/", ""));
        tdto.setTitle(title);
        tdto.setContent(content);
        
        TourDao tdao = sqlSession.getMapper(TourDao.class);
        tdao.updateOk(tdto);
    
        return "redirect:/tour/content?id=" + id;
    }
    
    @RequestMapping("/tour/delete")
    public String delete(HttpServletRequest request) {
        String id = request.getParameter("id");
        TourDao tdao = sqlSession.getMapper(TourDao.class);
        
        String path = servletContext.getRealPath("/resources/tour");
        String timg = tdao.getTimg(id);
        String[] imgs = timg.split("/");
        
        for (String img : imgs) {
            File file = new File(path + "/" + img);
            if (file.exists()) file.delete();    
        }
        
        tdao.delete(id);
        
        return "redirect:/tour/list";
    }
}