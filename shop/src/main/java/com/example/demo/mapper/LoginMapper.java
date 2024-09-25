package com.example.demo.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.MemberDto;

@Mapper
public interface LoginMapper {
    public String loginOk(MemberDto mdto);
    public void addCart(String pcode,int su,String userid);
    public boolean isCart(String pcode , String userid);
    public void upCart(String pcode,String userid,int su);

}
