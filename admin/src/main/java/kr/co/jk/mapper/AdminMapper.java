package kr.co.jk.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.CompanyDto;
import kr.co.jk.dto.DaeDto;
import kr.co.jk.dto.JungDto;
import kr.co.jk.dto.ProductDto;
import kr.co.jk.dto.ProQnaDto;
import kr.co.jk.dto.SoDto;

@Mapper
public interface AdminMapper {
	ArrayList<DaeDto> getDae();
	ArrayList<CompanyDto> getCompany();
	ArrayList<JungDto> getJung(String daecode);
	ArrayList<SoDto> getSo(String daejung);
	int genPcode(String pcode);
	void productAddOk(ProductDto pdto);
	ArrayList<HashMap> gumaeAll();
	void chgState(String state, String id);
	ArrayList<ProQnaDto> qnaList();
	void writeAnswerOk(ProQnaDto pdto);
	

}
