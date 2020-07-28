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
</head>
<body>
	<h1>글쓰기</h1>
	<form action="bbsWriteAf.jsp" method="post">
		<div>
			<span>id : <%=mem.getEmail() %></span>
			<input type="hidden" name="email" value="<%=mem.getEmail() %>">
		</div>
		
		<input name="title" class="board-write__title" placeholder="제목">
		<textarea name="content" class="board-write__content" placeholder="내용을 입력해주세요."></textarea>
		<button type="button" onclick="location.href='bbsList.jsp'">목록으로</button>
		<button type="submit">글 등록하기</button>
	</form>
</body>
</html>