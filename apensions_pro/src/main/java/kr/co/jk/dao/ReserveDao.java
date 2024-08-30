package kr.co.jk.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.ReserveDto;
import kr.co.jk.dto.RoomDto;

@Mapper
public interface ReserveDao {
    public ArrayList<RoomDto> getRooms();
	public RoomDto getRoom(int id);
	public int getJumuncode(String jumuncode);
	public void reserveOk(ReserveDto rdto);
	public ReserveDto reserveView(String jumuncode);
	public boolean isCheck(String date, int id);
	
}
