package kr.co.jk.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Iterator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import jakarta.servlet.http.HttpServletRequest;
import kr.co.jk.dto.JungDto;
import kr.co.jk.dto.ProductDto;
import kr.co.jk.dto.SoDto;
import kr.co.jk.mapper.AdminMapper;
import kr.co.jk.util.MyUtils;

@Controller
public class AdminController {
	
	@Autowired
	private AdminMapper mapper;
	
	@GetMapping("/product/productAdd")
	public String productAdd(Model model) {
		model.addAttribute("daeAll", mapper.getDae());
		model.addAttribute("companyAll", mapper.getCompany());
		
		return "/product/productAdd";
	}
	
	@RequestMapping("/product/getJung")
	public @ResponseBody ArrayList<JungDto> getJung(HttpServletRequest request) {
		String daecode=request.getParameter("daecode");
		
		ArrayList<JungDto> jungAll=mapper.getJung(daecode);
		
		return jungAll;
	}
	
	@RequestMapping("/product/getSo")
	public @ResponseBody ArrayList<SoDto> getSo(HttpServletRequest request) {
		String daejung=request.getParameter("daejung");
		
		ArrayList<SoDto> soAll=mapper.getSo(daejung);
		
		return soAll;
	}
	
	@RequestMapping("/product/genPcode")
	public @ResponseBody String genPcode(HttpServletRequest request) {
		String pcode=request.getParameter("pcode");
		int num=mapper.genPcode(pcode);
		pcode=pcode+String.format("%03d", num);
		
		return pcode;	
	}
	
	@RequestMapping("/product/productAddOk")
	public String productAddOk(ProductDto pdto, MultipartHttpServletRequest multi) throws Exception {
		Iterator<String> imsi=multi.getFileNames();
		
		String pimg="";
		String dimg="";
		
		while(imsi.hasNext()) {
			String name=imsi.next();
			MultipartFile file=multi.getFile(name);
			
			if(!file.isEmpty()) {
				String oname=file.getOriginalFilename();
				String str=ResourceUtils.getFile("classpath:static/product").toString()+"/"+oname;
				str=MyUtils.getFileName(oname, str);
			
				if(name.equals("dimgName")) {
					dimg=str.substring(str.lastIndexOf("/")+1);
				}	
				else {
					pimg=pimg+str.substring(str.lastIndexOf("/")+1)+"/";
				}
				
				Path path=Paths.get(str);
				Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
			}
		}
		
		pdto.setPimg(pimg);
		pdto.setDimg(dimg);
		mapper.productAddOk(pdto);
		
		return "redirect:/product/productList";
	}

}
