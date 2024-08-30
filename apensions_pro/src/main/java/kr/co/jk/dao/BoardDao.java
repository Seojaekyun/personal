package kr.co.jk.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.BoardDto;

@Mapper
public interface BoardDao {
    public ArrayList<BoardDto> list();
    public void writeOk(BoardDto bdto);
    public void readnum(String id);
    public BoardDto content(String id);
    public String getName(String userid);
    public void delete(String id);
    public void updateOk(BoardDto bdto);
    public boolean isWriter(String id,String userid);
}


