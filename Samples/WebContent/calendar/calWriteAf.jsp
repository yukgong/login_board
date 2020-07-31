<%@page import="calendarEx.CalendarDto"%>
<%@page import="calendarEx.CalendarDao"%>
<%@page import="util.utilEx"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%--
	calWrite.jsp에서 넘어온 값들 : 
	email, title, content, 연,월,날,시,분 
	--%>
		
	<%	
		request.setCharacterEncoding("utf-8");
	
		String email = request.getParameter("email");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		String year= request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String hour = request.getParameter("hour");
		String min = request.getParameter("min");

		// 2020/07/31 14:52 -> 202007311452로 형식 만들어서 RDATE에 올려주기
		String rdate = year + utilEx.two(month) + utilEx.two(day) + utilEx.two(hour) + utilEx.two(min);
		
		// 받아온 데이터를 dao에 넣어주기
		CalendarDao dao = CalendarDao.getInstance();
		boolean isSuccess = dao.addcalendar(new CalendarDto(email, title, content, rdate));
		
		if(isSuccess){
		%>
			<script type="text/javascript">
			alert("o_o 성공");
			location.href = "calendar.jsp";
			</script>
		<%} else {%>
			<script type="text/javascript">
			alert("실패");
			history.back();
			</script>
		<%}%>
</body>
</html>