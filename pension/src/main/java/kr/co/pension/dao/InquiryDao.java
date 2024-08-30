package kr.co.pension.dao;

import kr.co.pension.dto.InquiryDto;

public interface InquiryDao {
    public int getNumber(String inum);
    public void writeOk(InquiryDto idto);
	public InquiryDto getInquiry(String inqNumber);
}
