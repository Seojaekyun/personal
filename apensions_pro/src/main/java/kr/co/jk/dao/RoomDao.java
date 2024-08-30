package kr.co.jk.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.RoomDto;

@Mapper
public interface RoomDao {
    public RoomDto roomView(String id);
}
