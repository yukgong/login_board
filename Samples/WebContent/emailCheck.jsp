<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	String email = request.getParameter("email");
	MemberDao dao = MemberDao.getInstance();
	boolean alreadySignUp = dao.getId(email);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%if(alreadySignUp){ %>
	<script>
	    location.href = "password.jsp?email=" + "<%=email%>";
	</script>
	<% } else { %>
	<script>
	    alert("가입되어 있지 않은 ID입니다.");
	    location.href = "signUp.jsp?email=" + "<%=email%>";
	</script>
	<%} %>
</body>
</html>