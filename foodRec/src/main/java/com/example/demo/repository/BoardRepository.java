package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.demo.model.entity.Board;
//
public interface BoardRepository  extends JpaRepository<Board,Integer>{

	List<Board> findByTitleContaining(String query);
	
	void deleteAllByUser_Id(String d_id);
//	void deleteAllByUser(User user);

}
