package kr.co.jk.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.util.WebUtils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dto.BaesongDto;
import kr.co.jk.dto.GumaeDto;
import kr.co.jk.dto.ProductDto;
import kr.co.jk.mapper.ProductMapper;
import kr.co.jk.util.MyUtil;

@Service
@Qualifier("ps")
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductMapper mapper;

	@Override
	public String productList(HttpServletRequest request, Model model) {
		String pcode = request.getParameter("pcode");

		// pcode를 이용하여 화면에 HOME-대분류-중분류-소분류 형태의 텍스트를 만들어서
		// 사용자에게 알려준다.

		/*
		 * String pos="HOME - "; if(pcode.length()==3) // p01 { String
		 * code=pcode.substring(1); pos=pos+mapper.getDaeName(code); // HOME-대분류 } else
		 * if(pcode.length()==5) // p0101 { String daecode=pcode.substring(1,3);
		 * pos=pos+mapper.getDaeName(daecode); // HOME-대분류
		 * 
		 * String code=pcode.substring(3); pos=pos+" - "+mapper.getJungName(code,
		 * daecode); // HOME-대분류-중분류
		 * 
		 * } else if(pcode.length()==7) // p010102 { String
		 * daecode=pcode.substring(1,3); pos=pos+mapper.getDaeName(daecode); // HOME-대분류
		 * 
		 * String daejung=pcode.substring(1,5); String jungcode=pcode.substring(3,5);
		 * String code=pcode.substring(5); // 소분류코드
		 * pos=pos+" - "+mapper.getJungName(jungcode, daecode); // HOME-대분류-중분류
		 * 
		 * pos=pos+" - "+mapper.getSoName(code, daejung); // HOME-대분류-중분류-소분류 }
		 */
		String pos = "HOME";
		String[] poses = { null, null, null }; // 대,중,소분류코드를 넣는 배열
		for (int i = 0; i < poses.length; i++) {

			try { // 대,중,소를 자른다 => 오류발생 => for문 종료
				poses[i] = pcode.substring(i * 2 + 1, i * 2 + 3); // p010101
				if (i == 0) // p01
				{
					pos = pos + " ▷ " + mapper.getDaeName(poses[0]);
				} else if (i == 1) {
					pos = pos + " ▷ " + mapper.getJungName(poses[1], poses[0]);
				} else if (i == 2) {
					pos = pos + " ▷ " + mapper.getSoName(poses[2], poses[0] + poses[1]);
				}

			} catch (Exception e) {
				break;
			}
		}

		model.addAttribute("pos", pos);

		// 조회순서가 넘어올 때
		// 1 => order by pansu desc
		// 2 => order by price desc
		// 3 => order by price asc
		// 4 => order by star desc
		// 5 => order by writeday desc

		String order = "1";
		if (request.getParameter("order") != null)
			order = request.getParameter("order");

		String str = null;
		switch (order) {
		case "1":
			str = " pansu desc";
			break;
		case "2":
			str = " price desc";
			break;
		case "3":
			str = " price asc";
			break;
		case "4":
			str = " star desc";
			break;
		case "5":
			str = " writeday desc";
			break;
		}

		// 사용자가 원하는 페이지의 인덱스값 구하기
		int page = 1;
		if (request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));

		int index = (page - 1) * 20;

		List<ProductDto> plist = mapper.productList(pcode, str, index);

		// ArrayList<ProductDto> plist=mapper.productList(pcode);
		// index값으로 정렬되어 있다 => 배열처럼 정렬되어 있다.
		// 할인후 상품금액, 적립금액, 배송일관련 처리하여 dto에저장
		for (int i = 0; i < plist.size(); i++) {
			ProductDto pdto = plist.get(i);
			// 할인후 상품금액 => 상품금액-(상품금액*(할인율/100))
			int halinPrice = (int) (pdto.getPrice() - (pdto.getPrice() * (pdto.getHalin() / 100.0)));
			// 적립금액 => 상품금액*(적립률/100)
			int jukPrice = (int) (pdto.getPrice() * (pdto.getJuk() / 100.0));

			// 배송예정일 => 내일(요일) 배송예정 , 모레(요일) 배송예정 , 월/일(요일) 배송예정
			// 오늘기준으로 배송예정일의 날짜객체를 생성
			LocalDate today = LocalDate.now(); // 오늘날짜 객체생성
			// 오늘 기준 몇일 후의 날짜 객체
			LocalDate xday = today.plusDays(pdto.getBaeday());
			String yoil = MyUtil.getYoil(xday);

			String baeEx = null;
			if (pdto.getBaeday() == 1) {
				baeEx = "내일(" + yoil + ") 도착예정"; // 내일(화) 도착예정
			} else if (pdto.getBaeday() == 2) {
				baeEx = "모레(" + yoil + ") 도착예정"; // 모레(수) 도착예정
			} else {
				int m = xday.getMonthValue();
				int d = xday.getDayOfMonth();
				baeEx = m + "/" + d + "(" + yoil + ") 도착예정";
			}

			// ArrayList내부에 있는 DTO에 새로운 값을 저장
			plist.get(i).setHalinPrice(halinPrice);
			plist.get(i).setJukPrice(jukPrice);
			plist.get(i).setBaeEx(baeEx);

			// 하나의 pdto에 있는 star값을 이용하여
			// 노란별,회색별,반별의 갯수를 dto에 저장하기
			double star = pdto.getStar(); // 4.8
			int ystar = 0, hstar = 0, gstar = 0;

			ystar = (int) star; // 4
			star = star - ystar; // 소수부분 // 0.8

			if (star >= 0.8) {
				ystar++; // 5
			}
			if (star < 0.8 && star >= 0.3) {
				hstar++;
			}
			gstar = 5 - (ystar + hstar);

			// 구한 노란별,회색별,반별의 값을 plist에 저장
			plist.get(i).setYstar(ystar);
			plist.get(i).setHstar(hstar);
			plist.get(i).setGstar(gstar);

		} // ArrayList의 for끝

		// productList에 페이지를 링크하기 위해 필요한 값을 전달하기
		// pstart, pend, chong, page
		int pstart, pend, chong;

		pstart = page / 10;
		if (page % 10 == 0)
			pstart = pstart - 1;

		pstart = pstart * 10 + 1;

		pend = pstart + 9;

		// 총페이지 상품별로 정해진다.
		chong = mapper.getChong(pcode);

		// pend는 총페이지보다 크면 안된다
		if (pend > chong)
			pend = chong;

		model.addAttribute("page", page);
		model.addAttribute("pstart", pstart);
		model.addAttribute("pend", pend);
		model.addAttribute("chong", chong);

		model.addAttribute("plist", plist);
		model.addAttribute("pcode", pcode);
		model.addAttribute("order", order);
		return "product/productList";
	}

	@Override
	public String productContent(HttpServletRequest request, Model model, HttpSession session) {
		String pcode = request.getParameter("pcode");

		ProductDto pdto = mapper.productContent(pcode);

		// 할인후 상품금액 => 상품금액-(상품금액*(할인율/100))
		int halinPrice = (int) (pdto.getPrice() - (pdto.getPrice() * (pdto.getHalin() / 100.0)));
		// 적립금액 => 상품금액*(적립률/100)
		int jukPrice = (int) (pdto.getPrice() * (pdto.getJuk() / 100.0));

		// 배송예정일 => 내일(요일) 배송예정 , 모레(요일) 배송예정 , 월/일(요일) 배송예정
		// 오늘기준으로 배송예정일의 날짜객체를 생성
		LocalDate today = LocalDate.now(); // 오늘날짜 객체생성
		// 오늘 기준 몇일 후의 날짜 객체
		LocalDate xday = today.plusDays(pdto.getBaeday());
		String yoil = MyUtil.getYoil(xday);

		String baeEx = null;
		if (pdto.getBaeday() == 1) {
			baeEx = "내일(" + yoil + ") 도착예정"; // 내일(화) 도착예정
		} else if (pdto.getBaeday() == 2) {
			baeEx = "모레(" + yoil + ") 도착예정"; // 모레(수) 도착예정
		} else {
			int m = xday.getMonthValue();
			int d = xday.getDayOfMonth();
			baeEx = m + "/" + d + "(" + yoil + ") 도착예정";
		}

		// ArrayList내부에 있는 DTO에 새로운 값을 저장
		pdto.setHalinPrice(halinPrice);
		pdto.setJukPrice(jukPrice);
		pdto.setBaeEx(baeEx);

		model.addAttribute("pdto", pdto);

		// 현재상품이 현재 접속한 사용자의 찜테이블에 있는지 확인
		String jImg;
		if (session.getAttribute("userid") != null) {
			String userid = session.getAttribute("userid").toString();
			int ch = mapper.isJjim(pcode, userid); // ch값 0 or 1

			if (ch == 0)
				jImg = "jjim1.png";
			else
				jImg = "jjim2.png";

		} else
			jImg = "jjim1.png";

		model.addAttribute("jImg", jImg);

		// product테이블의 star필드의 값을 이용하여
		// 노란별,반별,회색별의 갯수를 뷰에 전달
		double star = pdto.getStar(); // 4.8

		int ystar = 0, hstar = 0, gstar = 0;

		// 정수부분은 무조건 노란별
		ystar = (int) star; // 4
		star = star - ystar; // 소수부분 // 0.8

		// 소수부분이 노란별인지
		if (star >= 0.8) {
			ystar++; // 5
		}
		// 반별여부판정
		if (star < 0.8 && star >= 0.3) {
			hstar++;
		}
		// 회색별
		gstar = 5 - (ystar + hstar);

		model.addAttribute("ystar", ystar);
		model.addAttribute("hstar", hstar);
		model.addAttribute("gstar", gstar);

		// 현재 상품에 대한 상품평 테이블의 내용을 읽어온다
/*
		ArrayList<ReviewDto> rlist = mapper.getReview(pcode);

		// content필드에 <br>태그 추가
		for (int i = 0; i < rlist.size(); i++) {
			String content = rlist.get(i).getContent().replace("\r\n", "<br>");
			rlist.get(i).setContent(content);
		}
		// rlist.get(i).getUserid().substring(0,4)+"***";
		model.addAttribute("rlist", rlist);

		// 상품문의를 읽어서 뷰에 전달
		ArrayList<ProQnaDto> plist = mapper.questAll(pcode);
		model.addAttribute("plist", plist);
*/
		return "/product/productContent";
	}

	@Override
	public String jjimOk(HttpServletRequest request, HttpSession session) {
		String pcode = request.getParameter("pcode");
		String fname = request.getParameter("fname");
		if (session.getAttribute("userid") == null) {
			return "0";
		} else {
			String userid = session.getAttribute("userid").toString();
			if (fname.equals("jjim1.png"))
				mapper.jjimOk(pcode, userid);
			else
				mapper.jjimDel(pcode, userid);

			return "1";
		}
	}

	@Override
	public String addCart(HttpServletRequest request, HttpSession session, HttpServletResponse response) {
		String pcode = request.getParameter("pcode");
		int su = Integer.parseInt(request.getParameter("su"));
		String cartNum = null; // productContent에서 장바구니 담기를 실행
		try {
			if (session.getAttribute("userid") == null) {
				// 로그인을 하지 않아도 장바구니 처리를 실행
				// 이전의 쿠키변수 pcode를 읽어오기
				Cookie cookie = WebUtils.getCookie(request, "pcode");
				String newPro = pcode + "-" + su + "/";

				String newPcode = null;
				if (cookie == null || cookie.getValue().equals("")) {
					newPcode = newPro;
					cartNum = "1";
				} else {
					String getPcode = cookie.getValue(); // "p01010103005-1/p01050103012-12/p01030209003-1/"
					String[] pcodes = getPcode.split("/");

					int chk = -1;
					for (int i = 0; i < pcodes.length; i++) {
						if (pcodes[i].indexOf(pcode) != -1) // 존재한다
							chk = i; // chk변수에는 존재하는 코드의 배열인덱스값을 가진다..
					}

					if (chk != -1) {
						// 있다면 => 수량만 변경
						int num = Integer.parseInt(pcodes[chk].substring(13)); // p01010103005-1
						num = num + su; // 기존의 수량 + 추가되는 수량
						pcodes[chk] = pcodes[chk].substring(0, 13) + num; // "p01010103005-" + num

						String imsi = "";
						for (int i = 0; i < pcodes.length; i++) {
							imsi = imsi + pcodes[i] + "/";
						}
						newPcode = imsi;

						cartNum = pcodes.length + "";
					} else {
						// 없다면 => 새로 추가
						newPcode = getPcode + newPro;
						cartNum = (pcodes.length + 1) + "";
					}
				}

				System.out.println(newPcode);

				// newPcode를 새로운 쿠키객체로 생성
				Cookie newCookie = new Cookie("pcode", newPcode);
				newCookie.setMaxAge(3600);
				newCookie.setPath("/");
				response.addCookie(newCookie);

			} else {
				String userid = session.getAttribute("userid").toString();

				if (mapper.isCart(pcode, userid)) // (지금장바구니에 담은 상품이 cart테이블에 있냐)
				{
					// 있다면 => 수량만 update
					mapper.upCart(pcode, userid, su);
				} else {
					// 없다면 => insert
					mapper.addCart(pcode, su, userid);
				}

				cartNum = mapper.getCartNum(userid);
			}
			// return 되는 값을 cart의 갯수로 바꾸자
			return cartNum;
		} catch (Exception e) {
			return "-1";
		}

	}

	@Override
	public String gumae(HttpSession session, HttpServletRequest request, Model model) {
		if (session.getAttribute("userid") == null) {
			return "redirect:/login/login";
		} else {
			// 구매자 정보(회원)
			String userid = session.getAttribute("userid").toString();
			model.addAttribute("mdto", mapper.getMember(userid));

			// 배송지 정보
			BaesongDto bdto = mapper.getBaesong(userid);
			if (bdto != null) {
				String breq = null;
				switch (bdto.getReq()) {
				case 0:
					breq = "문 앞";
					break;
				case 1:
					breq = "직접 받고 부재시 문앞";
					break;
				case 2:
					breq = "경비실";
					break;
				case 3:
					breq = "택배함";
					break;
				case 4:
					breq = "공동현관 앞";
					break;
				default:
					breq = "읽지 못함";
				}
				bdto.setBreq(breq);
			}

			model.addAttribute("bdto", bdto);

			// 구매상품정보
			String pcode = request.getParameter("pcode");
			String su = request.getParameter("su");

			String[] pcodes = pcode.split("/");

			String[] imsi = su.split("/");
			int[] sues = new int[imsi.length];

			for (int i = 0; i < imsi.length; i++) {
				sues[i] = Integer.parseInt(imsi[i]);
			}

			List<ProductDto> plist = new ArrayList<ProductDto>();
			for (int i = 0; i < pcodes.length; i++) {
				ProductDto pdto = mapper.productContent(pcodes[i]);
				pdto.setSu(sues[i]);

				// 배송예정일 => 내일(요일) 배송예정 , 모레(요일) 배송예정 , 월/일(요일) 배송예정
				// 오늘기준으로 배송예정일의 날짜객체를 생성
				LocalDate today = LocalDate.now(); // 오늘날짜 객체생성
				// 오늘 기준 몇일 후의 날짜 객체
				LocalDate xday = today.plusDays(pdto.getBaeday());
				String yoil = MyUtil.getYoil(xday);

				String baeEx = null;
				if (pdto.getBaeday() == 1) {
					baeEx = "내일(" + yoil + ") 도착예정"; // 내일(화) 도착예정
				} else if (pdto.getBaeday() == 2) {
					baeEx = "모레(" + yoil + ") 도착예정"; // 모레(수) 도착예정
				} else {
					int m = xday.getMonthValue();
					int d = xday.getDayOfMonth();
					baeEx = m + "/" + d + "(" + yoil + ") 도착예정";
				}

				pdto.setBaeEx(baeEx);

				plist.add(pdto);
			}

			model.addAttribute("plist", plist);

			// 결제관련 금액 => 총상품금액, 배송비 , 적립예정금액
			int halinPrice = 0;
			int baePrice = 0;
			int jukPrice = 0;

			for (int i = 0; i < plist.size(); i++) {
				ProductDto pdto = plist.get(i);
				int price = pdto.getPrice(); // 상품가격
				int halin = pdto.getHalin();
				int su2 = pdto.getSu();
				int bae = pdto.getBaeprice();
				int juk = pdto.getJuk();
				halinPrice = halinPrice + (price - (int) (price * halin / 100.0)) * su2;
				baePrice = baePrice + bae;
				jukPrice = jukPrice + (int) (price * juk / 100.0);
			}
			model.addAttribute("halinPrice", halinPrice);
			model.addAttribute("baePrice", baePrice);
			model.addAttribute("jukPrice", jukPrice);

			// 사용자의 적립금을 가져와서 뷰에 전달
			model.addAttribute("juk", mapper.getJuk(userid));

			return "/product/gumae";
		}

	}

	@Override
	public String jusoWriteOk(BaesongDto bdto, Model model, HttpSession session) {
		// 주소가 존재하지만 새로추가할 경우의 gibon은 나중에 처리
		String userid = session.getAttribute("userid").toString();
		bdto.setUserid(userid);

		if (bdto.getGibon() == 1) {
			// 들어오는 주소가 기본배송지이므로 이전의 gibon은 0으로 변경
			mapper.gibonInit(userid);
		}

		if (bdto.getTt().equals("1")) // 배송지가 있을때 추가
		{
			mapper.jusoWriteOk(bdto);
			// 추가입력
			return "redirect:/product/jusoList";
		} else // 처음입력
		{
			bdto.setGibon(1);
			mapper.jusoWriteOk(bdto);

			// 방금입력된 주소의 id필드의 값을 알수 없다
			int id = mapper.getBaeId(userid);
			model.addAttribute("id", id);
			model.addAttribute("bname", bdto.getName());
			model.addAttribute("bjuso", bdto.getJuso() + " " + bdto.getJusoEtc());
			model.addAttribute("bphone", bdto.getPhone());
			String breq = null;
			switch (bdto.getReq()) {
			case 0:
				breq = "문 앞";
				break;
			case 1:
				breq = "직접 받고 부재시 문앞";
				break;
			case 2:
				breq = "경비실";
				break;
			case 3:
				breq = "택배함";
				break;
			case 4:
				breq = "공동현관 앞";
				break;
			default:
				breq = "읽지 못함";
			}
			model.addAttribute("breq", breq);
			return "/product/jusoWriteOk";
		}

	}

	@Override
	public String jusoList(Model model, HttpSession session) {
		String userid = session.getAttribute("userid").toString();

		List<BaesongDto> blist = mapper.jusoList(userid);

		// 요청사항 req => 문자열로 변환처리
		for (int i = 0; i < blist.size(); i++) {
			String breq = null;
			switch (blist.get(i).getReq()) {
			case 0:
				breq = "문 앞";
				break;
			case 1:
				breq = "직접 받고 부재시 문앞";
				break;
			case 2:
				breq = "경비실";
				break;
			case 3:
				breq = "택배함";
				break;
			case 4:
				breq = "공동현관 앞";
				break;
			default:
				breq = "읽지 못함";
			}

			blist.get(i).setBreq(breq);
		}

		model.addAttribute("blist", blist);

		return "/product/jusoList";
	}

	@Override
	public String jusoWrite(HttpServletRequest request, Model model) {
		model.addAttribute("tt", request.getParameter("tt"));

		return "/product/jusoWrite";
	}

	@Override
	public String chgPhone(HttpServletRequest request, HttpSession session) {
		try {
			String userid = session.getAttribute("userid").toString();
			String mPhone = request.getParameter("mPhone");

			mapper.chgPhone(userid, mPhone);

			return "0";
		} catch (Exception e) {
			return "1";
		}

	}

	@Override
	public String jusoDel(HttpServletRequest request) {
		String id = request.getParameter("id");
		mapper.jusoDel(id);

		return "redirect:/product/jusoList";
	}

	@Override
	public String jusoUpdate(HttpServletRequest request, Model model) {
		String id = request.getParameter("id");

		model.addAttribute("bdto", mapper.jusoUpdate(id));

		return "/product/jusoUpdate";
	}

	@Override
	public String jusoUpdateOk(BaesongDto bdto, HttpSession session) {
		if (bdto.getGibon() == 1) {
			String userid = session.getAttribute("userid").toString();
			mapper.gibonInit(userid);
		}

		mapper.jusoUpdateOk(bdto);

		return "redirect:/product/jusoList";
	}

	@Override
	public String gumaeOk(GumaeDto gdto, HttpSession session) {

		// userid에 세션변수저장, jumuncode를 생성
		String userid = session.getAttribute("userid").toString();
		gdto.setUserid(userid);

		// 주문코드 => j20240905001
		LocalDate today = LocalDate.now();
		int y = today.getYear();
		int m = today.getMonthValue();
		int d = today.getDayOfMonth();

		String m2 = "%02d".formatted(m);
		String d2 = "%02d".formatted(d);

		String jumuncode = "j" + y + m2 + d2; // j20240905

		int imsi = mapper.getJumuncode(jumuncode);

		jumuncode = jumuncode + "%03d".formatted(imsi); // j20240905001
		// System.out.println(imsi);

		gdto.setJumuncode(jumuncode);

		// pcodes[] , sues[] 의 length가 상품의 갯수
		String[] pcodes = gdto.getPcodes();
		int[] sues = gdto.getSues();

		// member테이블의 juk필드의 값에 useJuk값을 뺀다 => 저장
		mapper.chgJuk(gdto.getUseJuk(), userid);

		for (int i = 0; i < pcodes.length; i++) {
			gdto.setPcode(pcodes[i]);
			gdto.setSu(sues[i]);

			mapper.gumaeOk(gdto);

			// 장바구니에 있는 구매된 상품은 삭제
			mapper.cartDel(userid, pcodes[i]);

			// product테이블에 su필드의 값을 -수량 , pansu 의 값을 +수량
			mapper.chgProduct(pcodes[i], sues[i]);
		}

		return "redirect:/product/gumaeView?jumuncode=" + jumuncode;
	}

	// inner join 없이 사용
	@Override
	public String gumaeView(HttpServletRequest request, Model model) {
		String jumuncode = request.getParameter("jumuncode");

		List<GumaeDto> glist = mapper.gumaeView(jumuncode);

		// 배송정보, 상품정보를 glist를 이용하여 가져오기
		List<ProductDto> plist = new ArrayList<ProductDto>();
		List<BaesongDto> blist = new ArrayList<BaesongDto>();

		for (int i = 0; i < glist.size(); i++) {
			// 상품정보를 읽어서 plist에 add()
			GumaeDto gdto = glist.get(i);
			ProductDto pdto = mapper.productContent(gdto.getPcode());
			plist.add(pdto);

			// 배송정보를 읽어서 blist에 add()
			BaesongDto bdto = mapper.jusoUpdate(gdto.getBaeId() + "");
			blist.add(bdto);

		}
		return "/product/gumaeView";
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String gumaeView2(HttpServletRequest request, Model model) {
		String jumuncode = request.getParameter("jumuncode");

		List<HashMap> mapAll = mapper.gumaeView2(jumuncode);
		System.out.println(mapAll.size());
		// 하나의 할인된 상품금액 => price => map에 저장
		// 총상품금액(halinPrice) , 총배송비(cBaeprice), 도착예정(baeEx) , 배송요청사항(breq)
		// 뷰로 전달

		int halinPrice = 0, cBaeprice = 0;
		String baeEx = null;
		String breq = null;
		for (int i = 0; i < mapAll.size(); i++) {
			HashMap map = mapAll.get(i);
			// price할인된 상품금액 // map == mapAll.get(i)
			int price = Integer.parseInt(map.get("price").toString());
			int halin = Integer.parseInt(map.get("halin").toString());
			price = (int) (price - (price * halin / 100.0));
			// map.put("price", price); // 여기에 저장하면 뷰에 전달이 안된다
			mapAll.get(i).put("price", price);

			// 총상품금액
			int su = Integer.parseInt(map.get("su").toString());
			halinPrice = halinPrice + (price * su);
			// 총배송비
			cBaeprice = cBaeprice + Integer.parseInt(map.get("baeprice").toString());

			// 배송요청사항

			switch (Integer.parseInt(map.get("req").toString())) {
			case 0:
				breq = "문 앞";
				break;
			case 1:
				breq = "직접 받고 부재시 문앞";
				break;
			case 2:
				breq = "경비실";
				break;
			case 3:
				breq = "택배함";
				break;
			case 4:
				breq = "공동현관 앞";
				break;
			default:
				breq = "읽지 못함";
			}

			// 배송예정
			LocalDate today = LocalDate.now();
			int baeday = Integer.parseInt(map.get("baeday").toString());
			LocalDate xday = today.plusDays(baeday); // baeday가 계산된 날짜객체

			String yoil = MyUtil.getYoil(xday);
			baeEx = null;
			if (baeday == 1) {
				baeEx = "내일(" + yoil + ") 도착예정";
			} else if (baeday == 2) {
				baeEx = "모레(" + yoil + ") 도착예정";
			} else {
				int m = xday.getMonthValue();
				int d = xday.getDayOfMonth();
				baeEx = m + "/" + d + "(" + yoil + ") 도착예정";
			}

			mapAll.get(i).put("baeEx", baeEx);
		}

		model.addAttribute("mapAll", mapAll);
		model.addAttribute("halinPrice", halinPrice);
		model.addAttribute("cBaeprice", cBaeprice);
		model.addAttribute("baeEx", baeEx);
		model.addAttribute("breq", breq);

		return "/product/gumaeView";
	}

	@Override
	public String reviewDel(HttpServletRequest request) {
		String id = request.getParameter("id");
		String pcode = request.getParameter("pcode");

		mapper.reviewDel(id);

		return "redirect:/product/productContent?pcode=" + pcode;
	}

	@Override
	public String questWriteOk(HttpServletRequest request, HttpSession session) {
		String pcode = request.getParameter("pcode");
		String userid = session.getAttribute("userid").toString();
		String content = request.getParameter("content");

		// ref값을 구하기 =>
		int ref = mapper.getRef(pcode);

		// proQna에 저장
		mapper.questWriteOk(pcode, userid, content, ref);

		return "redirect:/product/productContent?pcode=" + pcode;
	}

	@Override
	public String questDel(HttpServletRequest request) {
		String ref = request.getParameter("ref");
		String pcode = request.getParameter("pcode");
		mapper.questDel(ref);

		return "redirect:/product/productContent?pcode=" + pcode;
	}

}
