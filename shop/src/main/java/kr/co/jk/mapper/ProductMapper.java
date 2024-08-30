package kr.co.jk.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

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
}
