package kr.co.jk.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.MemberDto;
import kr.co.jk.dto.ProductDto;

@Mapper
public interface MemberMapper {
	String useridCheck(String userid);
	void memberOk(MemberDto mdto);
	HashMap getProduct(String pcode);
	ArrayList<HashMap> getProductAll(String userid);
	void cartDel(String pcode, String userid);
	void chgSu(int su, String pcode, String userid);
	ArrayList<ProductDto> jjimList(String userid);
	void addCart(String userid, String pcode);
	boolean isCart(String pcode, String userid);
	void jjimDel(String userid, String pcode);

}