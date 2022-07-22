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
					alert("�ۼ��Ϸ� �ۼ��� �� ���� : " + data.resultCnt);
					
					alert("�޼���:"+data.success);
					
					location.href = "/board/boardList.do?pageNo=1";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("����");
			    }
			});
		});
		
	});
	
	function rowAdd() {
		
		 
		 var table = document.getElementById('table');
		 
		 var newRow = table.insertRow(table.rows.length-1);
		 var newRow2 = table.insertRow(table.rows.length-1);
		 var newRow3 = table.insertRow(table.rows.length-1);
		
		 // ���ο� title boardComment �� �߰�
		 newRow.innerHTML  = table.children[0].children[0].innerHTML;
		 newRow2.innerHTML = table.children[0].children[1].innerHTML;
		 newRow3.innerHTML = table.children[0].children[2].innerHTML;
		 count++;
		
		 // newRow�� �ڽ� input �±׸� ã�� 
		 var chekBoxNode = newRow.children[0].children[0];
		 var chekBoxNode2 = newRow2.children[0].children[0];
		 var chekBoxNode3 = newRow3.children[0].children[0];
		 
		 // ���ο� �� input class�� ���� �����ϱ� ���� ���� 
		 var chekBoxClass = chekBoxNode.className += "" + count;
		 var chekBoxClass2 = chekBoxNode2.className += "" + count;
		 var chekBoxClass3 = chekBoxNode3.className += "" + count;
		 
		//���ο� title boardComment �÷� class�� ���� �����ϱ� ���� ����
		 newRow.className += "tr" + count;
		 newRow2.className += "tr" + count;
		 newRow3.className += "tr" + count;
		 
	    
		 
	}
	function rowDelete() {
		var arrayCount = 0;
		
		var chkArray = new Array();
		
		// üũ�ڽ��� ��ü ������ üũ�ڽ� NodeList �� ���� �ִ´�  
		var obj_length = document.getElementsByName("checkbox").length;
		var boxcheck = document.getElementsByName("checkbox");
		
		// üũ�ڽ��� ��ü ���� ��ŭ for ���� ������ üũ�� �Ǿ��ִ� input ������ �迭�� ��´�.
		 for (var i=0; i<obj_length; i++) {
			 if(boxcheck[i].checked){
				chkArray[i] = boxcheck[i];
			 }
		 }
		// �迭 �ȿ� �ִ� üũ�ڽ� �θ� ��� ã�Ƽ� ����
		
		for (var i=0; i<chkArray.length; i++){
			
			var table = document.getElementById('table');
			var tableRowLen = table.rows.length;
			
			// tablb �� ������ 3���� �ƴҰ�쿡�� �� ���� ����
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
		
		// �ϳ��� ���� üũ ���� Ȯ��
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
			<button type="button" onclick="rowAdd();">���߰�</button>
			<button type="button" onclick="rowDelete();">�����</button>
			<input id="submit" type="button" value="�ۼ�">
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