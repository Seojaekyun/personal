package kr.co.jk.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.BusSeatDto;

@Mapper
public interface EtcMapper {
	public BusSeatDto getBus(String busGubun);
}
