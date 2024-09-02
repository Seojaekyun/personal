package kr.co.jk.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.DaeDto;
import kr.co.jk.dto.JungDto;
import kr.co.jk.dto.SoDto;

@Mapper
public interface MainMapper {
	ArrayList<DaeDto> getDae();
	ArrayList<JungDto> getJung(String daecode);
	ArrayList<SoDto> getSo(String daejung);
	String getCartNum(String userid);

}
