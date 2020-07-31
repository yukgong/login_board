<%@page import="java.util.Calendar"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	
	MemberDto mem = (MemberDto)session.getAttribute("login");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
// 오늘 날짜를 가져와서 범위를 설정하는 기준으로 삼는다. 
Calendar cal = Calendar.getInstance(); // 날짜를 사용할 수 있게 만드는 내장 객체
int tYear = cal.get(Calendar.YEAR);
int ttMonth = cal.get(Calendar.MONTH) + 1; // 달은 0 ~ 11로 표기되므로.
int tDay = cal.get(Calendar.DATE);
int tHour = cal.get(Calendar.HOUR_OF_DAY);
int tMin = cal.get(Calendar.MINUTE);
%>

<!-- 일정 추가 -->
<h1>일정 추가</h1>

<div align="center">
	<form action="calWriteAf.jsp" method="post">
		<table border="1" width="100%">
			<col width="20%">
			<col width="80%">
			
			<tr>
				<th>EMAIL</th>
				<td>
					<%=mem.getEmail() %>
					<input type="hidden" name="email" value="<%=mem.getEmail() %>">
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="title" size="60" placeholder="제목을 입력해주세요." value="">
				</td>
			</tr>
			<tr>
				<th>일정</th>
				<td>
					<!-- 연도 Select Box -->
					<select name="year">
						<%for(int i = tYear - 5; i < tYear + 5; i++) {%><!-- 셀렉트할 수 있는 연도를 현재 연도를 기준으로 +-5 년을 보여준다. -->
						<option <%=year.equals(i + "") ? "selected='selected'" : "" %> value="<%=i %>"> <!-- for을 통해 연산 처리 되면서 셀렉트 박스의 선택된 요소를 현재 연도로 세팅하기  -->
							<%=i %>
						</option>
						<%} %>
					</select> 년
					
					<!-- 월 Select Box -->
					<select name="month">
						<%for(int i = 1; i <= 12; i++) {%><!-- 셀렉트할 수 있는 연도를 현재 연도를 기준으로 +-5 년을 보여준다. -->
						<option <%=month.equals(i + "") ? "selected='selected'" : "" %> value="<%=i %>">
							<%=i %>
						</option>
						<%} %>
					</select> 월
					
					<!-- 일 Select Box -->
					<select name="day">
						<%for(int i = 1; i <= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++) {%><!-- 1일부터 끝날 까지 -->
						<option <%=day.equals(i + "") ? "selected='selected'" : "" %> value="<%=i %>"> <!-- for을 통해 연산 처리 되면서 셀렉트 박스의 선택된 요소를 현재 연도로 세팅하기  -->
							<%=i %>
						</option>
						<%} %>
					</select> 일
					
					<!-- 시간 Select Box -->
					<select name="hour">
						<%for(int i = 0; i < 24; i++) {%><!-- 1일부터 끝날 까지 -->
						<option <%=(tHour + "").equals(i + "") ? "selected='selected'" : "" %> value="<%=i %>"> <!-- for을 통해 연산 처리 되면서 셀렉트 박스의 선택된 요소를 현재 연도로 세팅하기  -->
							<%=i %>
						</option>
						<%} %>
					</select>시
					
					<!-- 분 Select Box -->
					<select name="min">
						<%for(int i = 0; i < 60; i++) {%><!-- 1일부터 끝날 까지 -->
						<option <%=(tMin + "").equals(i + "") ? "selected='selected'" : "" %> value="<%=i %>"> <!-- for을 통해 연산 처리 되면서 셀렉트 박스의 선택된 요소를 현재 연도로 세팅하기  -->
							<%=i %>
						</option>
						<%} %>
					</select>분
				</td>
			</tr>
			
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="20" cols="100" name="content" placeholder="내용을 입력해주세요."></textarea>
				</td>
			</tr>
			
			<tr>
				<td colspan="2" align="center">
					<button type="button" class="saveBtn">저장</button>
				</td>
			</tr>			
		</table>
	</form>
	
	<%-- 제목을 적지 않거나, 내용을 입력하지 않았을 경우의 수를 고려해 처리 --%>
	<script type="text/javascript">
		const saveBtn = document.querySelector(".saveBtn"), 
		title = document.querySelector("input[name=title]"),
		content = document.querySelector("textarea[name=content]");
		
		console.log(title.value, 1);
		
		function handleSaveEvent(){
			if(title.value === ""){
				saveBtn.type = "button";
				alert("제목을 입력해주세요!");
				return;
			}
			if(content.innerHTML === ""){
				content.innerHTML = "&nbsp;";
			}
			
			saveBtn.type = "submit";
		}
		
		saveBtn.addEventListener("click", handleSaveEvent);
	</script>
</div>

</body>
</html>