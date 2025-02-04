package kr.co.jk.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.DaeDto;
import kr.co.jk.dto.JungDto;
import kr.co.jk.dto.ProductDto;
import kr.co.jk.dto.SoDto;

@Mapper
public interface MainMapper {
	public ArrayList<DaeDto> getDae();
	public ArrayList<JungDto> getJung(String daecode);
	public ArrayList<SoDto> getSo(String daejung);
	public String getCartNum(String userid);
	public ArrayList<ProductDto> getProduct1();
	public ArrayList<ProductDto> getProduct2();
	public ArrayList<ProductDto> getProduct3();
	public ArrayList<ProductDto> getProduct4();
}
