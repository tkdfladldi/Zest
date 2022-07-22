<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<script type="text/javascript">

	var count = 0;
	
	$j(document).ready(function(){
		
		$j("#submit").on("click",function(){
			
			var $frm = $j('.boardWrite :input');

			var param = $frm.serializeArray();
			var i = 0;
			var x = 0;
			$j.each(param, function(key, data)
					{
						
						if(this.name.match('BoardVoList')){
							
							this.name = this.name.replace(/j/gi, i);
							x++
							if(x == 3){
								x = 0;
								i++;
							}
							
						this.value= this.value.replace(/,/gi,"^#^");
						}

					});
			
			$j.ajax({
			    url : "/board/boardWriteAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("작성완료 작성된 글 개수 : " + data.resultCnt);
					
					alert("메세지:"+data.success);
					
					location.href = "/board/boardList.do?pageNo=1";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
		});
		
	});
	
	function rowAdd() {
		
		 
		 var table = document.getElementById('table');
		 
		 var newRow = table.insertRow(table.rows.length-1);
		 var newRow2 = table.insertRow(table.rows.length-1);
		 var newRow3 = table.insertRow(table.rows.length-1);
		
		 // 새로운 title boardComment 행 추가
		 newRow.innerHTML  = table.children[0].children[0].innerHTML;
		 newRow2.innerHTML = table.children[0].children[1].innerHTML;
		 newRow3.innerHTML = table.children[0].children[2].innerHTML;
		 count++;
		
		 // newRow의 자식 input 태그를 찾기 
		 var chekBoxNode = newRow.children[0].children[0];
		 var chekBoxNode2 = newRow2.children[0].children[0];
		 var chekBoxNode3 = newRow3.children[0].children[0];
		 
		 // 새로운 행 input class명 각각 구별하기 위해 변경 
		 var chekBoxClass = chekBoxNode.className += "" + count;
		 var chekBoxClass2 = chekBoxNode2.className += "" + count;
		 var chekBoxClass3 = chekBoxNode3.className += "" + count;
		 
		//새로운 title boardComment 컬럼 class명 각각 구별하기 위해 변경
		 newRow.className += "tr" + count;
		 newRow2.className += "tr" + count;
		 newRow3.className += "tr" + count;
		 
	    
		 
	}
	function rowDelete() {
		var arrayCount = 0;
		
		var chkArray = new Array();
		
		// 체크박스의 전체 개수와 체크박스 NodeList 의 값을 넣는다  
		var obj_length = document.getElementsByName("checkbox").length;
		var boxcheck = document.getElementsByName("checkbox");
		
		// 체크박스의 전체 개수 만큼 for 문을 돌려서 체크가 되어있는 input 정보를 배열에 담는다.
		 for (var i=0; i<obj_length; i++) {
			 if(boxcheck[i].checked){
				chkArray[i] = boxcheck[i];
			 }
		 }
		// 배열 안에 있는 체크박스 부모 노드 찾아서 제거
		
		for (var i=0; i<chkArray.length; i++){
			
			var table = document.getElementById('table');
			var tableRowLen = table.rows.length;
			
			// tablb 행 개수가 3개가 아닐경우에만 행 삭제 가능
			if(tableRowLen != 4){
				if(chkArray[i]){
					var parentNodeName = chkArray[i].parentNode.parentNode.className;	
					
					$j("."+parentNodeName).remove();
					$j("."+parentNodeName).remove();	
					$j("."+parentNodeName).remove();
				}
			}
			
			
		}
		
		
	}
	
	function chekOnclick(box) {
		
		// 하나의 개별 체크 값만 확인
		var chekboxClassName = box.id;
		var bool= box.checked;
		
		if(bool) {
			$j("."+chekboxClassName).prop("checked", true);
		}
		else {
			$j("."+chekboxClassName).prop("checked", false);
		}
	}

</script>
<body>
<form class="boardWrite">
	<table align="center">
		<tr>
			<td align="right">
			<button type="button" onclick="rowAdd();">행추가</button>
			<button type="button" onclick="rowDelete();">행삭제</button>
			<input id="submit" type="button" value="작성">
			</td>
		</tr>
		<tr>
			<td>

				<table border ="1" id="table"> 
					<tr class="tr" id="tr1">
							
							<td width="120" align="center">
							<input type="hidden" onclick="chekOnclick(this);" id="chkBoxId1" class="chekBoxClass" name="checkbox">
							Type		
							</td>
							<td width="400">
							
							<select name="BoardVoList[j].boardType">
								<c:forEach items="${boardMenuVo}" var="list">
									<option value="${list.codeId}">${list.codeName}</option>
								</c:forEach>
							</select>
							
							</td>
					</tr>
				
					<tr class="tr" id="tr2">
						
						<td width="120" align="center">
						<input type="checkbox" onclick="chekOnclick(this);" id="chkBoxId2" class="chekBoxClass" name="checkbox">
						Title		
						</td>
						<td width="400">
						<input name="BoardVoList[j].boardTitle" type="text" size="50" > 
						</td>
					</tr>
					
					<tr class="tr" id="tr3">
						<td height="300" align="center">
						<input type="hidden" onclick="chekOnclick(this);" id="chkBoxId3" class="chekBoxClass" name="checkbox">
						Comment
						</td>
						<td valign="top">
						<textarea name="BoardVoList[j].boardComment"  rows="20" cols="55"></textarea>
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
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
</form>	
</body>
</html>