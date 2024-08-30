package kr.co.jk.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.MemberDto;

@Mapper
public interface MemberMapper {
	String useridCheck(String userid);
	void memberOk(MemberDto mdto);
	HashMap getProduct(String pcode);
	ArrayList<HashMap> getProductAll(String userid);
	void cartDel(String pcode, String userid);

}