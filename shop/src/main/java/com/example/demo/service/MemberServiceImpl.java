package com.example.demo.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ProQnaDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.ReviewDto;
import com.example.demo.mapper.MemberMapper;
import com.example.demo.util.MyUtil;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
@Qualifier("ms2")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper mapper;

	@Override
	public String member() 
	{		 
		return "/member/member";
	}

	@Override
	public String useridCheck(String userid)
	{
		return mapper.useridCheck(userid); 
	}

	@Override
	public String memberOk(MemberDto mdto) 
	{
		mapper.memberOk(mdto);
		return "../login/login";
	}

	@Override
	public String cartView(HttpSession session, HttpServletRequest request, Model model) 
	{
	 
		// 로그인의 유무에 따라 테이블, 쿠키변수
		ArrayList<HashMap> pMapAll=null;
		if(session.getAttribute("userid")==null)
		{
			 // 쿠키변수에서 읽은 후 상품코드를 분리하여 가져온다..
			//  상품코드1-수량/상품코드2-수량/상품코드3-수량/
			 Cookie cookie=WebUtils.getCookie(request, "pcode"); 
			 if(cookie!=null && !cookie.getValue().equals(""))
			 {
				 String[] pcodes=cookie.getValue().split("/");
				 
				 pMapAll=new ArrayList<HashMap>();
				 //for(int i=0;i<pcodes.length;i++) // 모든 요소를 다 실행해야 된다.
				 for(int i=pcodes.length-1;i>=0;i--)
				 {
					 String pcode=pcodes[i].substring(0,12);
					 int su=Integer.parseInt( pcodes[i].substring(13) );
					 
					 
					 HashMap map=mapper.getProduct(pcode);
									 
					 // ArrayList에 추가하기전에 장바구니의 수량을 전달
					 // 로그인 한 경우 csu변수에 저장=> 여기도 변경
					 // map.put("su", su);
					 map.put("csu", su);
					 map.put("days", "0");
					 pMapAll.add(map);
				 }
			 }
		}
		else
		{
			 // cart테이블에서 읽어서 가져온다
			String userid=session.getAttribute("userid").toString();
			pMapAll=mapper.getProductAll(userid);
			if(pMapAll != null && pMapAll.size()!=0)
			{	
			    //System.out.println(pMapAll.get(0).get("csu"));
			    // csu필드의 값을 변경 => plist.get(0).put("csu","100")
			    //System.out.println( String.valueOf( pMapAll.get(0).get("csu") ));
			    //System.out.println( pMapAll.get(0).get("csu"));
			    int a=Integer.parseInt(String.valueOf(pMapAll.get(0).get("csu")));
			    //System.out.println(a);
			}
			
	     }
		
		// null일때 실행하면 오류가 발생
		if(pMapAll != null)
		{
			// 1. 모든 상품의 구매금액 , 모든 상품의 적립금 , 모든 상품의 배송비
			int halinpriceTot=0, jukpriceTot=0, baepriceTot=0;
			
			for(int i=0;i<pMapAll.size();i++)
			{
				HashMap map=pMapAll.get(i);
				// pMapAll에서 필요한 내용 변경하여 저장하기
				// 1. 배송예정
				LocalDate today=LocalDate.now();
				int baeday=Integer.parseInt(map.get("baeday").toString());
				LocalDate xday=today.plusDays(baeday);
				
				String yoil=MyUtil.getYoil(xday);
				String baeEx=null;
				if(baeday==1)
				{
					baeEx="내일("+yoil+") 도착예정";
				}
				else if(baeday==2)
				     {
					     baeEx="모레("+yoil+") 도착예정";
				     }
				     else
				     {
				    	 int m=xday.getMonthValue();
				    	 int d=xday.getDayOfMonth();
				    	 baeEx=m+"/"+d+"("+yoil+") 도착예정";
				     }
				 
				// ArrayList<HashMap>에 baeEx넣어주기
				pMapAll.get(i).put("baeEx", baeEx);
				
				// 2. 상품금액(할인율이 적용된 금액)
				int price=Integer.parseInt(map.get("price").toString());
				int halin=Integer.parseInt(map.get("halin").toString());
				int su=Integer.parseInt(map.get("csu").toString());
				int halinprice=(int)( price-(price*halin/100.0) )*su; // 하나의 상품구매 금액
			    pMapAll.get(i).put("halinprice", halinprice);
			    
			    
			    
				// 3. 적립금
				int juk=Integer.parseInt(map.get("juk").toString());
				int jukprice=(int)(price*juk/100.0)*su;               // 하나의 상품구매 적립금
				pMapAll.get(i).put("jukprice", jukprice);
				
				
				
				
				// 쿠키변수에서 온 list에서는 days변수가 없다 => 위에서 강제로 넣어준다..
				int days=Integer.parseInt( map.get("days").toString() );
				if(days<=1)
				{
					// 2-1. 모든 상품의 구매금액을 누적
				    halinpriceTot=halinpriceTot+halinprice;
				    // 3-1 모든 상품의 적립금액을 누적
					jukpriceTot=jukpriceTot+jukprice;
					// 4 모든 상품의 배송비를 누적
					int baeprice=Integer.parseInt(map.get("baeprice").toString());
					baepriceTot=baepriceTot+baeprice;
				}
				
			} // for의 끝
			// 뷰에 모든 상품의 구매금액,적립금,배송비를 전달
			model.addAttribute("halinpriceTot",halinpriceTot);
			model.addAttribute("jukpriceTot",jukpriceTot);
			model.addAttribute("baepriceTot",baepriceTot);
			
		} // 장바구니에 상품이 있다면의 if끝
		  
		model.addAttribute("pMapAll",pMapAll);
		return "/member/cartView";
	}

	 
 
	@Override
	public String cartDel(HttpServletRequest request, HttpSession session, HttpServletResponse response) 
	{
		String[] pcodes=request.getParameter("pcode").split("/");
	    for(int i=0;i<pcodes.length;i++)
	    {
	    	System.out.print(pcodes[i]+" ");
	    }
	    
		if(session.getAttribute("userid")==null)
		{
			// 쿠키변수에 삭제할 pcode를 삭제
			Cookie cookie=WebUtils.getCookie(request, "pcode");
			if(cookie!=null)
			{
				String[] ckPcodes=cookie.getValue().split("/");
				
				for(int j=0;j<ckPcodes.length;j++) // 쿠키변수에 있는 상품코드 배열
				{
					
					for(int k=0;k<pcodes.length;k++)
					{
						if(ckPcodes[j].indexOf(pcodes[k]) != -1) // 참이면 포함되어 있다
						{
							ckPcodes[j]="";
							break;
						}
							
					}
					
				}
				
				// ckPcodes에는 삭제하는 상품코드는 ""이다
				// ckPcodes를 문자열로 합쳐서 쿠키에 다시 저장
				String newPcode="";
				for(int i=0;i<ckPcodes.length;i++)
				{
					if(ckPcodes[i] != "")
					  newPcode=newPcode+ckPcodes[i]+"/";  // 모두삭제하면 ""
				}
				
				Cookie newCookie;
				if(newPcode.equals(""))
				{
					newCookie=new Cookie("pcode",newPcode);
					newCookie.setMaxAge(0);
				}
				else
				{
					newCookie=new Cookie("pcode",newPcode);
					newCookie.setMaxAge(3600);
				}
				
				newCookie.setPath("/");
				response.addCookie(newCookie);
			}
			
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			
			for(int i=0;i<pcodes.length;i++)
			{
			   // cart테이블에서 pcode에 해당하는 레코드를 삭제
			   mapper.cartDel(pcodes[i],userid);
			}
		}
		
			
		 
		
		return "redirect:/member/cartView";
	}

	@Override
	public int[] chgSu(HttpServletRequest request,
			HttpSession session 
			,HttpServletResponse response)
	{
		String pcode=request.getParameter("pcode");
		int su=Integer.parseInt(request.getParameter("su"));
		
		if(session.getAttribute("userid")==null)
		{
			 Cookie cookie=WebUtils.getCookie(request, "pcode");
			 
			 String[] pcodes=cookie.getValue().split("/");
			 
			 for(int i=0;i<pcodes.length;i++)
			 {
				 if( pcodes[i].indexOf(pcode) != -1 ) // 상품코드가 일치 
				 {
					 pcodes[i]=pcode+"-"+su;
				 }
			 }
			 
			 // 배열의 값을 문자열로 변경
			 String newPcode="";
			 for(int i=0;i<pcodes.length;i++)
			 {
				 newPcode=newPcode+pcodes[i]+"/";
			 }
			 
			 // 쿠키를 다시 저장
			 Cookie newCookie=new Cookie("pcode",newPcode);
			 newCookie.setMaxAge(3600);
			 newCookie.setPath("/");
			 response.addCookie(newCookie);
 
		}
		else // 로그인한 회원
		{					    
		    String userid=session.getAttribute("userid").toString();
		    mapper.chgSu(su,pcode,userid); // cart테이블에서 수량변경
		}
		
		HashMap map=mapper.getProduct(pcode); // 해당상품정보
	    
	    int price=Integer.parseInt(map.get("price").toString());
	    int halin=Integer.parseInt(map.get("halin").toString());
	    int juk=Integer.parseInt(map.get("juk").toString());
	    
	    int[] tot=new int[3];
	    tot[0]=(int)(price-(price*halin/100.0))*su;
	    tot[1]=(int)(price*juk/100.0)*su;
	    tot[2]=Integer.parseInt(map.get("baeprice").toString());
	    
	    return tot;
 
	}

	@Override
	public String jjimList(HttpSession session, Model model) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			ArrayList<ProductDto> plist=mapper.jjimList(userid);
			
			// 할인금액
			for(int i=0;i<plist.size();i++)
			{
				int price=plist.get(i).getPrice();
				int halin=plist.get(i).getHalin();
				
				int halinPrice=price-(int)(price*halin/100.0);
				
				plist.get(i).setHalinPrice(halinPrice);
			}
			
			model.addAttribute("plist",plist);
			
			return "/member/jjimList";	
		}	
	}

	@Override
	public String addCart(HttpServletRequest request, HttpSession session) 
	{
		try
		{
			String userid=session.getAttribute("userid").toString();
			String pcode=request.getParameter("pcode");
			
			if(!mapper.isCart(pcode, userid))
			  mapper.addCart(userid,pcode);
			
			return "0";
		}
		catch(Exception e)
		{
			return "1";
		}
		
		
		 
	}

	@Override
	public String jjimDel(HttpServletRequest request, HttpSession session) 
	{
		 String userid=session.getAttribute("userid").toString();
		 // 선택삭제는 1개 이상 , 상품에서 삭제는 1개만
		 String[] pcodes=request.getParameter("pcode").split("/");
		 
		 for(int i=0;i<pcodes.length;i++)
		 {
		    mapper.jjimDel(userid,pcodes[i]);
		 }
		 
		 return "redirect:/member/jjimList";
	}

	@Override
	public String jumunList(HttpSession session, Model model
			,HttpServletRequest request) 
	{
		// num값 =>  0:전부, 3,6,12개월    1:기간검색
		int num=0;
		if(request.getParameter("num")!=null)
  		   num=Integer.parseInt(request.getParameter("num"));
		
		String start=request.getParameter("start");
		String end=request.getParameter("end");
		
		System.out.println(num);
		String userid=session.getAttribute("userid").toString();
		ArrayList<HashMap> mapAll=mapper.jumunList(userid,num,start,end);
		
		for(int i=0;i<mapAll.size();i++)
		{
			// state의 값을 문자열로 변경후 저장
			String state=mapAll.get(i).get("state").toString();
			String stateMsg=null;
			switch(state)
			{
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
		
		/*
		ArrayList<HashMap<String,String[]>> mapAll2=new ArrayList<HashMap<String,String[]>>();
		String imsi="";
        
		for(int i=0;i<mapAll.size();i++)
		{
			
			if(imsi.equals(mapAll.get(i).get("jumuncode").toString()))
			{
				mapAll.get(i).get("title");
				mapAll.get(i).get("pimg");
				mapAll.get(i).get("name");
				mapAll.get(i).get("juso");
				mapAll.get(i).get("chongPrice");
				mapAll.get(i).get("state");
				mapAll.get(i).get("su");
				mapAll.get(i).get("useJuk");
				mapAll.get(i).get("sudan");
				mapAll.get(i).get("writeday");
			}
			else
			{
				
			}
			
			imsi=mapAll.get(i).get("jumuncode").toString();
		}
		*/
		model.addAttribute("mapAll",mapAll);
		return "/member/jumunList";
	}
	/*
	@Override
	public String jumunList2(HttpSession session, Model model) 
	{
		String userid=session.getAttribute("userid").toString();
		ArrayList<HashMap> mapAll=mapper.jumunList(userid);
		
		for(int i=0;i<mapAll.size();i++)
		{
			// state의 값을 문자열로 변경후 저장
			String state=mapAll.get(i).get("state").toString();
			String stateMsg=null;
			switch(state)
			{
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
		
	 
		model.addAttribute("mapAll",mapAll);
		return "/member/jumunList2";
	}
	*/
	/*
	@Override
	public String jumunList3(HttpSession session, Model model) 
	{
		String userid=session.getAttribute("userid").toString();
		ArrayList<HashMap> mapAll=mapper.jumunList(userid);
		
		for(int i=0;i<mapAll.size();i++)
		{
			// state의 값을 문자열로 변경후 저장
			String state=mapAll.get(i).get("state").toString();
			String stateMsg=null;
			switch(state)
			{
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
		
	 
		model.addAttribute("mapAll",mapAll);
		return "/member/jumunList3";
	}
	*/
	@Override
	public String chgState(HttpServletRequest request) 
	{
		String state=request.getParameter("state");
		String id=request.getParameter("id");
		
		mapper.chgState(state,id);
		 
		return "redirect:/member/jumunList";
	}

	@Override
	public String reviewWrite(HttpServletRequest request,Model model)
	{
		String pcode=request.getParameter("pcode");
		String id=request.getParameter("id");
		model.addAttribute("id",id);
		model.addAttribute("pcode",pcode);
		
		return "/member/reviewWrite";
	}

	@Override
	public String reviewWriteOk(ReviewDto rdto, HttpSession session) 
	{
		// review테이블에 저장
		String userid=session.getAttribute("userid").toString();
		rdto.setUserid(userid);
		mapper.reviewWriteOk(rdto);
		
		
		// product테이블에 star필드에 평균값을 다시 구해서 저장 rdto.getPcode()
		double star=mapper.getReviewAvg(rdto.getPcode());
		// product테이블에 review필드에 1증가
		mapper.setProduct(star, rdto.getPcode());
		
		// gumae테이블에서 리뷰여부를 저장하는 필드 isReview에 값을 1로 변경
		mapper.chgIsReview(rdto.getGid());
		return "redirect:/member/jumunList";
	}

	@Override
	public String monthView(HttpServletRequest request, Model model,HttpSession session) {
		int year,month;
		if(request.getParameter("year")==null)
		{
			LocalDate today=LocalDate.now();
			year=today.getYear();
			month=today.getMonthValue();
		}
		else // 년,월의 값이 넘어 올때  0월, 13월을 처리해야 된다.
		{			
			year=Integer.parseInt(request.getParameter("year"));
			month=Integer.parseInt(request.getParameter("month"));
			
			if(month==0) 
			{
			    year=year-1;
			    month=12;
			}
			
			if(month==13)
			{
				year=year+1;
				month=1;
			}
		}
		
		
		
		// 오늘기준으로 2024년 8월 1일의 객체가 필요
		LocalDate xday=LocalDate.of(year, month, 1);
		
		// 1일의 요일 => getDayOfWeek().getValue()
		int yoil=xday.getDayOfWeek().getValue(); // 1~7
		// 일요일은 월요일 앞에 출력되므로 월요일보다 적은값 0으로 교체
		if(yoil==7)
			yoil=0;
		
		// 2024년 8월의 총일수
		int chong=xday.lengthOfMonth(); 
		 
		// 2024년 8월의 총 몇주 
		int ju=(int)Math.ceil((yoil+chong)/7.0); 
		
		//System.out.println(ju);   
		
		model.addAttribute("yoil",yoil);
		model.addAttribute("chong",chong);
		model.addAttribute("ju",ju);
		// 뷰에 년,월 전달
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		
		String userid=session.getAttribute("userid").toString();
		String month2=String.format("%02d",month);
		ArrayList<HashMap> mapAll=mapper.getJumun(year,month2,userid);
		//model.addAttribute("mapAll",mapAll);
		String writeday="";
		String title="";
		for(int i=0;i<mapAll.size();i++)
		{
		    writeday=writeday+mapAll.get(i).get("writeday").toString();
		    title=title+"'"+mapAll.get(i).get("title").toString()+"'";
		    
		    if(i!=mapAll.size()-1) // 마지막 요소가 아니라면
		    {
		    	writeday=writeday+",";
		    	title=title+",";
		    }
		}
		model.addAttribute("title",title);
		model.addAttribute("writeday",writeday);
 		System.out.println(writeday);
		System.out.println(title);
		return "/member/monthView";
	}

	@Override
	public String memberView(HttpSession session, Model model,HttpServletRequest request) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			
			MemberDto mdto=mapper.memberView(userid);
			model.addAttribute("mdto",mdto);
			model.addAttribute("err",request.getParameter("err"));
			
			return "/member/memberView";
		}
		
	    
	}

	@Override
	public String chgEmail(HttpSession session, HttpServletRequest request)
	{
		 try
		 {
			 String userid=session.getAttribute("userid").toString();
			 String email=request.getParameter("email");
			 mapper.chgEmail(userid,email);
			 
			 return "1";
		 }
		 catch(Exception e)
		 {
			 return "0";
		 }
	}

	@Override
	public String chgPhone(HttpSession session, HttpServletRequest request)
	{		 
		try
		 {
			 String userid=session.getAttribute("userid").toString();
			 String phone=request.getParameter("phone");
			 mapper.chgPhone(userid,phone);
			 
			 return "1";
		 }
		 catch(Exception e)
		 {
			 return "0";
		 }

	}

	@Override
	public String pwdChg(HttpServletRequest request, HttpSession session) 
	{
		 if(session.getAttribute("userid")==null) 
		 {
			 return "redirect:/login/login";
		 }
		 else
		 {
			 String userid=session.getAttribute("userid").toString();
			 String oldPwd=request.getParameter("oldPwd");
			 String pwd=request.getParameter("pwd");
			 
			 if(mapper.isPwd(userid,oldPwd))
			 {
				 mapper.pwdChg(userid,pwd);
				 
				 session.invalidate();
				 
				 return "redirect:/login/login";
			 }
			 else
			 {
				 return "redirect:/member/memberView?err=1";
			 }
		 }
		 
	}

	@Override
	public String myBaesong(HttpSession session, Model model) 
	{
		if(session.getAttribute("userid")==null) 
		{
		    return "redirect:/login/login";
		    // 에러메시지가 필요하면 주면 됨
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			
			ArrayList<BaesongDto> blist=mapper.myBaesong(userid);
			
			// 요청사항
			for(int i=0;i<blist.size();i++)
			{
				String breq=null;
				switch(blist.get(i).getReq())
				{
				    case 0: breq="문 앞"; break;
				    case 1: breq="직접 받고 부재시 문앞"; break;
				    case 2: breq="경비실"; break;
				    case 3: breq="택배함"; break;
				    case 4: breq="공동현관 앞"; break;
				    default: breq="읽지 못함";
				}
				
				blist.get(i).setBreq(breq);
			}
			
			model.addAttribute("blist",blist);			
		    return "member/myBaesong";
		}
	}

	@Override
	public String baeDel(HttpServletRequest request, HttpSession session) 
	{
		if(session.getAttribute("userid")==null) 
		{
			return "redirect:/login/login";
		}
		else
		{
			String id=request.getParameter("id");
			mapper.baeDel(id);
			return "redirect:/member/myBaesong";
		}
	}
	
	@Override
	public String baeUpdate(HttpServletRequest request, HttpSession session,Model model) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
            String id=request.getParameter("id");
            model.addAttribute("bdto",mapper.baeUpdate(id));
            
			return "member/baeUpdate";
		}
		 
	}
	@Override
	public String baeUpdateOk(BaesongDto bdto, HttpSession session) {
		  
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String userid=session.getAttribute("userid").toString();	
			if(bdto.getGibon()==1)
			{
				mapper.setGibon(userid);
			}
			
			mapper.baeUpdateOk(bdto);
			
			return "member/baeUpdateOk";
		}
	}
	
	
	@Override
	public String jusoWrite()
	{
		return "/member/jusoWrite";
	}

	@Override
	public String jusoWriteOk(BaesongDto bdto,HttpSession session)
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			bdto.setUserid(userid);
			
			if(bdto.getGibon()==1) 
			{
			    mapper.setGibon(userid);	
			}
			
			mapper.jusoWriteOk(bdto);
			
			return "/member/jusoWriteOk";
		}
		
	}

	@Override
	public String myReview(HttpSession session, Model model)
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			ArrayList<HashMap> mapAll=mapper.myReview(userid);
			
			for(int i=0;i<mapAll.size();i++)
			{
				String title=mapAll.get(i).get("title").toString();
				if(title.length()>10)
				{
					title=title.substring(0,10)+"···.";
				}
				mapAll.get(i).put("title", title);
				
				String content=mapAll.get(i).get("content").toString();
				content=content.replace("\r\n", "<br>");
				mapAll.get(i).put("content", content);
				}
			
			model.addAttribute("mapAll",mapAll);
			
			return "/member/myReview";
		}
		
	}

	@Override
	public String reviewDel(HttpSession session, HttpServletRequest request) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			String id=request.getParameter("id");
			String pcode=mapper.isMy(userid,id);
			if(pcode!=null)
			{
				mapper.reviewDel(id);
				// 삭제후 gumae테이블에서 해당 상품의 별점 평균을 다시 구해서 처리하기(pcode가 필요)
				double star=mapper.getReviewAvg(pcode);
                mapper.setProduct2(star, pcode);
				
				return "redirect:/member/myReview";
			}
			else
			{   // 잘못된 접근일 확율이 있음
				session.invalidate();
				return "redirect:/login/login";
			}
			
		}
	 	
	}

	@Override
	public String reviewUpdate(HttpServletRequest request, HttpSession session, Model model) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
			String id=request.getParameter("id");
			ReviewDto rdto=mapper.reviewUpdate(id);
			model.addAttribute("rdto",rdto);
			return "member/reviewUpdate";
		}
		
	}


	@Override
	public String reviewUpdateOk(ReviewDto rdto, HttpSession session) 
	{
		if(session.getAttribute("userid")==null) 
		{
			return "redirect:/login/login";
		}
		else
		{
			// review테이블에 수정하기
			mapper.reviewUpdateOk(rdto);
			// review테이블에서 star값을 다시 구해서 product.star에 수정
			double star=mapper.getReviewAvg(rdto.getPcode());
			mapper.setProduct3(star, rdto.getPcode());
			
			
			return "redirect:/member/myReview";
		}
	}
	
	
	@Override
	public String myQna(HttpSession session, Model model) 
	{
		if(session.getAttribute("userid")==null)
		{
			return "redirect:/login/login";
		}
		else
		{
            String userid=session.getAttribute("userid").toString();
            
            ArrayList<ProQnaDto> plist=mapper.myQna(userid);
            for(int i=0;i<plist.size();i++)
            {
            	String content=plist.get(i).getContent();
            	content=content.replace("\r\n", "<br>");
            	plist.get(i).setContent(content);
            }
            model.addAttribute("plist",plist);
            
            return "member/myQna";
        }
		 
	}

	@Override
	public String qnaDel(HttpServletRequest request, HttpSession session) 
	{
		if(session.getAttribute("userid")==null) 
		{
			return "redirect:/login/login";
		}
		else
		{
            String id=request.getParameter("id");
            mapper.qnaDel(id);
            return "redirect:/member/myQna";
		}
		
	}

	@Override
	public String viewAnswer(HttpServletRequest request) 
	{
		String ref=request.getParameter("ref");
		return mapper.viewAnswer(ref).replace("\r\n","<br>");
	}


	
	

	

	
	
	 
    /*
	@Override
	public String cartDel(HttpServletRequest request, HttpSession session, HttpServletResponse response) 
	{
		String[] pcodes=request.getParameter("pcode").split("/");
	    //for(int i=0;i<pcodes.length;i++)
	    //{
	    //	System.out.print(pcodes[i]+" ");
	    //}
	    
		if(session.getAttribute("userid")==null)
		{
			// 쿠키변수에 삭제할 pcode를 삭제
			Cookie cookie=WebUtils.getCookie(request, "pcode");
			if(cookie!=null)
			{
				String newPcode=cookie.getValue();
				System.out.println(newPcode);
				for(int i=0;i<pcodes.length;i++)
				{					
					newPcode=newPcode.replace(pcodes[i]+"/", "");
				}
			    System.out.println(newPcode);
				
				Cookie newCookie=new Cookie("pcode",newPcode);
				newCookie.setMaxAge(3600);
				newCookie.setPath("/");
				response.addCookie(newCookie);

			}
			
		}
		else
		{
			String userid=session.getAttribute("userid").toString();
			
			for(int i=0;i<pcodes.length;i++)
			{
			   // cart테이블에서 pcode에 해당하는 레코드를 삭제
			   mapper.cartDel(pcodes[i],userid);
			}
		}
		
			
		 
		
		return "redirect:/member/cartView";
	}
	*/
}







