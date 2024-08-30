package kr.co.pension.dao;

import java.util.ArrayList;

import kr.co.pension.dto.TourDto;

public interface TourDao {
	public ArrayList<TourDto> list();
	public void writeOk(TourDto tdto);
	public void readnum(String id);
	public boolean isWriter(String id, String userid);
	public TourDto content(String id);
	public String getName(String userid);
	public void updateOk(TourDto tdto);
	public String getTimg(String id);
	public void delete(String id);
}