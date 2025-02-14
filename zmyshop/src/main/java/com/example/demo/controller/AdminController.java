package com.example.demo.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.demo.dto.CompanyDto;
import com.example.demo.dto.DaeDto;
import com.example.demo.dto.JungDto;
import com.example.demo.dto.ProQnaDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.SoDto;
import com.example.demo.mapper.AdminMapper;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AdminController {
	@Autowired
	private AdminMapper mapper;
	
	@GetMapping("/admin/proWrite")
	public String proWrite(Model model) {
		List<DaeDto> dlist=mapper.getDae();
		List<CompanyDto> clist=mapper.getCom();
		
		model.addAttribute("dlist", dlist);
		model.addAttribute("clist", clist);
		
		return "/admin/proWrite";
	}
	
	@GetMapping("/admin/getJung")
	public @ResponseBody List<JungDto> getJung(HttpServletRequest request) {
		String dae=request.getParameter("dae");
		return mapper.getJung(dae);
	}
	
	@GetMapping("/admin/getSo")
	public @ResponseBody List<SoDto> getSo(HttpServletRequest request) {
		String daejung=request.getParameter("daejung");
		return mapper.getSo(daejung);
	}
	
	@GetMapping("/admin/genPcode")
	public @ResponseBody String genPcode(HttpServletRequest request) {
		String pcode=request.getParameter("pcode");
		int num=mapper.genPcode(pcode);
		pcode=pcode+String.format("%03d", num);
		
		return pcode;	
	}
	
	@PostMapping("/admin/proWriteOk")
	public String proWriteOk(ProductDto pdto, MultipartHttpServletRequest multi) throws Exception {
		Iterator<String> it=multi.getFileNames(); // type="file"의 name을 가져온다.
		String pimg="";
		String dimg="";
		while(it.hasNext()) {
			String imsi=it.next(); // expimg0 , expimg1, expimg2, expimg3 , exdimg
			
			MultipartFile file=multi.getFile(imsi);
			
			if(!file.isEmpty()) {
				String oname=file.getOriginalFilename(); // 업로드 되는 파일의 이름
				
				if(imsi.equals("exdimg")) {
					dimg=oname;
				}
				else {
					pimg=pimg+oname+"/";
				}
				
				String str=ResourceUtils.getFile("classpath:static/product").toString();
				
				File sfile=new File(str+"/"+oname);
				
				while(sfile.exists()) {
					
					String[] fnames=oname.split("[.]");
					
					Random random=new Random();
					int length=random.nextInt(6) + 1; // 1에서 6까지의 길이를 랜덤으로 선택
					StringBuilder randRec=new StringBuilder();
					
					for(int i=0;i<length;i++) {
						char randomChar=(char)('a'+random.nextInt(26)); // a~z 중 랜덤 문자 선택
						randRec.append(randomChar);
					}

					oname=fnames[0]+randRec.toString()+"."+fnames[1];
					
					sfile=new File(str+"/"+oname);
				}
				
				Path path=Paths.get(str+"/"+oname);
				Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
				
			}
			
		}
		
		System.out.println(pimg);
		System.out.println(dimg);
		
		pdto.setDimg(dimg);
		pdto.setPimg(pimg);
		
		mapper.productAddOk(pdto);
		
		return "/admin/proList";
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@GetMapping("/admin/panmaeList")
	public String panmaeList(Model model) {
		List<HashMap> mapAll=mapper.panmaeList();
		
		for(int i=0;i<mapAll.size();i++) {
			String state=mapAll.get(i).get("state").toString();
			String stateMsg=null;
			switch(state) {
				case "0": stateMsg="결제완료"; break;
				case "1": stateMsg="상품준비중"; break;
				case "2": stateMsg="배송중"; break;
				case "3": stateMsg="배송완료"; break;
				case "4": stateMsg="취소완료"; break;
				case "5": stateMsg="반품신청"; break;
				case "6": stateMsg="반품완료"; break;
				case "7": stateMsg="교환신청"; break;
				case "8": stateMsg="교환완료"; break;
				default: stateMsg="문의바람";
			}
			
			mapAll.get(i).put("stateMsg", stateMsg);
		}
		System.out.println(mapAll);
		model.addAttribute("mapAll", mapAll);
		return "/admin/panmaeList";
	}
	
	@GetMapping("/admin/chgState")
	public String chgState(HttpServletRequest request) {
		String state=request.getParameter("state");
		String id=request.getParameter("id");
		System.out.println(id);
		mapper.chgState(state, id);
		return "redirect:/admin/panmaeList";
	}
	
	@GetMapping("/qna/qnaList")
	public String qnaList(Model model) {
		List<ProQnaDto> plist=mapper.qnaList();
		model.addAttribute("plist", plist);
		return "/qna/qnaList";
	}
	
	@PostMapping("qna/writeAnswerOk")
	public String writeAnswerOk(ProQnaDto pdto) {
		pdto.setUserid("admin");
		mapper.writeAnswerOk(pdto);
		
		return "redirect:/qna/qnaList";
	}
	
}
