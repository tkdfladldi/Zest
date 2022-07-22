<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">

	function allClick(checkBox) {
		// 체크 박스 정보 가져오기
		var checkBoxs =	document.getElementsByName('munuCheckbox');
		var className = checkBoxs[0].className;
		
		// 체크가 됐을경우 전체 체크 아닐경우 전체 체크해제
		if(checkBox.checked){
			
		$j("."+className).prop("checked", true);
		
		}else{
			$j("."+className).prop("checked", false);
		}
	}
	function checkClick() {
		var arr = [];
		//전체 체크박스가 클릭되어 있는지 
		var allCheckBox = document.getElementsByName('munuCheckbox');
		allCheckBox = allCheckBox[0].checked;
		
		var menuCheckBox = document.getElementsByName('boardMenu');
		
		for(var i= 0; i<menuCheckBox.length; i++){
			if(menuCheckBox[i].checked){
				arr.push(menuCheckBox[i].checked);
			}
		}
		if(arr.length <= menuCheckBox.length-1){
			$j("#allClickId").prop("checked", false);
		}
		if(arr.length == menuCheckBox.length){
			$j("#allClickId").prop("checked", true);
		}
	}
	function manuserch() {
		
		
		var param = [];
		
		var checkBoxs =	document.getElementsByClassName('menuClass');
		
		for(var i = 1; i<checkBoxs.length; i++){
			if(checkBoxs[i].checked){
				param.push(checkBoxs[i]);
			}
		}
		$j.ajax({
		    url : "/board/boardSerchList.do",
		    dataType: "json",
		    type: "GET",
		    data : param,
		    success: function(data, textStatus, jqXHR)
		    {
		    	var firstTable = document.getElementsByClassName('firstTable');
		    	var table = document.getElementsByClassName('boardList');
		    	var tableLength = table.length;
		    	var html = "";
		    	
				//total 카운트 text 값 변경
		    	firstTable[0].children[0].children[0].children[0].textContent = "total : "+data.length+"";
				
				// 반복문으로 게시판 기존 리스트 제거 후 새로운 리스트 값 넣기
		    	for(var i = 0; i < tableLength; i++){
		    		table[0].remove();
		    	}
		    	for(var i = 0; i < data.length; i++){
		    		html += "<tr class=\"boardList\">";
		    		html += "<td align=\"center\">";
		    		html += ""+data[i].boardMenu+"";
		    		html += "</td>";
		    		html += "<td>";
		    		html += ""+data[i].boardNum+"";
		    		html += "</td>";
					html += "<td>";
					html += "<a href = /board/"+data[i].boardType+"/"+data[i].boardNum+"/boardView.do?pageNo=1>"+data[i].boardTitle+"</a>";
		    		html += "</td>";
		    		html += "</tr>";
		    	}
		    	$j("#boardTable").append(html);
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("실패");
		    }
		});
		
	}

</script>
<body>
<table  align="center" class="firstTable">
	<tr>
		<td align="right">
			total : ${totalCnt}
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				<c:forEach items="${boardList}" var="list">
					<tr class="boardList">
						<td align="center">
							${list.boardMenu}
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>	
				</c:forEach>
				
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">글쓰기</a>
		</td>
	</tr>
	<tr align="left">
			<td align="left">
					<input type="checkbox" id="allClickId" class="menuClass" name="munuCheckbox" onclick="allClick(this);" value="all">전체
				<c:forEach items="${boardMenuVo}" var="list" varStatus="status">
					<input onclick="checkClick();" type="checkbox" class="menuClass" id="menu${status.index}" name="boardMenu" value="${list.codeId}">${list.codeName}
				</c:forEach>
				<button type="button" onclick="manuserch();">조회</button>
			</td>
	</tr>
</table>	
</body>
</html>