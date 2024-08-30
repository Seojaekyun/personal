package kr.co.pension.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.pension.dto.InquiryDto;
import kr.co.pension.dto.MemberDto;
import kr.co.pension.dto.ReserveDto;
import kr.co.pension.dto.RoomDto;

public interface AdminDao {
    public ArrayList<RoomDto> list();
    public void writeOk(RoomDto rdto);
    public RoomDto content(String id);
    public void delete(String id);
    public String getRimg(String id);
    public void updateOk(RoomDto rdto);
	public ArrayList<InquiryDto> getInquirys();
	public void inquiryOk(InquiryDto idto);
	public ArrayList<HashMap> memberList();
	public void memberUp(MemberDto mdto);
	public ArrayList<ReserveDto> reserveList();

}
