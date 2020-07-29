<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	request.setCharacterEncoding("utf-8");

	int seq = Integer.parseInt(request.getParameter("seq")); 
	// 시퀀스 번호를 받아오는 목적 : ref(그룹 번호) 설정하는 것이 목적
	
	String email = request.getParameter("email");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	System.out.println(seq);
	System.out.println(email);
	System.out.println(title);
	System.out.println(content);
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
	boolean isSuccess = dao.answer(seq, new BbsDto(email, title, content));
	
	if(isSuccess){
	%>
		<script type="text/javascript">
		alert("답글 입력 성공!");
		location.href = "bbsList.jsp";
		</script>		
	<%	
	} else {
	%>
		<script type="text/javascript">
		alert("답글 입력 실패");
		location.href = "bbsList.jsp";
		</script>
	<%	
	}
%>
</body>
</html>























