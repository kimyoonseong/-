package com.example.demo.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.model.dto.BoardDto;
import com.example.demo.model.entity.Board;
import com.example.demo.service.BoardService;

import jakarta.servlet.ServletContext;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board")
public class BoardController {
	private BoardService service;
	
	@Autowired
	private ServletContext servletContext; // 현재 파일이 실행중인 경로 등을 상대경로로 사용하기 위해
	
	@Value("${upload.path}") // application.properties에 설정한 upload.path의 값을 가져옵니다.
	private String uploadPath;
	
	//객체 생성자
	public BoardController(BoardService service) {
		this.service=service;
	}
	
	@GetMapping("/regist")
	public String registForm() {
		return "board/registboard"; // /WEB-INF/view/registboard.jsp
	}
	
	// 레시피를 form으로 받아서 전달
	@PostMapping("/regist")
	public String registBoard(BoardDto boardDto) {
		MultipartFile imageFile = boardDto.getImage();
		String originalFilename = imageFile.getOriginalFilename();
		String uploadDir = servletContext.getRealPath("/upload/"); // 현재 JSP 파일의 실행중 위치 + getRealPath의 파라미터로 삽입한 경로

		// String filePath = uploadPath + originalFilename; // 여기선 절대경로 가져와서 사용한 것
	
		String filePath = uploadDir + originalFilename;
		System.out.println(filePath);
		try {
			imageFile.transferTo(new File(filePath));
		} catch (IOException e) {
			e.printStackTrace();
		}
	
		boardDto.setImagePath(originalFilename); // Set the image path
		service.writeBoard(boardDto);
		return "redirect:/";
	}
	// 레시피 목록 출력
	@GetMapping("/list")  // Model - spring ui 입력받은 값을 바로 화면에서 ${ }로 사용할 수 있는 requestScope로 전달
	public String list(@RequestParam(required = false, defaultValue =  "1") Integer page, Model model) { 
		page--;
		Page<Board> pageInfo = service.listBoard(page);
		model.addAttribute("pageInfo", pageInfo);
		
		log.debug("page: {}",page);
		log.debug("pageInfo: {}",pageInfo);
		return "board/list";

	} 
	//특정 레시피 조회 
	@GetMapping("/detail")
	public String detail(@RequestParam int no, Model model) {
		try {
			Board board = service.detailBoard(no);
			model.addAttribute("board", board);  // ${board.title} ${board.content}
			return "/board/detail";
		} catch (RuntimeException e) { // 없는 글번호를 요청했을 때 
			return "/board/list";  // /WEB-INF/view/list.jsp
		}
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam int no) {
		log.debug("board no:{}", no);
		service.deleteBoard(no);
		
		return"redirect:/board/list";
	}
	
	@PostMapping("/update")
	public String update(@ModelAttribute BoardDto boardDto, Model model) {
		log.debug("board 수정: {}", boardDto);
		MultipartFile imageFile = boardDto.getImage();
		String originalFilename = imageFile.getOriginalFilename();
		String uploadDir = servletContext.getRealPath("/upload/"); // 현재 JSP 파일의 실행중 위치 + getRealPath의 파라미터로 삽입한 경로
	
		String filePath = uploadDir + originalFilename;
		
		try {
			imageFile.transferTo(new File(filePath));
		} catch (IOException e) {
			e.printStackTrace();
		}
	
		boardDto.setImagePath(originalFilename); // 파일명에 경로 저장
		service.writeBoard(boardDto);
		return "redirect:/board/detail?no=" +boardDto.getNo();
	}
	//좋아요기능
	@PostMapping("/recommend")
	public String recommendPosts(@RequestParam("no") Integer boardId) {
		service.plusLike(boardId);
		return "redirect:/board/detail?no="+boardId;
		
	}
	//싫어요기능
	@PostMapping("/notrecommend")
	public String unlike(@RequestParam("no") Integer boardId) {
		service.minusLike(boardId);
		return "redirect:/board/detail?no="+boardId;
	}
	//레시피 랭킹 목록 페이지
//	@GetMapping("/Rank")  
//	public String Rank(@RequestParam(required = false, defaultValue =  "1") Integer page, Model model) { 
//		page--;
//		Page<Board> pageInfo = service.listRankBoard(page);
//		model.addAttribute("pageInfo", pageInfo);
//		
//		log.debug("page: {}",page);
//		log.debug("pageInfo: {}",pageInfo);
//		return "board/list";
//
//	}
}
