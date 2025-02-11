package com.example.demo.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.BaesongDto;
import com.example.demo.dto.MemberDto;
import com.example.demo.dto.ProQnaDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.ReviewDto;

@Mapper
public interface MemberMapper {
    Integer useridCheck(String userid);
    void memberOk(MemberDto mdto);
	boolean isCart(String pcode, String userid);
	void addCart(String userid, String pcode);
	@SuppressWarnings("rawtypes")
	HashMap getProduct(String pcode);
	@SuppressWarnings("rawtypes")
	List<HashMap> getProductAll(String userid);
	void cartDel(String pcode, String userid);
	void chgSu(int su, String pcode, String userid);
	ArrayList<ProductDto> jjimList(String userid);
	void jjimDel(String userid, String pcode);
	String getCartSu(String userid);
	void upCart(String userid, String pcode);
	@SuppressWarnings("rawtypes")
	List<HashMap> myReview(String userid);
	@SuppressWarnings("rawtypes")
	List<HashMap> jumunList(String userid, int num, String start, String end);
	void chgState(String state, String id);
	void reviewWriteOk(ReviewDto rdto);
	double getReviewAvg(String pcode);
	void setProduct(double star, String pcode);
	void chgIsReview(int gid);
	@SuppressWarnings("rawtypes")
	List<HashMap> getJumun(int year, String month2, String userid);
	MemberDto memberView(String userid);
	void chgEmail(String userid, String email);
	void chgPhone(String userid, String phone);
	boolean isPwd(String userid, String oldPwd);
	void pwdChg(String userid, String pwd);
	List<BaesongDto> myBaesong(String userid);
	void baeDel(String id);
	Object baeUpdate(String id);
	void setGibon(String userid);
	void baeUpdateOk(BaesongDto bdto);
	void jusoWriteOk(BaesongDto bdto);
	String isMy(String userid, String id);
	void reviewDel(String id);
	void setProduct2(double star, String pcode);
	ReviewDto reviewUpdate(String id);
	void reviewUpdateOk(ReviewDto rdto);
	void setProduct3(double star, String pcode);
	List<ProQnaDto> myQna(String userid);
	void qnaDel(String id);
	String viewAnswer(String ref);
	
	
}
