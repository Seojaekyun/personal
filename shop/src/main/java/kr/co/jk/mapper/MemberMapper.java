package kr.co.jk.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.BaesongDto;
import kr.co.jk.dto.MemberDto;
import kr.co.jk.dto.ProQnaDto;
import kr.co.jk.dto.ProductDto;
import kr.co.jk.dto.ReviewDto;

@Mapper
public interface MemberMapper {
	public String useridCheck(String userid);

	public void memberOk(MemberDto mdto);

	public HashMap getProduct(String pcode);

	public ArrayList<HashMap> getProductAll(String userid);

	public void cartDel(String pcode, String userid);

	public void chgSu(int su, String pcode, String userid);

	public ArrayList<ProductDto> jjimList(String userid);

	public void addCart(String userid, String pcode);

	public boolean isCart(String pcode, String userid);

	public void jjimDel(String userid, String pcode);

	public ArrayList<HashMap> jumunList(String userid, int num, String start, String end);

	public void chgState(String state, String id);

	public void reviewWriteOk(ReviewDto rdto);

	public double getReviewAvg(String pcode);

	public void setProduct(double star, String pcode);

	public void setProduct2(double star, String pcode);

	public void setProduct3(double star, String pcode);

	public void chgIsReview(int id);

	public ArrayList<HashMap> getJumun(int year, String month, String userid);

	public MemberDto memberView(String userid);

	public void chgEmail(String userid, String email);

	public void chgPhone(String userid, String phone);

	public boolean isPwd(String userid, String pwd);

	public void pwdChg(String userid, String pwd);

	public ArrayList<BaesongDto> myBaesong(String userid);

	public void baeDel(String id);

	public BaesongDto baeUpdate(String id);

	public void baeUpdateOk(BaesongDto bdto);

	public void setGibon(String userid);

	public void jusoWriteOk(BaesongDto bdto);

	public ArrayList<HashMap> myReview(String userid);

	public String isMy(String userid, String id);

	public void reviewDel(String id);

	public ReviewDto reviewUpdate(String id);

	public void reviewUpdateOk(ReviewDto rdto);

	public ArrayList<ProQnaDto> myQna(String userid);

	public void qnaDel(String id);

	public String viewAnswer(String ref);
}
