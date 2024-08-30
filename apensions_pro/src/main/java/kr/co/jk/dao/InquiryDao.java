package kr.co.jk.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.InquiryDto;

@Mapper
public interface InquiryDao {
    public int getNumber(String inum);
    public void writeOk(InquiryDto idto);
	public InquiryDto getInquiry(String inqNumber);
}
