package kr.co.jk.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.InquiryDto;

@Mapper
public interface InquiryMapper {
    public int getNumber(String inum);
    public void writeOk(InquiryDto idto);
	public InquiryDto getInquiry(String inqNumber);
}
