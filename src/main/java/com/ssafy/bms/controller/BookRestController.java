package com.ssafy.bms.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.bms.dto.Book;
import com.ssafy.bms.service.BookService;

import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/rest")
@Slf4j
@CrossOrigin("*")	// 모든 클라이언트 환영
public class BookRestController {
	private static Logger logger = LoggerFactory.getLogger(BookRestController.class);
	@Autowired
	BookService service;
	
	@GetMapping("/book/{isbn}")
	@ApiOperation("isbn을 이용한 Book데이터 조회")
	public ResponseEntity<Map<String, Object>> select(@PathVariable String isbn) {
		try {
			Book book = service.select(isbn);
			return response(book, HttpStatus.OK, true);
		} catch(RuntimeException e) {
			logger.error("조회 실패",e);
			return response(e.getMessage(), HttpStatus.CONFLICT, false);
		}
	}
	
	@GetMapping("/book")
	@ApiOperation("Book데이터 전체 조회")
	public ResponseEntity<Map<String, Object>> select() {
		try {
			List<Book> books = service.select();
			return response(books, HttpStatus.OK, true);
		} catch(RuntimeException e) {
			logger.error("조회 실패",e);
			return response(e.getMessage(), HttpStatus.CONFLICT, false);
		}
	}
	
	@PostMapping("/book")
	@ApiOperation("book insert")
	public ResponseEntity<Map<String, Object>> insert(@RequestBody Book book) {
		try {
			int result = service.insert(book);
			return response(result, HttpStatus.OK, true);
		} catch(RuntimeException e) {
			logger.error("조회 실패",e);
			return response(e.getMessage(), HttpStatus.CONFLICT, false);
		}
	}
	
	@PutMapping("/book")
	@ApiOperation("book update")
	public ResponseEntity<Map<String, Object>> update(@RequestBody Book book) {
		try {
			int result = service.update(book);
			return response(result, HttpStatus.OK, true);
		} catch(RuntimeException e) {
			logger.error("조회 실패",e);
			return response(e.getMessage(), HttpStatus.CONFLICT, false);
		}
	}
	
	@DeleteMapping("/book/{isbn}")
	@ApiOperation("book delete")
	public ResponseEntity<Map<String, Object>> delete(@PathVariable String isbn) {
		try {
			int result = service.delete(isbn);
			return response(result, HttpStatus.OK, true);
		} catch(RuntimeException e) {
			logger.error("조회 실패",e);
			return response(e.getMessage(), HttpStatus.CONFLICT, false);
		}
	}
	
	private ResponseEntity<Map<String, Object>> response(Object data, HttpStatus httpstatus, boolean status) {
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("status", status);
		resultMap.put("data", data);
		return new ResponseEntity<Map<String,Object>>(resultMap, httpstatus);
	}
}
