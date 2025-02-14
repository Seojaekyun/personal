package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.CompanyDto;
import com.example.demo.dto.DaeDto;
import com.example.demo.dto.JungDto;
import com.example.demo.dto.ProQnaDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.SoDto;

@Mapper
public interface AdminMapper {
	List<DaeDto> getDae();
	List<JungDto> getJung(String dae);
	List<SoDto> getSo(String daejung);
	List<CompanyDto> getCom();
	int genPcode(String pcode);
	void productAddOk(ProductDto pdto);
	@SuppressWarnings("rawtypes")
	List<HashMap> panmaeList();
	void chgState(String state, String id);
	List<ProQnaDto> qnaList();
	void writeAnswerOk(ProQnaDto pdto);

}
