package kr.co.pension.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.pension.dto.BoardDto;
import kr.co.pension.dto.GongjiDto;
import kr.co.pension.dto.InquiryDto;
import kr.co.pension.dto.MemberDto;
import kr.co.pension.dto.ReserveDto;
import kr.co.pension.dto.TourDto;

public interface MemberDao {
   public String dupCheck(String userid);
   public void memberOk(MemberDto mdto);
   //public int loginOk(MemberDto mdto);
   public MemberDto loginOk(MemberDto mdto);
   public String useridSearch(MemberDto mdto);
   public String pwdSearch(MemberDto mdto);
   public MemberDto memberView(String userid);
   public void emailEdit(String email, String userid);
   public void phoneEdit(String phone, String userid);
   public boolean isPwd(String oldPwd, String userid);
   public void pwdChg(String pwd, String userid);
   public ArrayList<InquiryDto> getInquirys(String userid);
   public ArrayList<MemberDto> getMembers();
   public ArrayList<HashMap> getMembers2();
   public void outMember(String userid);
   public void clsMember(String userid);
   public ArrayList<ReserveDto> reserveList(String userid);
   public void cancelRe(String state, String id);
   public String loginOk(String name);
   public ArrayList<GongjiDto> getGongji();
   public ArrayList<BoardDto> getBoard();
   public ArrayList<TourDto> getTour();

}
