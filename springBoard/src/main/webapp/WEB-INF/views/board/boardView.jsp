<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>
	<script type="text/javascript">
	
	function boardDelete(boardNum,boardType) {
		   if (confirm("게시글을 삭제하시겠습니까?")) {
				$j.ajax({
				    url : "/board/boardDelete.do",
				    dataType: "json",
				    type: "POST",
				    data :  {"boardNum" : boardNum, "boardType" : boardType},
				    success: function(data, textStatus, jqXHR)
				    {
				    	if(data > 0){
						alert("삭제 성공");
						
						location.href = "/board/boardList.do?pageNo=1";		    		
				    	}else{
				    		alert("삭제된 내용이 없음");
				    	}
				    	
				    	
				    },
				    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	alert("실패");
				    }
				});
		   } else{
		          false;
		   }
	}
	</script>
<body>
<table align="center">
	<tr>
		<td>
			<table border ="1">
				<tr>
					<td width="120" align="center">
					type
					</td>
					<td width="400">
					${board.boardMenu}
					</td>
				</tr>
				<tr>
					<td width="120" align="center">
					Title
					</td>
					<td width="400">
					${board.boardTitle}
					</td>
				</tr>
				<tr>
					<td height="300" align="center">
					Comment
					</td>
					<td>
					${board.boardComment}
					</td>
				</tr>
				<tr>
					<td align="center">
					Writer
					</td>
					<td>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<button onclick="boardDelete(${board.boardNum}, '${board.boardType}');">삭제</button>
			<a href="/board/${board.boardType}/${board.boardNum}/boardUpdate.do">수정</a>
			<a href="/board/boardList.do">List</a>
		</td>
	</tr>
</table>	
</body>
</html>