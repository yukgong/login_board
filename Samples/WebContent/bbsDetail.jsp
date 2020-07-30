<%@page import="dto.MemberDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
int seq = Integer.parseInt(request.getParameter("seq"));

BbsDao dao = BbsDao.getInstance();
BbsDto bbs = dao.getBbs(seq);
dao.readCount(seq);

MemberDto mem = (MemberDto)session.getAttribute("login");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=bbs.getTitle()%></h1>
	<table border="1" width="100%">
		<col width="20%"><col width="80%">
		<tr>
			<th>시퀀스</th>
			<td><%=bbs.getSeq()%></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%=bbs.getEmail()%></td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><%=bbs.getWdate()%></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%=bbs.getReadcount()%></td>
		</tr>
		<tr>
			<th>정보</th>
			<td><%=bbs.getRef()%>-<%=bbs.getStep()%>-<%=bbs.getDepth()%></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><%=bbs.getContent()%></td>
		</tr>
	</table>
	<button type="button" onclick="location.href='bbsList.jsp'">목록으로</button>
	<%
	if(bbs.getEmail().equals(mem.getEmail())){
	%>
		<form action="bbsUpdate.jsp" method="get">
			<input type="hidden" name="seq" value="<%=seq%>">
			<button type="submit">수정하기</button>
		</form>
		<button type="button" onclick="deleteBbs(<%=bbs.getSeq()%>)">삭제하기</button>
	<%
	}
	%>
<!-- 	방법1  -->
<%-- 	<button type="button" onclick="answerBbs(<%=bbs.getSeq()%>)">"답글 달기"</button> --%>
	
	<form action="answer.jsp" method="get">
		<input type="hidden" name="seq" value="<%=bbs.getSeq()%>">
		<input type="submit" value="답글 달기">
	</form>

<script>
	function deleteBbs(){
		location.href = "bbsDelete.jsp?seq=" + <%=seq%>;
	}
</script>
</body>
</html>
