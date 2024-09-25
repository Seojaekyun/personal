package com.example.demo.dto;

import lombok.Data;

@Data
public class ReviewDto {
    private int id,star;
    private String content,oneLine,userid,pcode,writeday;
    // gumae테이블의 id
    private int gid;
    
    // productContent에서 사용자아이디에 별 붙여서 출력하려는 변수
    private String user;
}
