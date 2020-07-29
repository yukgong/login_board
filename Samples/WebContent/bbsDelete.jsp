<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int seq = Integer.parseInt(request.getParameter("seq"));
	BbsDao dao = BbsDao.getInstance();
	boolean isSuccess = dao.bbsDelete(seq);
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
			alert("삭제 성공");
			location.href = "bbsList.jsp";
		</script>
	<%} else { %>
		<script type="text/javascript">
			alert("삭제 실패");
			history.back();
		</script>
	<%} %>
</body>
</html>