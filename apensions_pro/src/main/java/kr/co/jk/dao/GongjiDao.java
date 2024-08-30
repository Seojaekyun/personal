package kr.co.jk.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.GongjiDto;

@Mapper
public interface GongjiDao {
	public ArrayList<GongjiDto> list();
	public void writeOk(GongjiDto gdto);
	public void readnum(String id);
	public GongjiDto content(String id);
	public void delete(String id);
	public void updateOk(GongjiDto gdto);
}