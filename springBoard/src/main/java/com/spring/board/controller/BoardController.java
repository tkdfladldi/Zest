package com.spring.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardArrVo;
import com.spring.board.vo.BoardMenuVo;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo, String[] codeId) throws Exception{
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		
		int page = 1;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);;
		}
		
		boardList = boardService.SelectBoardList(pageVo);
		List<BoardMenuVo> boardMenulist = boardService.boardMenuSel(); 
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", boardList.size());
		model.addAttribute("pageNo", page);
		model.addAttribute("boardMenuVo",boardMenulist);
		
		
		return "board/boardList";
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		
		List<BoardMenuVo> ListboardMenuVo =  boardService.boardMenuSel();
		model.addAttribute("boardMenuVo", ListboardMenuVo);
		
		return "board/boardWrite";
	}
	
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody	
	public HashMap<String, String> boardWriteAction(Locale locale,BoardVo boardVo) throws Exception{
		HashMap<String, String> result = new HashMap<String, String>();
		
		
		CommonUtil commonUtil = new CommonUtil();
		int resultCnt = boardService.boardInsert(boardVo);		
		
		
		// success 메시지와 결과 카운트 값을 맵에 담아 보낸다.
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		result.put("callbackMsg", callbackMsg);
		result.put("resultCnt" , String.valueOf(resultCnt));
		
		System.out.println("callbackMsg::"+callbackMsg);
			
			
	return result;
		
			
		
	}
	@ResponseBody
	@RequestMapping(value = "/board/boardDelete.do", method = RequestMethod.POST)
	public int boardDelete(BoardVo boardVo) throws Exception{
		
		int resultCnt = boardService.boardDelete(boardVo);
				
		return resultCnt;
	}
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardUpdate.do", method = RequestMethod.GET)
	public String boardUpdateGet(Model model ,
							  @PathVariable("boardType")String boardType
		                     ,@PathVariable("boardNum")int boardNum ) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		List<BoardMenuVo> ListboardMenuVo =  boardService.boardMenuSel();
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("board",boardVo);
		model.addAttribute("boardMenu",ListboardMenuVo);
		
		return "board/boardUpdate";
	}
	@ResponseBody
	@RequestMapping(value = "/board/boardUpdate.do", method = RequestMethod.POST)
	public String boardUpdatePost(BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardUpdate(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	@ResponseBody
	@RequestMapping(value = "/board/boardSerchList.do", method = RequestMethod.GET)
	public List<BoardVo> boardSerchList(PageVo pageVo ,String[] boardMenu) throws Exception{
		
			int page = 1;
					
			if(pageVo.getPageNo() == 0){
				pageVo.setPageNo(page);;
			}
			List<BoardVo> listBoardVo= boardService.serchSelBoard(pageVo ,boardMenu);	
			
			return listBoardVo;
		
	}
	
	
}
