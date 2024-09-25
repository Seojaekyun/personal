package com.example.demo.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.BusSeatDto;

@Mapper
public interface EtcMapper {
   public BusSeatDto getBus(String busGubun);
}
