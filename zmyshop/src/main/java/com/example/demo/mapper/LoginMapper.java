package com.example.demo.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.dto.MemberDto;

@Mapper
public interface LoginMapper {
    String loginOk(MemberDto mdto);
    String getUserid(MemberDto mdto);
    String getPwd(MemberDto mdto);
    void chgPwd(String userid,String pwd, String oldPwd);
}
