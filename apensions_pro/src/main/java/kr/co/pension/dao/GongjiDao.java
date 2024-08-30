package kr.co.pension.dao;

import java.util.ArrayList;
import kr.co.pension.dto.GongjiDto;

public interface GongjiDao {
	public ArrayList<GongjiDto> list();
	public void writeOk(GongjiDto gdto);
	public void readnum(String id);
	public GongjiDto content(String id);
	public void delete(String id);
	public void updateOk(GongjiDto gdto);
}