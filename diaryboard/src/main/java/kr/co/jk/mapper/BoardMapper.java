package kr.co.jk.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;

import kr.co.jk.dto.BoardDto;
import kr.co.jk.dto.DatDto;

@Mapper
public interface BoardMapper {
	public void login(BoardDto bdto);
	public ArrayList<BoardDto> list(int index, int rec);
	public int getChong(int rec);
	public void writeOk(BoardDto bdto);
	public void rnum(String id);
	public BoardDto content(String id);
	public ArrayList<DatDto> dat(String id);
	public BoardDto update(String id);
	public void updateOk(BoardDto bdto);
	public boolean isPwd(int id, String pwd);
	public void delete(BoardDto bdto);
	public boolean loginOk(BoardDto mdto);
	public void memberOk(BoardDto mdto);
	public int uidChk(String uid);
	public void datOk(DatDto ddto);
	public DatDto datUp(String id);
	public void datupOk(DatDto ddto);
	public boolean isdatPwd(int id, String pwd);
	public void datDel(DatDto ddto);
	public String getUserNameByUid(String uid);
	public boolean isWriter(String id, String uid);
}
