package com.example.demo.model.entity;

import com.example.demo.model.dto.BoardDto;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder // 생성자 대신 빌더 패턴 사용
@Entity
@ToString(exclude = "user") // 순환참조 방지
public class Board {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)//자동 글번호 생성
	private int no;// 게시판 글 번호
	private String title;//레시피 글 제목
	private String content;//레시피
	private int like;
	private int unlike;
	@ManyToOne
	@JoinColumn(name="user_id")//Select * from user where id=??
	User user;
	
	public BoardDto toDto() { 
		BoardDto dto = new BoardDto();
		dto.setNo(this.getNo());
		dto.setTitle(this.getTitle());
		dto.setContent(this.getContent());
		dto.setUser_Id(this.getUser().getId());
		dto.setLike(this.getLike());
		dto.setUnlike(this.getUnlike());
		return dto;
	}
}
