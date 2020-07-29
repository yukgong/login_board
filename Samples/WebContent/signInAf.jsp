<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	request.setCharacterEncoding("utf-8");
	String email = request.getParameter("email");
	String pwd = request.getParameter("pwd");
	
	System.out.println(email);
	System.out.println(pwd);
	
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
		MemberDto mem = dao.login(email, pwd);
		
		if(mem != null && !mem.getEmail().equals("")){
			// login 정보 저장
			session.setAttribute("login", mem);
			session.setMaxInactiveInterval(30*60*30);
		%>
			<script type="text/javascript">
<%-- 			alert("안녕하세요 <%=mem.getName()%>님"); --%>
			location.href= "./bbsList.jsp";
			</script>
		<%
		} else {
		%>
			
		<%
		}
	%>
</body>
</html>