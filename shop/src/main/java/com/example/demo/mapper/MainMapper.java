package com.example.demo.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.DaeDto;
import com.example.demo.dto.JungDto;
import com.example.demo.dto.ProductDto;
import com.example.demo.dto.SoDto;

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
