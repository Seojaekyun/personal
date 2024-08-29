package kr.co.jk.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.RoomDto;

@Mapper
public interface DefaultMapper {
	public ArrayList<RoomDto> getRooms();
}
