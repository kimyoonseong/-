package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.dto.UserDto;
import com.example.demo.model.entity.User;
import com.example.demo.service.BoardService;
import com.example.demo.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/user")
public class UserController {
	
	private UserService service;
	private BoardService bService;
	
	// 생성자
	public UserController (UserService service, BoardService bService) {
		this.service = service;
		this.bService = bService;
	}
	// 회원가입 빈 화면으로 전달
	@GetMapping("/join")
	public String joinFrom() {
		return "user/join";
	}
	
	// 회원가입 form에서 받은 정보를 전달
	@PostMapping("/join")
	public String doJoin(@ModelAttribute UserDto dto, Model model) {
		try {
			service.join(dto);
//			log.info("join회원가입했습니다:{}", dto.getId());  // 필요한 곳에 같은 패턴으로 로그 달기
			log.info("[join] | id: {}", dto.getId());  // 필요한 곳에 같은 패턴으로 로그 달기
			return "redirect:/"; // 기본적으로는 localhost:8080/ 주소로 이동을 하게 된다. 
		} catch (RuntimeException e) {
			model.addAttribute("msg", dto.getId() + "는 사용할 수 없습니다.");
			return "user/join";
		}
		
	}
	
	@PostMapping("/login")
	public String login(@ModelAttribute UserDto dto, Model model, HttpSession session) {
		try {
			UserDto result = service.login(dto);
			session.setAttribute("loginUser", result);
			log.info("[login] | id: {}", dto.getId());  // 필요한 곳에 같은 패턴으로 로그 달기
			log.debug("id: {}", result.getId());  // 필요한 곳에 같은 패턴으로 로그 달기
			return "redirect:/";
		} catch (Exception e) {
			model.addAttribute("loginmsg", e.getMessage());
			return "index";
		}
	}
	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/secession")
	public String secession(HttpSession session, Model model) {
		UserDto dto = (UserDto)session.getAttribute("loginUser");// 삭제될 id
		String d_id = dto.getId();
		log.info("[secession] | id: {}", dto.getId());  		
		// 회원 탈퇴시 name에 해당하는 id 가져오기
//		User user = dto.toEntity();
//		String d_name = dto.getName();
		bService.deleteAllBoard(d_id);
		
		service.deleteUser(d_id);
		session.invalidate();
		
		return "redirect:/";
	}
}
