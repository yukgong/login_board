<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Object ologin = session.getAttribute("login");
MemberDto mem = null;

if (ologin == null) {
%>
<script type="text/javascript">
	alert("로그인이 필요한 서비스입니다.");
	location.href = "email.html";
</script>
<%
	}
mem = (MemberDto) ologin;
BbsDao dao = BbsDao.getInstance();
List<BbsDto> list = dao.getBbsList();

System.out.println(list.size());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="outer">
		<h4 align="right">
			환영합니다.
			<%=mem.getName()%>님
		</h4>
		<h1>게시판</h1>
		<div align="center">
			<table class="board__wrapper" border="1" width="100%">
				<col width="10%">
				<col width="70%">
				<col width="20%">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
				</tr>
				<%
					if (list == null || list.size() == 0) {
				%>
				<tr class="board__row">
					<td colspan="3">작성ㄴㄴ</td>
				</tr>
				<%
					} else {
					for (int i = 0; i < list.size(); i++) {
						BbsDto bbs = list.get(i);
				%>
				<tr class="board__row">
					<th><%=i + 1%></th>
					<td><a href="bbsDetail.jsp?seq=<%=bbs.getSeq()%>"><%=bbs.getTitle()%></a>
					</td>
					<td align="center"><%=bbs.getEmail()%></td>
				</tr>
				<%
					}
				}
				%>

			</table>
		</div>
		<a type="submit" href="bbsWrite.jsp">글쓰기</a>
	</div>
</body>
</html>