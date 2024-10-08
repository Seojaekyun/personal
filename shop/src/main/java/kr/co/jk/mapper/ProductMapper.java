package kr.co.jk.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.BaesongDto;
import kr.co.jk.dto.GumaeDto;
import kr.co.jk.dto.MemberDto;
import kr.co.jk.dto.ProQnaDto;
import kr.co.jk.dto.ProductDto;
import kr.co.jk.dto.ReviewDto;

@Mapper
public interface ProductMapper {
	public ArrayList<ProductDto> productList(String pcode, String str, int index);

	// 대,중,소분류의 name을 가져오는 메소드
	public String getDaeName(String code);

	public String getJungName(String code, String daecode);

	public String getSoName(String code, String daejung);

	public int getChong(String pcode);

	public ProductDto productContent(String pcode);

	public void jjimOk(String pcode, String userid);

	public void jjimDel(String pcode, String userid);

	public int isJjim(String pcode, String userid);

	public void addCart(String pcode, int su, String userid);

	public boolean isCart(String pcode, String userid);

	public void upCart(String pcode, String userid, int su);

	public String getCartNum(String userid);

	public MemberDto getMember(String userid);

	public BaesongDto getBaesong(String userid);

	public void jusoWriteOk(BaesongDto bdto);

	public ArrayList<BaesongDto> jusoList(String userid);

	public void gibonInit(String userid);

	public int getJuk(String userid);

	public void chgPhone(String userid, String mPhone);

	public void jusoDel(String id);

	public BaesongDto jusoUpdate(String id);

	public void jusoUpdateOk(BaesongDto bdto);

	public int getBaeId(String userid);

	public int getJumuncode(String jumuncode);

	public void gumaeOk(GumaeDto gdto);

	public void cartDel(String userid, String pcode);

	public void chgProduct(String pcode, int su);

	public void chgJuk(int useJuk, String userid);

	public ArrayList<GumaeDto> gumaeView(String jumuncode);

	public ArrayList<HashMap> gumaeView2(String jumuncode);

	public ArrayList<ReviewDto> getReview(String pcode);

	public void reviewDel(String id);

	public int getRef(String pcode);

	public void questWriteOk(String pcode, String userid, String content, int ref);

	public ArrayList<ProQnaDto> questAll(String pcode);

	public void questDel(String ref);
}
