package kr.co.jk.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.CompanyDto;
import kr.co.jk.dto.DaeDto;
import kr.co.jk.dto.JungDto;
import kr.co.jk.dto.ProductDto;
import kr.co.jk.dto.SoDto;

@Mapper
public interface AdminMapper {
	public ArrayList<DaeDto> getDae();
	public ArrayList<CompanyDto> getCompany();
	public ArrayList<JungDto> getJung(String daecode);
	public ArrayList<SoDto> getSo(String daejung);
	public int genPcode(String pcode);
	public void productAddOk(ProductDto pdto);

}
