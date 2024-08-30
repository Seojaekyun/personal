package kr.co.pension.dao;

import java.util.ArrayList;

import kr.co.pension.dto.ReserveDto;
import kr.co.pension.dto.RoomDto;

public interface ReserveDao {
    public ArrayList<RoomDto> getRooms();
	public RoomDto getRoom(int id);
	public int getJumuncode(String jumuncode);
	public void reserveOk(ReserveDto rdto);
	public ReserveDto reserveView(String jumuncode);
	public boolean isCheck(String date, int id);
	
}
