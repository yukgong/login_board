<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int seq = Integer.parseInt(request.getParameter("seq"));

BbsDao dao = BbsDao.getInstance();
BbsDto dto = dao.getBbs(seq);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="board__Wrapper">
	<h1>글 수정하기</h1>
	<form action="bbsUpdateAf.jsp" method="post">
		<table border="1" width="100%">	
			<col width="20%"> <col width="80%">		
			<tr>
				<th>작성자</th>
				<td>
					<%=dto.getEmail() %>
				</td>		
			</tr>
			<tr>
				<th>제목</th>
				<td><input name="title" class="board-write__title"  placeholder="제목" autocomplete="off" value="<%=dto.getTitle() %>"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" class="board-write__content" cols="90" rows="10" placeholder="내용을 입력해주세요." ><%=dto.getContent()%></textarea></td>
			</tr>
		</table>
		<button type="button" onclick="location.href='bbsList.jsp'">취소하기</button>
		<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
		<button type="submit">저장하기</button>
	</form>
	</div>
</body>
</html>