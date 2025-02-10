package kr.co.jk.dao;

import java.util.List;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.InquiryDto;
import kr.co.jk.dto.MemberDto;
import kr.co.jk.dto.ReserveDto;
import kr.co.jk.dto.RoomDto;

@Mapper
public interface AdminDao {
    public List<RoomDto> list();
    public void writeOk(RoomDto rdto);
    public RoomDto content(String id);
    public void delete(String id);
    public String getRimg(String id);
    public void updateOk(RoomDto rdto);
	public List<InquiryDto> getInquirys();
	public void inquiryOk(InquiryDto idto);
	@SuppressWarnings("rawtypes")
	public List<HashMap> memberList();
	public void memberUp(MemberDto mdto);
	public List<ReserveDto> reserveList();

}
