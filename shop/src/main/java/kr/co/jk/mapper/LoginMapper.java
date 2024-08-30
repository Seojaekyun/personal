package kr.co.jk.mapper;

import org.apache.ibatis.annotations.Mapper;
import kr.co.jk.dto.MemberDto;

@Mapper
public interface LoginMapper {
	String loginOk(MemberDto mdto);
	boolean isCart(String pcode, String userid);
	void addCart(String pcode, int su, String userid);
	void upCart(String pcode, String userid, int su);
	
}
