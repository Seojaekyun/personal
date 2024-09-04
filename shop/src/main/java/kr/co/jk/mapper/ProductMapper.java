package kr.co.jk.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.BaesongDto;
import kr.co.jk.dto.MemberDto;
import kr.co.jk.dto.ProductDto;

@Mapper
public interface ProductMapper {
	ArrayList<ProductDto> productList(String pcode, String str, int index);
	String getDaeName(String code);
	String getJungName(String code, String daecode);
	String getSoName(String code, String daejung);
	int getPtot(String pcode);
	ProductDto productContent(String pcode);
	void jjimOk(String pcode, String userid);
	void jjimDel(String pcode, String userid);
	int jjimIs(String pcode, String userid);
	void addCart(String pcode, int su, String userid);
	boolean isCart(String pcode, String userid);
	void upCart(String pcode, int su, String userid);
	String getCartNum(String userid);
	MemberDto getMember(String userid);
	BaesongDto getBaesong(String userid);
	void jusoWriteOk(BaesongDto bdto);
	ArrayList<BaesongDto> jusoList(String userid);
	void gibonInit(String userid);
	int getJuk(String userid);
	void chgPhone(String userid, String mPhone);
	void jusoDel(String id);
	BaesongDto jusoUpdate(String id);
	void jusoUpdateOk(BaesongDto bdto);

}
