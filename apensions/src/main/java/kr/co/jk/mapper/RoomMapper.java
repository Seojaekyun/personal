package kr.co.jk.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.RoomDto;

@Mapper
public interface RoomMapper {
    public RoomDto roomView(String id);
}
