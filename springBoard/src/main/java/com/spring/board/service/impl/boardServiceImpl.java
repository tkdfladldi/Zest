package com.spring.board.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardArrVo;
import com.spring.board.vo.BoardMenuVo;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;

@Service
public class boardServiceImpl implements boardService{
	
	@Autowired
	BoardDao boardDao;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectTest();
	}
	
	@Override
	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("pageNo", pageVo.getPageNo());
		
		return boardDao.selectBoardList(map);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardCnt();
	}
	
	@Override
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception {
		// TODO Auto-generated method stub
		BoardVo boardVo = new BoardVo();
		
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		
		return boardDao.selectBoard(boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
			int resultCount = 0;
			
			for(int i=0; i<boardVo.getBoardVoList().size(); i++) {
				
				boardVo.setBoardType(boardVo.getBoardVoList().get(i).getBoardType());
				boardVo.setBoardTitle(boardVo.getBoardVoList().get(i).getBoardTitle());
				boardVo.setBoardComment(boardVo.getBoardVoList().get(i).getBoardComment());
				
				int result = boardDao.boardInsert(boardVo); 			
				resultCount += result; 
			}
		return resultCount;
	}


	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		
		
		return boardDao.boardDelete(boardVo);
			
	}

	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardUpdate(boardVo);
	}

	@Override
	public List<BoardMenuVo> boardMenuSel() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardMenuSel();
	}

	@Override
	public List<BoardVo> serchSelBoard(PageVo pageVo ,String[] boardMenu) throws Exception {
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("pageNo", pageVo.getPageNo());
		map.put("boardMenu", boardMenu);
		
		// TODO Auto-generated method stub
		return boardDao.serchSelBoard(map);
	}
	public BoardVo replaceMathd(BoardVo boardVo) throws Exception{
		
		boardVo.setBoardTitle(boardVo.getBoardTitle().replace("^#^",","));
		boardVo.setBoardComment(boardVo.getBoardComment().replace("^#^",","));
		
		
		
		return boardVo;
		
	}
	
}
