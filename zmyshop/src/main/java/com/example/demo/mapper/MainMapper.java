package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.DaeDto;
import com.example.demo.dto.JungDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.SoDto;

@Mapper
public interface MainMapper {

	String getCartNum(String userid);
	List<ProductDto> getProduct1();
	List<ProductDto> getProduct2();
	List<ProductDto> getProduct3();
	List<ProductDto> getProduct4();
	List<DaeDto> getDae();
	List<JungDto> getJung(String daecode);
	List<SoDto> getSo(String daejung);

}
