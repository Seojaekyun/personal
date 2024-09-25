package com.example.demo.dto;

import lombok.Data;

@Data
public class MemberDto {
    private int id,juk,state;
    private String userid,pwd,name,email;
    private String phone,writeday;
    
    // productContent에서 로그인하지않고 찜을 했을때 필요한 값
    private String pcode;
}
