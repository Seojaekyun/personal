package kr.co.jk.service;

import java.lang.reflect.Array;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.util.WebUtils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dto.BaesongDto;
import kr.co.jk.dto.GumaeDto;
import kr.co.jk.dto.ProductDto;
import kr.co.jk.mapper.ProductMapper;
import kr.co.jk.utils.MyUtil;

@Service
@Qualifier("ps")
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductMapper mapper;
	
	@Override
	public String productList(HttpServletRequest request, Model model) {
		String pcode=request.getParameter("pcode");
		
		/*
		String pos="HOME ☞ "; if(pcode.length()==3) { String code=pcode.substring(1);
		pos=pos+mapper.getDaeName(code); }
		
		else if(pcode.length()==5) { String daecode=pcode.substring(1, 3);
		pos=pos+mapper.getDaeName(daecode); String code=pcode.substring(3);
		pos=pos+" ☞ "+mapper.getJungName(code, daecode); }
		
		else { String daecode=pcode.substring(1, 3);
		pos=pos+mapper.getDaeName(daecode); String daejung=pcode.substring(1, 5);
		String jungcode=pcode.substring(3, 5); String code=pcode.substring(5);
		pos=pos+" ☞ "+mapper.getJungName(jungcode, daecode);
		pos=pos+" ☞ "+mapper.getSoName(code, daejung); }
		*/
		
		String pos="HOME";
		String[] poses= {null,null,null}; // 대,중,소분류코드를 넣는 배열
		for(int i=0;i<poses.length;i++) {
			
			try	{   // 대,중,소를 자른다 => 오류발생 => for문 종료
				poses[i]=pcode.substring(i*2+1,i*2+3);  //  p010101
				if(i==0) { // p01
					pos=pos+" ☞ "+mapper.getDaeName(poses[0]);
				}
				
				else if(i==1) {
					pos=pos+" ☞ "+mapper.getJungName(poses[1], poses[0]);
				}
				else if(i==2) {
					pos=pos+" ☞ "+mapper.getSoName(poses[2],poses[0]+poses[1]);
				}
			}
			
			catch(Exception e) {
				break;
			}
		}
		
		model.addAttribute("pos", pos);
		
		String order="1";
		if(request.getParameter("order")!=null) {
			order=request.getParameter("order");
		}
		
		String str=null;
		switch(order) {
			case "1": str=" pansu desc"; break;
			case "2": str=" price desc"; break;
			case "3": str=" price asc"; break;
			case "4": str=" star desc"; break;
			case "5": str=" writeday desc"; break;
        }
		
		int page=1;
		if(request.getParameter("page")!=null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		int index=(page-1)*20;
		
		ArrayList<ProductDto> plist=mapper.productList(pcode, str, index);
		
		for(int i=0;i<plist.size();i++) {
			ProductDto pdto=plist.get(i);
			//double halinPrice=pdto.getPrice()-(pdto.getPrice()*(pdto.getHalin()/100.0));
			int halinPrice=(int)(pdto.getPrice()-(pdto.getPrice()*(pdto.getHalin()/100.0)));
			int jukPrice=(int)(halinPrice*(pdto.getJuk()/100.0));
			
			LocalDate today=LocalDate.now();
			LocalDate xday=today.plusDays(pdto.getBaeday());
			String yoil=MyUtil.getYoil(xday);
			
			String baeEx=null;
			if(pdto.getBaeday()==1) {
				baeEx="내일("+yoil+") 도착 예정!";
			}
			
			else if(pdto.getBaeday()==2) {
				baeEx="모레("+yoil+") 도착 예정!";
			}
			
			else {
				int m=xday.getMonthValue()+1;
				int d=xday.getDayOfMonth();
				baeEx=m+"/"+d+"("+yoil+") 도착 예정!";
			}
			
			plist.get(i).setHalinPrice(halinPrice);
			plist.get(i).setJukPrice(jukPrice);
			plist.get(i).setBaeEx(baeEx);
		}
		
		int psta, pend, ptot;
		
		psta=page/10;
		if(page%10==0) {
			psta=psta-1;
		}
		
		psta=psta*10+1;
		
		pend=psta+9;
		
		ptot=mapper.getPtot(pcode);
		
		if(pend>ptot) {
			pend=ptot;
		}
		
		model.addAttribute("page", page);
		model.addAttribute("psta", psta);
		model.addAttribute("pend", pend);
		model.addAttribute("ptot", ptot);
		model.addAttribute("plist",plist);
		model.addAttribute("pcode",pcode);
		model.addAttribute("order",order);
		return "product/productList";
	}
	
	@Override
	public String productContent(HttpServletRequest request, Model model, HttpSession session) {
		String pcode=request.getParameter("pcode");
		
		ProductDto pdto=mapper.productContent(pcode);
		
		int halinPrice=(int)(pdto.getPrice()-( pdto.getPrice()*( pdto.getHalin()/100.0) ));
		// 적립금액 => 상품금액*(적립률/100)
		int jukPrice=(int)(halinPrice*(pdto.getJuk()/100.0));
		
		// 배송예정일 =>  내일(요일) 배송예정  ,  모레(요일) 배송예정 ,  월/일(요일) 배송예정
		// 오늘기준으로 배송예정일의 날짜객체를 생성
		LocalDate today=LocalDate.now(); // 오늘날짜 객체생성
		// 오늘 기준 몇일 후의 날짜 객체
		LocalDate xday=today.plusDays(pdto.getBaeday());
		String yoil=MyUtil.getYoil(xday);
	
		String baeEx=null;
		if(pdto.getBaeday()==1)
		{
			baeEx="내일("+yoil+") 도착예정";  // 내일(화) 도착예정
		}
		else if(pdto.getBaeday()==2)
		     {
			     baeEx="모레("+yoil+") 도착예정"; // 모레(수) 도착예정
		     }
		     else
		     {
		    	 int m=xday.getMonthValue();
		    	 int d=xday.getDayOfMonth();
		    	 baeEx=m+"/"+d+"("+yoil+") 도착예정";
		     }
			
		
		// ArrayList내부에 있는 DTO에 새로운 값을 저장
		pdto.setHalinPrice(halinPrice);
		pdto.setJukPrice(jukPrice);
		pdto.setBaeEx(baeEx);
		
		model.addAttribute("pdto", pdto);
		
		String jImg;
		if(session.getAttribute("userid")!=null) {
			String userid=session.getAttribute("userid").toString();
			int ch=mapper.jjimIs(pcode, userid); // ch값  0 or 1
			
			if(ch==0) {
				jImg="jjim1.png";
			}
			else {
				jImg="jjim2.png";
			}
		}
		else {
			jImg="jjim1.png";
		}
		
		model.addAttribute("jImg",jImg);
		return "product/productContent";
	}
	
	@Override
	public String jjimOk(HttpServletRequest request, HttpSession session) {
		String pcode=request.getParameter("pcode");
		String fname=request.getParameter("fname");
		if(session.getAttribute("userid")==null) {
			return "0";
		}
		else {
			String userid=session.getAttribute("userid").toString();
			if(fname.equals("jjim1.png")) {
				mapper.jjimOk(pcode, userid);
			}
			else {
				mapper.jjimDel(pcode, userid);
			}
						
			return "1";
		}				
	}
	
	@Override
	public String addCart(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		String pcode=request.getParameter("pcode");
		int su=Integer.parseInt(request.getParameter("su"));
		String cartNum=null;
		
		try {
			if(session.getAttribute("userid")==null) {
				// 로그인을 하지 않아도 장바구니 처리를 실행
				Cookie cookie=WebUtils.getCookie(request, "pcode");
				String newPro=pcode+"-"+su+"/";
				
				String newPcode=null;
				if(cookie==null || cookie.getValue().equals("")) {
					newPcode=newPro;
					cartNum="1";
				}
				else {
					String getPcode=cookie.getValue();
					String[] pcodes=getPcode.split("/");
					
					int chk = -1;
					for(int i=0;i<pcodes.length;i++) {
						if(pcodes[i].indexOf(pcode) != -1) {
							chk=i;
						}
					}
					
					if(chk != -1) {
						int num=Integer.parseInt(pcodes[chk].substring(13));
						num=num=su;
						pcodes[chk]=pcodes[chk].substring(0, 13)+num;
						
						String imsi="";
						for(int i=0;i>pcodes.length;i++) {
							imsi=imsi+pcodes[i]+"/";
						}
						
						newPcode=imsi;
					}
					else {
						newPcode=getPcode+newPro;
						cartNum=(pcodes.length+1)+"";
					}
				}
				
				System.out.println(newPcode);
				
				// newPcode를 새로운 쿠키객체로 생성
				Cookie newCookie=new Cookie("pcode",newPcode);
				newCookie.setMaxAge(600);
				newCookie.setPath("/");
				response.addCookie(newCookie);
			}
			else {
				String userid=session.getAttribute("userid").toString();
				
				if(mapper.isCart(pcode, userid)) {
					mapper.upCart(pcode, su, userid);
				}
				else {
					mapper.addCart(pcode,su,userid);
				}
				
				cartNum=mapper.getCartNum(userid);
			}
			
			return "cartNum";
		}
		catch(Exception e) {
			return "-1";
		}
	}
	
	@Override
	public String gumae(HttpSession session, HttpServletRequest request, Model model) {
		if(session.getAttribute("userid")==null) {
			return "redirect:/login/login";
		}
		else {
			String userid=session.getAttribute("userid").toString();
			model.addAttribute("mdto", mapper.getMember(userid));
			
			BaesongDto bdto=mapper.getBaesong(userid);
			if(bdto!=null) {
				String breq=null;
				switch(bdto.getReq()) {
				    case 0: breq="문 앞"; break;
				    case 1: breq="직접 받고 부재시 문앞"; break;
				    case 2: breq="경비실"; break;
				    case 3: breq="택배함"; break;
				    case 4: breq="공동현관 앞"; break;
				    default: breq="읽지 못함";
				}
				
				bdto.setBreq(breq);
			}
			
			model.addAttribute("bdto", bdto);
						
			String pcode=request.getParameter("pcode");
			String su=request.getParameter("su");
			
			String[] pcodes=pcode.split("/");
			String[] imsi=su.split("/");
			int[] sues=new int[imsi.length];
			
			for(int i=0;i<imsi.length;i++) {
				sues[i]=Integer.parseInt(imsi[i]);
			}
			
			ArrayList<ProductDto> plist=new ArrayList<ProductDto>();
			for(int i=0;i<pcodes.length;i++) {
				ProductDto pdto=mapper.productContent(pcodes[i]);
				pdto.setSu(sues[i]);
				
				// 배송예정일 =>  내일(요일) 배송예정  ,  모레(요일) 배송예정 ,  월/일(요일) 배송예정
				// 오늘기준으로 배송예정일의 날짜객체를 생성
				LocalDate today=LocalDate.now(); // 오늘날짜 객체생성
				// 오늘 기준 몇일 후의 날짜 객체
				LocalDate xday=today.plusDays(pdto.getBaeday());
				String yoil=MyUtil.getYoil(xday);
				
				String baeEx=null;
				if(pdto.getBaeday()==1) {
					baeEx="내일("+yoil+") 도착예정";  // 내일(화) 도착예정
				}
				else if(pdto.getBaeday()==2) {
					baeEx="모레("+yoil+") 도착예정"; // 모레(수) 도착예정
				}
				else {
					int m=xday.getMonthValue();
					int d=xday.getDayOfMonth();
					baeEx=m+"/"+d+"("+yoil+") 도착예정";
				}
				
				pdto.setBaeEx(baeEx);
				
				plist.add(pdto);
			}
			
			model.addAttribute("plist", plist);
			
			int halinPrice=0;
			int baePrice=0;
			int jukPrice=0;
			for(int i=0;i<plist.size();i++) {
				ProductDto pdto=plist.get(i);
				int price=pdto.getPrice();  // 상품가격
				int halin=pdto.getHalin();
				int su2=pdto.getSu();
				int bae=pdto.getBaeprice();
				int juk=pdto.getJuk();
				halinPrice=halinPrice+(price-(int)(price*halin/100.0))*su2;
				baePrice=baePrice+bae;
				jukPrice=jukPrice+(int)(price*juk/100.0);
			}
			
			model.addAttribute("halinPrice", halinPrice);
			model.addAttribute("baePrice", baePrice);
			model.addAttribute("jukPrice", jukPrice);
			
			model.addAttribute("juk", mapper.getJuk(userid));
			
			return "/product/gumae";
		}
	}
	
	@Override
	public String jusoWriteOk(BaesongDto bdto, Model model, HttpSession session) {
		// 주소가 존재하지만 새로추가할 경우의 gibon은 나중에 처리
		String userid=session.getAttribute("userid").toString();
		bdto.setUserid(userid);
		
		if(bdto.getGibon()==1) {
			mapper.gibonInit(userid);
		}
		
		if(bdto.getTt().equals("1")) {// 배송지가 있을때 추가
			mapper.jusoWriteOk(bdto);
			// 추가입력
			return "redirect:/product/jusoList";
		} 
		else { // 처음입력
			bdto.setGibon(1);
			mapper.jusoWriteOk(bdto);
			int id=mapper.getBaeId(userid);
			model.addAttribute("id",id);
			model.addAttribute("bname", bdto.getName());
			model.addAttribute("bjuso", bdto.getJuso()+" "+bdto.getJusoEtc());
			model.addAttribute("bphone",bdto.getPhone());
			String breq=null;
			
			switch(bdto.getReq()) {
				case 0: breq="문 앞"; break;
				case 1: breq="직접 수령, 부재시 문 앞"; break;
				case 2: breq="경비실에 맡겨주세요."; break;
				case 3: breq="택배함"; break;
				case 4: breq="공동현관 앞"; break;
				default: breq="읽지 못함";
			}
			System.out.println(breq);
		
			model.addAttribute("breq", breq);
			return "/product/jusoWriteOk";
		}
	}
	
	@Override
	public String jusoList(Model model, HttpSession session) {
		String userid=session.getAttribute("userid").toString();
		 
		ArrayList<BaesongDto> blist=mapper.jusoList(userid);
		
		for(int i=0;i<blist.size();i++) {
			String breq=null;			
			switch(blist.get(i).getReq()) {
				case 0: breq="문 앞"; break;
				case 1: breq="직접 수령, 부재시 문 앞"; break;
				case 2: breq="경비실에 맡겨주세요."; break;
				case 3: breq="택배함"; break;
				case 4: breq="공동현관 앞"; break;
				default: breq="읽지 못함";
			}
			
			blist.get(i).setBreq(breq);
		}
		
		model.addAttribute("blist", blist);
		
		return "/product/jusoList";
	}
	
	@Override
	public String jusoWrite(HttpServletRequest request, Model model) {
		model.addAttribute("tt",request.getParameter("tt"));
		
		return "/product/jusoWrite";
	}
	
	@Override
	public String chgPhone(HttpServletRequest request, HttpSession session) {
		try {
			String userid=session.getAttribute("userid").toString();
			String mPhone=request.getParameter("mPhone");
			
			mapper.chgPhone(userid,mPhone);
			
			return "0";
		}
		catch(Exception e) {
			return "1";
		}
	}
	
	@Override
	public String jusoDel(HttpServletRequest request) {
		String id=request.getParameter("id");
		mapper.jusoDel(id);
		
		return "redirect:/product/jusoList";
	}

	@Override
	public String jusoUpdate(HttpServletRequest request, Model model) {
		String id=request.getParameter("id");
		
		model.addAttribute("bdto", mapper.jusoUpdate(id));
		
		return "/product/jusoUpdate";
	}

	@Override
	public String jusoUpdateOk(BaesongDto bdto, HttpSession session) {
		if(bdto.getGibon()==1) {
			String userid=session.getAttribute("userid").toString();
			mapper.gibonInit(userid);
		}
		
		mapper.jusoUpdateOk(bdto);
		
		return "redirect:/product/jusoList";
	}

	@Override
	public String gumaeOk(GumaeDto gdto, HttpSession session) {
		String userid=session.getAttribute("userid").toString();
		gdto.setUserid(userid);
		// 주문코드
		LocalDate today=LocalDate.now();
		int y=today.getYear();
		int m=today.getMonthValue();
		int d=today.getDayOfMonth();
		String m2=String.format("%02d", m);
		String d2=String.format("%02d", d);
		
		String jumuncode="j"+y+m2+d2;
		
		int imsi=mapper.getJumuncode(jumuncode);
		jumuncode=jumuncode+String.format("%03d", imsi);
		
		gdto.setJumuncode(jumuncode);
		
		String[] pcodes=gdto.getPcodes();
		int[] sues=gdto.getSues();
				
		for(int i=0;i<pcodes.length;i++) {
			gdto.setPcode(pcodes[i]);
			gdto.setSu(sues[i]);
			
			mapper.gumaeOk(gdto);
			
			mapper.cartDel(userid, pcodes[i]); // 구매상품은 장바구니 삭제
			mapper.chgProduct(pcodes[i], sues[i]);
		}
		
		return "redirect:/product/gumaeView?="+jumuncode;
	}

	@Override
	public String gumaeView(HttpServletRequest request, Model model) {
		String jumuncode=request.getParameter("jumuncode");
		
		ArrayList<GumaeDto> glist=mapper.gumaeView(jumuncode);
		ArrayList<ProductDto> plist=new ArrayList<ProductDto>();
		ArrayList<BaesongDto> blist=new ArrayList<BaesongDto>();
		
		for(int i=0;i<glist.size();i++) {
			GumaeDto gdto=glist.get(i);
			ProductDto pdto=mapper.productContent(gdto.getPcode());
			plist.add(pdto);
			
			BaesongDto bdto=mapper.jusoUpdate(gdto.getBaeId()+"");
			blist.add(bdto);
		}
		
		return "/product/gumaeView";
	}
	
	@Override
	public String gumaeView2(HttpServletRequest request, Model model) {
		String jumuncode=request.getParameter("jumuncode");
		
		ArrayList<HashMap> mapAll=mapper.gumaeView2(jumuncode);
		int halinPrice=0, cBaeprice=0;
		String baeEx=null;
		String breq=null;
		for(int i=0;i<mapAll.size();i++) {
			HashMap map=mapAll.get(i);
			//price할인된 상품금액
			int price=Integer.parseInt(map.get("price").toString());
			int halin=Integer.parseInt(map.get("halin").toString());
			price=(int)( price-(price*halin/100.0) );
			//map.put("price", price); // 여기에 저장하면 뷰에 전달이 안된다
			
			mapAll.get(i).put("price", price);
			
			int su=Integer.parseInt(map.get("su").toString());			
			halinPrice=halinPrice+price;
			cBaeprice=cBaeprice+Integer.parseInt(map.get("baeprice").toString());
			
			switch(Integer.parseInt(map.get("breq").toString())) {
			    case 0: breq="문 앞"; break;
			    case 1: breq="직접 수령, 부재시 문 앞"; break;
			    case 2: breq="경비실에 맡겨주세요."; break;
			    case 3: breq="택배함"; break;
			    case 4: breq="공동현관 앞"; break;
			    default: breq="읽지 못함";
			}
			
			LocalDate today=LocalDate.now();
			int baeday=Integer.parseInt(map.get("baeday").toString());
			LocalDate xday=today.plusDays(baeday); // baeday가 계산된 날짜객체
			
			String yoil=MyUtil.getYoil(xday);
			baeEx=null;
			if(baeday==1) {
				baeEx="내일("+yoil+") 도착예정";
			}
			else if(baeday==2) {
					baeEx="모레("+yoil+") 도착예정";
				}
				else {
					int m=xday.getMonthValue();
					int d=xday.getDayOfMonth();
					baeEx=m+"/"+d+"("+yoil+") 도착예정";
				}
			
			mapAll.get(i).put("baeEx", baeEx);
			
		}
		
		model.addAttribute("mapAll",mapAll);
		model.addAttribute("halinPrice",halinPrice);
		model.addAttribute("cBaeprice",cBaeprice);
		model.addAttribute("baeEx",baeEx);
		model.addAttribute("breq",breq);
		
		return "/product/gumaeView";
	}
	
}






