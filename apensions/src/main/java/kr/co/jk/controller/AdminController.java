package kr.co.jk.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.jk.dto.InquiryDto;
import kr.co.jk.dto.MemberDto;
import kr.co.jk.dto.ReserveDto;
import kr.co.jk.dto.RoomDto;
import kr.co.jk.mapper.AdminMapper;
import kr.co.jk.util.Utils;

@Controller
public class AdminController {

    @Autowired
    private SqlSession sqlSession;

    @RequestMapping("/adminRoom/index")
    public String index(HttpSession session) {
        if(session.getAttribute("userid") == null || !session.getAttribute("userid").toString().equals("admin")) {
            return "redirect:/member/login";
        } else {
            return "/adminRoom/index";
        }
    }

    @RequestMapping("/adminRoom/list")
    public String list(Model model) {
        AdminMapper adao = sqlSession.getMapper(AdminMapper.class);
        ArrayList<RoomDto> rlist = adao.list();

        // 가격 형식 수정
        for (RoomDto rdto : rlist) {
            String price2 = Utils.comma(rdto.getPrice());
            rdto.setPrice2(price2);
        }

        model.addAttribute("rlist", rlist);

        return "/adminRoom/list";
    }

    @RequestMapping("/adminRoom/write")
    public String write() {
        return "/adminRoom/write";
    }

    @PostMapping("/adminRoom/writeOk")
    public String writeOk(MultipartHttpServletRequest request) throws Exception {
        String path = request.getServletContext().getRealPath("/resources/room/");
        File dir = new File(path);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        List<MultipartFile> files = request.getFiles("file");
        StringBuilder rimg = new StringBuilder();

        for (MultipartFile file : files) {
            String originalFilename = file.getOriginalFilename();
            if (originalFilename != null && !originalFilename.isEmpty()) {
                File destinationFile = new File(path + File.separator + originalFilename);
                file.transferTo(destinationFile);
                rimg.append(originalFilename).append("/");
            }
        }

        String title = request.getParameter("title");
        int min = Integer.parseInt(request.getParameter("min"));
        int max = Integer.parseInt(request.getParameter("max"));
        int price = Integer.parseInt(request.getParameter("price"));
        String content = request.getParameter("content");

        RoomDto rdto = new RoomDto();
        rdto.setTitle(title);
        rdto.setMin(min);
        rdto.setMax(max);
        rdto.setPrice(price);
        rdto.setContent(content);
        rdto.setRimg(rimg.toString().replace("null/", ""));

        AdminMapper adao = sqlSession.getMapper(AdminMapper.class);
        adao.writeOk(rdto);

        return "redirect:/adminRoom/list";
    }

    @RequestMapping("/adminRoom/content")
    public String content(HttpServletRequest request, Model model) {
        String id = request.getParameter("id");

        AdminMapper adao = sqlSession.getMapper(AdminMapper.class);
        RoomDto rdto = adao.content(id);
        rdto.setContent(rdto.getContent().replace("\r\n", "<br>"));

        String price2 = Utils.comma(rdto.getPrice());
        rdto.setPrice2(price2);

        String[] imgs = rdto.getRimg().split("/");
        rdto.setImgs(imgs);

        model.addAttribute("imgs", imgs);
        model.addAttribute("rdto", rdto);

        return "/adminRoom/content";
    }

    @RequestMapping("/adminRoom/delete")
    public String delete(HttpServletRequest request) {
        String id = request.getParameter("id");

        AdminMapper adao = sqlSession.getMapper(AdminMapper.class);

        String path = request.getServletContext().getRealPath("/resources/room/");
        String rimg = adao.getRimg(id);
        String[] imgs = rimg.split("/");

        for (String img : imgs) {
            File file = new File(path + File.separator + img);
            if (file.exists()) {
                file.delete();
            }
        }

        adao.delete(id);

        return "redirect:/adminRoom/list";
    }

    @RequestMapping("/adminRoom/update")
    public String update(HttpServletRequest request, Model model) {
        String id = request.getParameter("id");
        AdminMapper adao = sqlSession.getMapper(AdminMapper.class);
        RoomDto rdto = adao.content(id);

        String[] imgs = rdto.getRimg().split("/");
        model.addAttribute("imgs", imgs);
        model.addAttribute("rdto", rdto);
        return "/adminRoom/update";
    }

    @PostMapping("/adminRoom/updateOk")
    public String updateOk(MultipartHttpServletRequest request) throws Exception {
        String path = request.getServletContext().getRealPath("/resources/room/");
        File dir = new File(path);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        List<MultipartFile> files = request.getFiles("file");
        StringBuilder rimg = new StringBuilder();

        for (MultipartFile file : files) {
            String originalFilename = file.getOriginalFilename();
            if (originalFilename != null && !originalFilename.isEmpty()) {
                File destinationFile = new File(path + File.separator + originalFilename);
                file.transferTo(destinationFile);
                rimg.append(originalFilename).append("/");
            }
        }

        rimg = new StringBuilder(rimg.toString().replace("null/", ""));

        String delimg = request.getParameter("delimg");
        String safeimg = request.getParameter("safeimg");

        String[] delfile = delimg.split("/");
        for (String fileToDelete : delfile) {
            File file = new File(path + File.separator + fileToDelete);
            if (file.exists()) {
                file.delete();
            }
        }

        rimg.insert(0, safeimg);

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        int min = Integer.parseInt(request.getParameter("min"));
        int max = Integer.parseInt(request.getParameter("max"));
        int price = Integer.parseInt(request.getParameter("price"));
        String content = request.getParameter("content");

        RoomDto rdto = new RoomDto();
        rdto.setRimg(rimg.toString());
        rdto.setId(id);
        rdto.setTitle(title);
        rdto.setMax(max);
        rdto.setMin(min);
        rdto.setPrice(price);
        rdto.setContent(content);

        AdminMapper adao = sqlSession.getMapper(AdminMapper.class);
        adao.updateOk(rdto);

        return "redirect:/adminRoom/content?id=" + id;
    }

    @RequestMapping("/adminRoom/inquiryList")
    public String inquiryList(HttpSession session, Model model) {
        if (session.getAttribute("userid") == null) {
            return "redirect:/member/login";
        } else {
            String userid = session.getAttribute("userid").toString();
            if (userid.equals("admin")) {
                AdminMapper adao = sqlSession.getMapper(AdminMapper.class);
                ArrayList<InquiryDto> ilist = adao.getInquirys();

                for (InquiryDto idto : ilist) {
                    switch (idto.getTitle()) {
                        case 0 -> idto.setTitle2("펜션예약 관련문의");
                        case 1 -> idto.setTitle2("입실퇴실 관련문의");
                        case 2 -> idto.setTitle2("주변맛집 관련문의");
                        case 3 -> idto.setTitle2("웹사이트 관련문의");
                        case 4 -> idto.setTitle2("커뮤니티 관련문의");
                        default -> idto.setTitle2("");
                    }

                    if (idto.getState() == 0) {
                        idto.setAnswer("답변 대기중");
                    }

                    String content = idto.getContent().replace("\r\n", "<br>");
                    idto.setContent(content);
                }

                model.addAttribute("ilist", ilist);

                return "/adminRoom/inquiryList";
            } else {
                return "/main/index";
            }
        }
    }

    @RequestMapping("/adminRoom/inquiryOk")
    public String inquiryOk(InquiryDto idto) {
        AdminMapper adao = sqlSession.getMapper(AdminMapper.class);
        adao.inquiryOk(idto);

        return "redirect:/adminRoom/inquiryList";
    }

    @RequestMapping("/adminRoom/memberList")
    public String memberList(Model model) {
        AdminMapper adao = sqlSession.getMapper(AdminMapper.class);
        ArrayList<HashMap> mapAll = adao.memberList();

        model.addAttribute("mapAll", mapAll);

        return "/adminRoom/memberList";
    }

    @RequestMapping("/adminRoom/memberUp")
    public String memberUp(MemberDto mdto) {
        AdminMapper adao = sqlSession.getMapper(AdminMapper.class);
        adao.memberUp(mdto);

        return "redirect:/adminRoom/memberList";
    }

    @RequestMapping("/adminRoom/reserveList")
    public String reserveList(Model model) {
        AdminMapper adao = sqlSession.getMapper(AdminMapper.class);
        ArrayList<ReserveDto> rlist = adao.reserveList();

        model.addAttribute("rlist", rlist);

        return "/adminRoom/reserveList";
    }

    // 연습용
    @RequestMapping("/adminRoom/chuga1")
    public String chuga1() {
        return "/adminRoom/chuga1";
    }

    @RequestMapping("/adminRoom/chuga2")
    public String chuga2() {
        return "/adminRoom/chuga2";
    }

    @RequestMapping("/adminRoom/chuga3")
    public String chuga3() {
        return "/adminRoom/chuga3";
    }

    @RequestMapping("/adminRoom/chuga4")
    public String chuga4() {
        return "/adminRoom/chuga4";
    }
}
