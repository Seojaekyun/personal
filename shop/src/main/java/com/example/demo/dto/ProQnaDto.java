package com.example.demo.dto;

import lombok.Data;

@Data
public class ProQnaDto {
    private int id,qna,ref;
    private String userid,pcode,content,writeday;
    
    private String title;
    
    private int cnt;
}
