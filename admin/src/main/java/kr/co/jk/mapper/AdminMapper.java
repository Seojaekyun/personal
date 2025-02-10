package kr.co.jk.mapper;

import java.util.List;
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
	List<DaeDto> getDae();
	List<CompanyDto> getCompany();
	List<JungDto> getJung(String daecode);
	List<SoDto> getSo(String daejung);
	int genPcode(String pcode);
	void productAddOk(ProductDto pdto);
	@SuppressWarnings("rawtypes")
	List<HashMap> gumaeAll();
	void chgState(String state, String id);
	List<ProQnaDto> qnaList();
	void writeAnswerOk(ProQnaDto pdto);
	

}
