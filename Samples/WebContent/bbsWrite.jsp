<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Object ologin = session.getAttribute("login");
MemberDto mem = null;

if(ologin == null){
%> 
	<script type="text/javascript">
		alert("로그인이 필요한 서비스입니다.");
		location.href = "email.html";
	</script>
<%
}
mem = (MemberDto)ologin;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link async rel="stylesheet" href="css/default.css"> -->

</head>
<body>
	<div class="board__Wrapper">
	<h1>글쓰기</h1>
	<form action="bbsWriteAf.jsp" method="post">
		<table border="1" width="100%">	
			<col width="20%"> <col width="80%">		
			<tr>
				<th>작성자</th>
				<td>
					<%=mem.getEmail() %>
					<input type="hidden" name="email" value="<%=mem.getEmail() %>">
				</td>		
			</tr>
			<tr>
				<th>제목</th>
				<td><input name="title" class="board-write__title"  placeholder="제목" autocomplete="off"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" class="board-write__content" cols="90" rows="10" placeholder="내용을 입력해주세요."></textarea></td>
			</tr>
		</table>
		<button type="button" onclick="location.href='bbsList.jsp'">목록으로</button>
		<button type="submit">글 등록하기</button>
	</form>
	</div>
</body>
</html>