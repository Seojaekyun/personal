package kr.co.jk.service;

import java.util.ArrayList;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dto.DaeDto;
import kr.co.jk.dto.JungDto;
import kr.co.jk.dto.SoDto;

public interface MainService {
	String index();
	ArrayList<DaeDto> getDae();
	ArrayList<JungDto> getJung(HttpServletRequest request);
	ArrayList<SoDto> getSo(HttpServletRequest request);
	String cartNum(HttpServletRequest request, HttpSession session);

}
