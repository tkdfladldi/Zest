package com.spring.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.spring.board.vo.BoardMenuVo;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;

public interface BoardDao {

	public String selectTest() throws Exception;

	public List<BoardVo> selectBoardList(Map<String,Object> map) throws Exception;

	public BoardVo selectBoard(BoardVo boardVo) throws Exception;

	public int selectBoardCnt() throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;
	
	public int boardDelete(BoardVo boardVo) throws Exception;
	
	public int boardUpdate(BoardVo boardVo) throws Exception;
	
	public List<BoardMenuVo> boardMenuSel() throws Exception;
	
	public List<BoardVo> serchSelBoard(Map<String,Object> map) throws Exception;
}	
