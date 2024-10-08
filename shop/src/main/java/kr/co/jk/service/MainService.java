package kr.co.jk.service;

import java.util.ArrayList;

import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.jk.dto.DaeDto;
import kr.co.jk.dto.JungDto;
import kr.co.jk.dto.SoDto;

public interface MainService {
	public String index(Model model);

	public ArrayList<DaeDto> getDae();

	public ArrayList<JungDto> getJung(HttpServletRequest request);

	public ArrayList<SoDto> getSo(HttpServletRequest request);

	public String cartNum(HttpServletRequest request, HttpSession session);
}
