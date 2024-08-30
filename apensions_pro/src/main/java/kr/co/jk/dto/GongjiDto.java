package kr.co.jk.dto;

import lombok.Data;

@Data
public class GongjiDto {
   private int id, readnum, state;
   private String title, content, writeday;
   
}
