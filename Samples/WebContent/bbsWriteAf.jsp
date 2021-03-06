<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String email = request.getParameter("email");
	String title = request.getParameter("title");
	String content = request.getParameter("content");

	BbsDao dao = BbsDao.getInstance();
	BbsDto dto = new BbsDto(email, title, content);
	boolean isSuccess = dao.writeBbs(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%if(isSuccess){%>
		<script type="text/javascript">
			alert("글 등록이 완료되었습니다.");
			location.href = "bbsList.jsp";
		</script>
	<%} else { %>
		<script type="text/javascript">
			alert("등록 실패");
			history.back();
		</script>
	<%} %>
</body>
</html>