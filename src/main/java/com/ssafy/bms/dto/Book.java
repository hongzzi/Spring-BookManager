package com.ssafy.bms.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Book {
	private String isbn;
	private String title;
	private String author;
	private String publisher;
 	private Integer price;
	private String description;
	private Integer authorno;
	
}
