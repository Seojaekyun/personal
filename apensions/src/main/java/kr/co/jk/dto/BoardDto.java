package kr.co.jk.dto;

import lombok.Data;

@Data
public class BoardDto {
    private int id,readnum;
    private String userid,title,content, writeday;
}
