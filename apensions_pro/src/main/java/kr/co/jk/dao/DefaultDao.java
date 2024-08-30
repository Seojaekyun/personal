package kr.co.jk.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.RoomDto;

@Mapper
public interface DefaultDao {
	public ArrayList<RoomDto> getRooms();
}
