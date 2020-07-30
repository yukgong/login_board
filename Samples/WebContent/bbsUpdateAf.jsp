<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	int seq = Integer.parseInt(request.getParameter("seq"));
	
	System.out.println(title);
	System.out.println(content);
	System.out.println(seq);
	
	BbsDao dao = BbsDao.getInstance();
	boolean isSuccess = dao.updateBbs(title, content, seq);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%if(isSuccess){ %>
		<script type="text/javascript">
			alert("수정이 완료되었습니다.");
			location.href = "bbsList.jsp";
		</script>
	<%} else { %>
		<script type="text/javascript">
			alert("수정 실패");
			history.back();
		</script>
	<%} %>
</body>
</html>