<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	request.setCharacterEncoding("utf-8");
	String email = request.getParameter("email");
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("name");
	String auth = "3";
	
	System.out.println(email);
	System.out.println(pwd);
	System.out.println(name);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		MemberDao dao = MemberDao.getInstance();
		boolean isSuccess = dao.addMember(new MemberDto(email, pwd, name, auth));
	%>
	<%if(isSuccess){ %>
	<script>
		alert("가입되었습니다.");
	    location.href = "email.html";
	</script>
	<% } else { %>
	<script>
	    alert("가입 실패했습니다.");
	    location.href = "signUp.jsp?email=" + "<%=email%>";
	</script>
	<%} %>
</body>
</html>