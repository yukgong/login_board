<%@page import="java.util.Date"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDto mem = (MemberDto)session.getAttribute("login");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>자료 올리기</h1>
	<div align="center">
	<%--
		+---------------------------------------------+
		| email		->	string	form field data		  |
		| title 	->	string					      |
		| contents	->	string						  |
		|---------------------------------------------|
		| file		->	byte	file data <- 파일만 다름  |
		+---------------------------------------------+
	--%>
	
	<form action="pdsUpLoad.jsp" method="post" enctype="multipart/form-data"> 
	<!-- enctype - multipart를 꼭 붙여야함. 폼과 파일을 같이 업로드하기 때문에 업로드하는 데이터타입이 다르다. 따라서 특별한 처리 필요-->
	
	<table border="1">
		<col width="200">
		<col width="500">
		
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" name="email" value="<%=mem.getEmail() %>" readonly="readonly">
			</td>
		</tr>
		
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="title" size="50">
			</td>
		</tr>
		<tr>
			<th>파일 업로드</th>
			<td>
				<input type="file" name="fileUpLoad" size="with:400px">
			</td>
		</tr>
		
		<tr>
			<th>내용</th>
			<td>
				<textarea rows="20" cols="50" name="content"></textarea>
			</td>
		</tr>
		
		<tr align="center">
			<td colspan="2">
				<input type="submit" value="올리기">
			</td>
		</tr>
	</table>
					
	</form>
	</div>
</body>
</html>