<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>login</title>
</head>
<script type="text/javascript">

</script>
<body>
<form class="boardWrite">
	<table align="center">
		<tr>
			<td>
				<h2>로그인</h2>
				<table border ="1"> 
					<tr>
						<td width="120" align="center">
							아이디
						</td>
						<td width="120">
						<input name=" " type="text" size="25" > 
						</td>
					</tr>
					
					<tr>
						<td align="center">
							비밀번호
						</td>
						<td valign="top">
						<input name=" " type="password" size="25" > 
						</td>
					</tr>
				</table>
			</td>
			
		<tr>
			<td align="left">
				<a href="#">확인</a>
			</td>
			<td colspan="2">
				<a href="/member/register.do">회원가입</a>
			</td>
		</tr>
	</table>
</form>	
</body>
</html>