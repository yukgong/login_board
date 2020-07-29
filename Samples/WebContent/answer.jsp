<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String strSeq = request.getParameter("seq");
	int seqNum = Integer.parseInt(strSeq);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	BbsDao dao = BbsDao.getInstance();
	BbsDto parentBbs = dao.getBbs(seqNum); 
	
	MemberDto mem = (MemberDto)session.getAttribute("login");
%>
<%--
기본글 <table>
	작성자
	제목
	작성일
	조회수
	정보
	내용
--%>
	<h1><%=parentBbs.getTitle()%></h1>
	<table border="1" width="100%">
		<col width="20%"><col width="80%">
		<tr>
			<th>작성자</th>
			<td><%=parentBbs.getEmail()%></td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><%=parentBbs.getWdate()%></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%=parentBbs.getReadcount()%></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><%=parentBbs.getContent()%></td>
		</tr>
	</table>
	<button type="button" onclick="location.href='bbsList.jsp'">목록으로</button>
	<%
	if(parentBbs.getEmail().equals(mem.getEmail())){
		%>
		<button type="button" onclick="updateBbs(<%=parentBbs.getSeq()%>)">수정하기</button>
		<button type="button" onclick="deleteBbs(<%=parentBbs.getSeq()%>)">삭제하기</button>
		<%
	}
	%>

<%--
답글	<table>
	login id <- 세션에 저장된 아이디
	제목
	내용
--%>
	<h1>답글 달기</h1>
	<form action="answerAf.jsp" method="post">
		<table border="1" width="100%">
			<col width="20%"><col width="80%">
				<tr>
					<th>작성자</th>
					<td>
						<%=mem.getEmail() %>
						<input type="hidden" name="email" value="<%=mem.getEmail() %>">
					</td>		
				</tr>
				<tr>
					<th>제목</th>
					<td><input name="title" class="board-write__title" placeholder="제목"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="content" class="board-write__content" cols="100" rows="10" placeholder="내용을 입력해주세요."></textarea></td>
				</tr>
		</table>
		<button type="button" onclick="history.back()">취소</button>
		<input type="hidden" name="seq" value="<%=parentBbs.getSeq()%>"> <!-- 시퀀스 번호 날려주기 -->
		<button type="submit">댓글 등록하기</button>
	</form>
</body>
</html>