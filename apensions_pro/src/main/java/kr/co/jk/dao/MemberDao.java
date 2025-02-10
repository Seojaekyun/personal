package kr.co.jk.dao;

import java.util.List;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.BoardDto;
import kr.co.jk.dto.GongjiDto;
import kr.co.jk.dto.InquiryDto;
import kr.co.jk.dto.MemberDto;
import kr.co.jk.dto.ReserveDto;
import kr.co.jk.dto.TourDto;

@Mapper
public interface MemberDao {
   public String dupCheck(String userid);
   public void memberOk(MemberDto mdto);
   public MemberDto loginOk(MemberDto mdto);
   public String useridSearch(MemberDto mdto);
   public String pwdSearch(MemberDto mdto);
   public MemberDto memberView(String userid);
   public void emailEdit(String email, String userid);
   public void phoneEdit(String phone, String userid);
   public boolean isPwd(String oldPwd, String userid);
   public void pwdChg(String pwd, String userid);
   public List<InquiryDto> getInquirys(String userid);
   public List<MemberDto> getMembers();
   @SuppressWarnings("rawtypes")
public List<HashMap> getMembers2();
   public void outMember(String userid);
   public void clsMember(String userid);
   public List<ReserveDto> reserveList(String userid);
   public void cancelRe(String state, String id);
   public String loginOk(String name);
   public List<GongjiDto> getGongji();
   public List<BoardDto> getBoard();
   public List<TourDto> getTour();
   public int reMember(MemberDto mdto);

}
