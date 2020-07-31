<%@page import="util.utilEx"%>
<%@page import="java.util.List"%>
<%@page import="calendarEx.CalendarDto"%>
<%@page import="java.util.Calendar"%>
<%@page import="calendarEx.CalendarDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
// nvl 함수
public boolean nvl(String msg){
	return msg == null || msg.trim().equals("") ? true : false; // 대입 받은게 빈문자열이면 true
}
%>

<%
Object ologin = session.getAttribute("login");
MemberDto mem = null;
if(ologin == null){
	// 임시로 코드를 짜 두었는데 기능을 추가하면,
	// 아래 경로에서 로그인 설정을 다양하게 줄 수 있음
	response.sendRedirect("goCheck.jsp?proc=login"); 
}

mem = (MemberDto)ologin;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4>환영합니다.<%=mem.getName()%>님</h4>
	<%
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DATE, 1);
		
		String strYear = request.getParameter("year");
		String strMonth = request.getParameter("month");
		String strDay = request.getParameter("day");
		
		int year = cal.get(Calendar.YEAR);
		if(nvl(strYear) == false){ // 파라미터가 넘어왓을 때
			year = Integer.parseInt(strYear);
		}
		
		int month = cal.get(Calendar.MONTH) + 1;
		if(nvl(strMonth) == false){ // 파라미터가 넘어왓을 때
			month = Integer.parseInt(strMonth);
		}
		
		if(month < 1){
			month = 12;
			year--;
		}
		if(month > 12){
			System.out.println("month : " + month);
			month = 1;
			year++;
		}
		
		cal.set(year, month - 1, 1); // 연, 월, 일 셋팅 완료
		
		// 요일
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
		
		// << 연도 뒤로 이동( year-- )
		String pp = String.format("<a href='%s?year=%d&month=%d'>" 
						+ 	"<img src='../img/left.gif'></a>", 
							"calendar.jsp", year - 1, month);
		
		// < 월 뒤로 이동 ( month-- ) 
		String p = String.format("<a href='%s?year=%d&month=%d'>" 
						+ 	"<img src='../img/prec.gif'></a>", 
							"calendar.jsp", year, month - 1);
		
		// > 월 앞으로 이동 ( month++ ) 
		String n = String.format("<a href='%s?year=%d&month=%d'>" 
						+ 	"<img src='../img/next.gif'></a>", 
							"calendar.jsp", year, month + 1);
		
		// >> 연도 앞으로 이동 ( year++ )
		String nn = String.format("<a href='%s?year=%d&month=%d'>" 
				+ 	"<img src='../img/last.gif'></a>", 
					"calendar.jsp", year + 1, month);
		
		CalendarDao dao = CalendarDao.getInstance();
		List<CalendarDto> list = dao.getCalendarList(mem.getEmail(), year + utilEx.two(month + ""));
	%>
	
	<div align="center">
		<table border="1" width="100%">
			<col width="calc(100%/7)"><col width="calc(100%/7)"><col width="calc(100%/7)"><col width="calc(100%/7)">
			<col width="calc(100%/7)"><col width="calc(100%/7)"><col width="calc(100%/7)">
			
			<!-- 날짜 이동 -->
			<tr height="100">
				<td colspan="7" align="center">
					<%=pp %>&nbsp;&nbsp;<%=p %>&nbsp;
				
					<h2 style="display: inline-block;">
						<%=String.format("%d년&nbsp;&nbsp;%2d월", year, month) %>
					</h2>
					
					<%=n %>&nbsp;&nbsp;<%=nn %>
				</td>
			</tr>
			
			<tr>
				<th align="center"> 일 </th>
				<th align="center"> 월 </th>
				<th align="center"> 화 </th>
				<th align="center"> 수 </th>
				<th align="center"> 목 </th>
				<th align="center"> 금 </th>
				<th align="center"> 토 </th>
			</tr>
			
			<tr height="100" align="left" valign="top">
				<% // 달력 폼의 위쪽 빈칸 만들기
					for(int i = 0; i < dayOfWeek-1; i++) {
					%>
					<td style="background-color: red">&nbsp;</td>	
				<% } %>
			
			<%-- 날짜 --%>
			<%
				int lastday = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
				for(int i = 1; i <= lastday; i++){
					%>
					<td>
						<%=utilEx.dayList(year, month, i)%>&nbsp;&nbsp;<%=utilEx.showPen(year, month, i)%>
						<%=utilEx.makeTable(year, month, i, list) %>
					</td>
			<%	
				if((i + dayOfWeek - 1) % 7 == 0 &&  i != lastday){ %>
					<tr><tr height="100" align="left" valign="top">
			<% }
			} %>
			
			<%-- 밑칸 --%>
			<%
			cal.set(Calendar.DATE, lastday); // 그 달의 마지막 날짜로 세팅한다.
			int weekday = cal.get(Calendar.DAY_OF_WEEK);
			for(int i = 0; i < 7 - weekday; i++ ){%>
				<td style="background-color: yellow"></td>
			<% } %>
			</tr>
		</table>
	</div>
	
	<%--
		calDetail.jsp -> 그날의 제목 내용을 볼 수 있음
		calList.jsp -> 일별일정을 모두 볼 수 있음
		calUpdate.jsp -> 수정
		calDelete.jsp -> 삭제
	 --%>
</body>
</html>
