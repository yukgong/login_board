<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String seq = request.getParameter("seq");
	
	BbsDao dao = BbsDao.getInstance();
	BbsDto dto = dao.getDetail(Integer.parseInt(seq));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>제목 : <%=dto.getTitle() %></h1>
	<h4>작성자 : <%=dto.getEmail() %></h4>
	<p>내용 : <%=dto.getContent() %></p>
	<p>조회수 : <%=dto.getReadcount() %></p>
</body>
</html>