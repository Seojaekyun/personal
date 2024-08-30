package kr.co.pension.dao;

import java.util.ArrayList;

import kr.co.pension.dto.BoardDto;

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


