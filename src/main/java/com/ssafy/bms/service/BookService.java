package com.ssafy.bms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.bms.dto.Book;
import com.ssafy.bms.repo.BookRepo;

@Service
public class BookService {
	
	@Autowired
	BookRepo repo;
	
	public Book select(String isbn) {
		return repo.select(isbn);
	}
	
	public List<Book> select() {
		return repo.select();
	}
	
	public int insert(Book book) {
		return repo.insert(book);
	}
	
	public int update(Book book) {
		return repo.update(book);
	}
	
	public int delete(String isbn) {
		return repo.delete(isbn);
	}
	
}
