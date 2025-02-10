package kr.co.jk.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dao.AdminDao;
import kr.co.jk.dto.InquiryDto;
import kr.co.jk.dto.MemberDto;
import kr.co.jk.dto.ReserveDto;
import kr.co.jk.dto.RoomDto;
import kr.co.jk.util.Utils;

@Controller
public class AdminController {

    @Autowired
    private SqlSession sqlSession;

    @GetMapping("/adminRoom/index")
    public String index(HttpSession session) {
        if (session.getAttribute("userid") == null || !session.getAttribute("userid").toString().equals("admin")) {
            return "redirect:/member/login";
        } else {
            return "/adminRoom/index";
        }
    }

    @GetMapping("/adminRoom/list")
    public String list(Model model) {
        AdminDao adao = sqlSession.getMapper(AdminDao.class);
        List<RoomDto> rlist = adao.list();

        // ArrayList에 요소로 저장된 dto의 값을 수정
        for (RoomDto rdto : rlist) {
            String price2 = Utils.comma(rdto.getPrice());
            rdto.setPrice2(price2);
        }

        model.addAttribute("rlist", rlist);

        return "/adminRoom/list";
    }

    @GetMapping("/adminRoom/write")
    public String write() {
        return "/adminRoom/write";
    }

    @GetMapping("/adminRoom/writeOk")
    public String writeOk(
            @RequestParam String title,
            @RequestParam int min,
            @RequestParam int max,
            @RequestParam int price,
            @RequestParam String content,
            @RequestParam("file") List<MultipartFile> files,
            HttpSession session) {

        String path = session.getServletContext().getRealPath("/resources/room");
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
                    e.printStackTrace();
                }
            }
        }

        String rimgStr = rimg.toString().replace("null/", "");

        RoomDto rdto = new RoomDto();
        rdto.setTitle(title);
        rdto.setMin(min);
        rdto.setMax(max);
        rdto.setPrice(price);
        rdto.setContent(content);
        rdto.setRimg(rimgStr);

        AdminDao adao = sqlSession.getMapper(AdminDao.class);
        adao.writeOk(rdto);

        return "redirect:/adminRoom/list";
    }

    @GetMapping("/adminRoom/content")
    public String content(HttpServletRequest request, Model model) {
        String id = request.getParameter("id");

        AdminDao adao = sqlSession.getMapper(AdminDao.class);
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

    @GetMapping("/adminRoom/delete")
    public String delete(HttpServletRequest request, HttpSession session) {
        String id = request.getParameter("id");

        AdminDao adao = sqlSession.getMapper(AdminDao.class);

        String path = session.getServletContext().getRealPath("/resources/room");

        String rimg = adao.getRimg(id);
        String[] imgs = rimg.split("/");

        for (String img : imgs) {
            File file = new File(path + "/" + img);
            if (file.exists()) {
                file.delete();
            }
        }

        adao.delete(id);

        return "redirect:/adminRoom/list";
    }

    @GetMapping("/adminRoom/update")
    public String update(HttpServletRequest request, Model model) {
        String id = request.getParameter("id");
        AdminDao adao = sqlSession.getMapper(AdminDao.class);
        RoomDto rdto = adao.content(id);

        String[] imgs = rdto.getRimg().split("/");
        model.addAttribute("imgs", imgs);
        model.addAttribute("rdto", rdto);
        return "/adminRoom/update";
    }

    @GetMapping("/adminRoom/updateOk")
    public String updateOk(
            @RequestParam int id,
            @RequestParam String title,
            @RequestParam int min,
            @RequestParam int max,
            @RequestParam int price,
            @RequestParam String content,
            @RequestParam("file") List<MultipartFile> files,
            @RequestParam String safeimg,
            @RequestParam String delimg,
            HttpSession session) {

        String path = session.getServletContext().getRealPath("/resources/room");
        StringBuilder rimg = new StringBuilder();

        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                String filename = file.getOriginalFilename();
                try {
                    File dest = new File(path, filename);
                    file.transferTo(dest);
                    rimg.append(filename).append("/");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        String[] delfile = delimg.split("/");
        for (String filename : delfile) {
            File file = new File(path, filename);
            if (file.exists()) {
                file.delete();
            }
        }

        rimg.insert(0, safeimg);
        String rimgStr = rimg.toString().replace("null/", "");

        RoomDto rdto = new RoomDto();
        rdto.setRimg(rimgStr);
        rdto.setId(id);
        rdto.setTitle(title);
        rdto.setMax(max);
        rdto.setMin(min);
        rdto.setPrice(price);
        rdto.setContent(content);

        AdminDao adao = sqlSession.getMapper(AdminDao.class);
        adao.updateOk(rdto);

        return "redirect:/adminRoom/content?id=" + id;
    }

    @GetMapping("/adminRoom/inquiryList")
    public String inquiryList(HttpSession session, Model model) {
        if (session.getAttribute("userid") == null) {
            return "redirect:/member/login";
        } else {
            String userid = session.getAttribute("userid").toString();
            if (userid.equals("admin")) {
                AdminDao adao = sqlSession.getMapper(AdminDao.class);
                List<InquiryDto> ilist = adao.getInquirys();

                for (InquiryDto idto : ilist) {
                    switch (idto.getTitle()) {
                        case 0:
                            idto.setTitle2("펜션예약 관련문의");
                            break;
                        case 1:
                            idto.setTitle2("입실퇴실 관련문의");
                            break;
                        case 2:
                            idto.setTitle2("주변맛집 관련문의");
                            break;
                        case 3:
                            idto.setTitle2("웹사이트 관련문의");
                            break;
                        case 4:
                            idto.setTitle2("커뮤니티 관련문의");
                            break;
                        default:
                            idto.setTitle2("");
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

    @GetMapping("/adminRoom/inquiryOk")
    public String inquiryOk(InquiryDto idto) {
        AdminDao adao = sqlSession.getMapper(AdminDao.class);
        adao.inquiryOk(idto);

        return "redirect:/adminRoom/inquiryList";
    }

    @SuppressWarnings("rawtypes")
	@GetMapping("/adminRoom/memberList")
    public String memberList(Model model) {
        AdminDao adao = sqlSession.getMapper(AdminDao.class);
        List<HashMap> mapAll = adao.memberList();

        model.addAttribute("mapAll", mapAll);

        return "/adminRoom/memberList";
    }

    @GetMapping("/adminRoom/memberUp")
    public String memberUp(MemberDto mdto) {
        AdminDao adao = sqlSession.getMapper(AdminDao.class);
        adao.memberUp(mdto);

        return "redirect:/adminRoom/memberList";
    }

    @GetMapping("/adminRoom/reserveList")
    public String reserveList(Model model) {
        AdminDao adao = sqlSession.getMapper(AdminDao.class);
        List<ReserveDto> rlist = adao.reserveList();

        model.addAttribute("rlist", rlist);

        return "/adminRoom/reserveList";
    }

    // 연습용
    @GetMapping("/adminRoom/chuga1")
    public String chuga1() {
        return "/adminRoom/chuga1";
    }

    @GetMapping("/adminRoom/chuga2")
    public String chuga2() {
        return "/adminRoom/chuga2";
    }

    @GetMapping("/adminRoom/chuga3")
    public String chuga3() {
        return "/adminRoom/chuga3";
    }

    @GetMapping("/adminRoom/chuga4")
    public String chuga4() {
        return "/adminRoom/chuga4";
    }
}
