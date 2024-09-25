package com.example.demo.service;

import java.util.ArrayList;

import org.springframework.ui.Model;

import com.example.demo.dto.DaeDto;
import com.example.demo.dto.JungDto;
import com.example.demo.dto.SoDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public interface MainService {
    public String index(Model model);
    public ArrayList<DaeDto> getDae();
    public ArrayList<JungDto> getJung(HttpServletRequest request);
    public ArrayList<SoDto> getSo(HttpServletRequest request);
    public String cartNum(HttpServletRequest request,HttpSession session);
}
