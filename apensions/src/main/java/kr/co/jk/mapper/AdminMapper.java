package kr.co.jk.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.InquiryDto;
import kr.co.jk.dto.MemberDto;
import kr.co.jk.dto.ReserveDto;
import kr.co.jk.dto.RoomDto;

@Mapper
public interface AdminMapper {
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
