package com.example.demo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.example.demo.controller.BoardController;
import com.example.demo.model.dto.BoardDto;
import com.example.demo.model.entity.Board;
import com.example.demo.model.entity.User;
import com.example.demo.repository.BoardRepository;
import com.example.demo.repository.UserRepository;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
public class BoardService {
	
	private BoardRepository brepo;
	private UserRepository urepo;
	
	// controller에서 값을 받아올 생성자
	@Autowired
	public BoardService(BoardRepository brepo, UserRepository urepo) {
		this.brepo = brepo;
		this.urepo = urepo;
	}
	
	public void writeBoard(BoardDto dto) {
		String userId = dto.getUser_Id(); // 누가 글 썼는지 필요
		User user = urepo.getReferenceById(userId);
		Board board = dto.toEntity();
		board.setUser(user);
		brepo.saveAndFlush(board);
		log.info("[regist] | id: {} title:{} no:{} ]", dto.getUser_Id(),board.getTitle(),board.getNo());  
		  
	}
	
	// 전체읽기 - 페이지로 끊어서 값을 가지고 오는 방법 존재 - 221p
	public Page<Board> listBoard(int page){
		// 최신순 정렬 - 내림차순
		Pageable pageable = PageRequest.of(page, 10, Direction.DESC, "no");
		Page<Board> pageInfo = brepo.findAll(pageable);
		return pageInfo;
	}
	public List<Board> searchByTitle(String query) {
	    // 여기서 실제로 데이터베이스에서 검색 수행
		
		List<Board> searchResults = brepo.findByTitleContaining(query); // 값의 존재 확인 가능
		return searchResults;
	}
	


	// 하나읽기
	public Board detailBoard(int no) {
		// 값이 없는 경우 종료되는게 아니라 에러를 제시하기 위해
		Optional<Board> option = brepo.findById(no); // 값의 존재 확인 가능
		if (option.isPresent()) {
			return option.get();
		} else {
			throw new RuntimeException(no + "라는 글은 없습니다.");
		}
	}
		
		// 수정 - put 사용
		
		
		// 삭제
	public void deleteBoard(int no) {	
		brepo.deleteById(no);		
	}
	
	@Transactional
	public void deleteAllBoard(String d_id) {
		// EntityManager를 사용하는 메서드는 트랜잭션 내에서 실행되어야 합니다. 
		brepo.deleteAllByUser_Id(d_id);
	}
	

	public void plusLike(Integer boardId) {
//		Board board = dto.toEntity();
//		// 현재 좋아요 개수를 가져오기
//	    Integer currentLikes = board.getLikeRecipe();
//	   
//	    // 좋아요 개수가 null이면 1로 초기화, 그렇지 않으면 현재 값에 1 더하기
//	    int updatedLikes = (currentLikes == null) ? 1 : currentLikes + 1;
//	    // 증가된 좋아요 개수를 Board 엔티티에 설정
//	    board.setLikeRecipe(updatedLikes);
//	    brepo.saveAndFlush(board);	
		 // 게시물 번호를 기반으로 기존 게시물 엔티티를 찾기
		Optional<Board> optionalBoard = brepo.findById(boardId);

        if (optionalBoard.isPresent()) {
            Board board = optionalBoard.get();
            int currentLikes = board.getLikeRecipe();
            board.setLikeRecipe(currentLikes + 1);
            brepo.save(board);
        } else {
            throw new RuntimeException("게시물을 찾을 수 없습니다.");
        }
	}
	
	public void minusLike(Integer boardId) {
		
		// 현재 싫어요 개수를 가져오기
		Optional<Board> optionalBoard = brepo.findById(boardId);

        if (optionalBoard.isPresent()) {
            Board board = optionalBoard.get();
            int currentLikes = board.getUnlikeRecipe();
            board.setUnlikeRecipe(currentLikes + 1);
            brepo.save(board);
        } else {
            throw new RuntimeException("게시물을 찾을 수 없습니다.");
        }
		
	}
	
//	 좋아요 순으로 페이지로 끊어서 값을 가지고 오기
	public Page<Board> listRankBoard(int page){
		// 좋아요 순 정렬 - 내림차순
		Pageable pageable = PageRequest.of(page, 10, Direction.DESC, "likeRecipe");
		//Page<Board> pageInfo = brepo.findAll(pageable);
		
		 // 좋아요가 null일 때는 0으로 처리
	    Page<Board> pageInfo = brepo.findAll(pageable);
	    //List<Board> rankedBoards = pageInfo.getContent();

	  
//	    rankedBoards.forEach(board -> {
//	        if (board.getLike() == null) {
//	            board.setLike(0);
//	        }
//	    });
		return pageInfo;
		
	}
	//조회수 증가 로직
	
	public void increaseViews(Integer boardId) {
		Optional<Board> optionalBoard = brepo.findById(boardId);

        if (optionalBoard.isPresent()) {
            Board board = optionalBoard.get();
            int currentViews = board.getAllViews1();
            board.setAllViews1(currentViews + 1);
            brepo.save(board);
        } else {
            throw new RuntimeException("게시물을 찾을 수 없습니다.");
        }
    }
	
}
