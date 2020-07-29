<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!
// 댓글의 depth와 image를 추가하는 함수	
// depth가 1일 때 -> '( )' 한칸 여백
// depth가 2일 때 -> '( )( )' 두칸 여백
public String arrow(int depth) { // 매개변수 숫자에 따라 여백 설정
	String arrowImg = "<img src='./img/arrow.png' width='20px' height='20px'/>";
	String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;"; // 공백 문자 
	
	String tabString = "";
	for(int i = 0; i < depth; i++){
		tabString += nbsp; // tabString 안에 공백 더하기
	}
	
	return depth == 0 ? "" : tabString + arrowImg;
}
%>
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="outer">
		<h4 align="right">환영합니다.<%=mem.getName()%>님</h4>
		<h1>게시판</h1>
		
		<!-- 검색하기 -->
		<div>
			<form action="bbsSearch.jsp">
				<select name="category">
					<option>제목</option>
					<option>작성자</option>
					<option>내용</option>
				</select>
				<input type="text" name="searchingText" placeholder="게시물 검색 " value="">
				<button type="submit">검색</button>
			</form>	
		</div>
		
		<!-- 게시판 -->
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
					<td>
						<%=arrow(bbs.getDepth()) %> <!-- 여백 + 이미지 --> 
						<%if(bbs.getDel() == 1) {%>
							<span>관리자에의해 삭제된 게시글입니다.</span>
						<%} else {%>
							<a href="bbsDetail.jsp?seq=<%=bbs.getSeq()%>"><%=bbs.getTitle()%></a>
						<%}%>
					</td>
					<td align="center"><%=bbs.getEmail()%></td>
				</tr>
				<%
					}
				}
				%>

			</table>
		</div>
		<button><a type="submit" href="bbsWrite.jsp">글쓰기</a></button>
	</div>
</body>
</html>