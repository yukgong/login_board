<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String searchWord = request.getParameter("searchWord");
String choice = request.getParameter("choice");

if(choice == null || choice.equals("")){
	choice = "sel";
}
// 검색어를 지정하지 않고 Choice가 넘어 왔을 때
if(choice.equals("sel")){
	searchWord = "";
}
if(searchWord == null){
	searchWord = "";
	choice = "sel";
}
%>
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

// 페이지네이션 숫자 설정
String strPageNumber = request.getParameter("currentPageNum");
int currentPageNum = 0; // 현재 페이지 넘버
if(strPageNumber != null && !strPageNumber.equals("")){ // 비어있지 않다면, 처음 들어온 페이지가 아니라면!
	currentPageNum = Integer.parseInt(strPageNumber);	
}
System.out.println("페이지 넘버 : " + currentPageNum);

List<BbsDto> list = dao.getBbsPagingList(choice, searchWord, currentPageNum);

// 페이지네이션 추가하기
int listLength = dao.getAllBbs(choice, searchWord);
System.out.println("게시글 총 개수 : " + listLength);

int pageLength = listLength / 10; // ex: 12개 -> 2page
if(listLength % 10 > 0) {
	pageLength += 1; // 개수 10에 배수가 아니라면 페이지 넘버를 1개 추가
}

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
		<div align="center">
			<select id="choice"> <!-- 높이:20 중간맞춤 -->
				<option value="sel">선택</option>
				<option value="title">제목</option>
				<option value="writer">작성자</option>
				<option value="content">내용</option>
			</select>
			<input type="text" id="search">
			<button onclick="searchBbs()">검색</button>
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
					<td colspan="3">첫 게시물을 등록해보세요!</td>
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
							<span style="color:#ff0000;">관리자에의해 삭제된 게시글입니다.</span>
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
		<button><a type="button" href="./calendar/calendar.jsp">일정관리</a></button>
		<button><a type="button" href="./pds/pdsList.jsp">자료실</a></button>
		
		<%	// 페이지 넘버가 들어왔을 때
			for(int i = 0; i < pageLength; i++){
				if(currentPageNum == i){ // 현재 페이지
				%>
					<span style="font-size : 15pt; color: #0000ff; font-weight: bold; text-decoration:none">
						<%=i + 1 %>
					</span>&nbsp;
				<%
				} else { // 그 외의 페이지
				%>
					<a href="#none" title="<%=i+1%>페이지" onclick="goPage(<%=i %>)"
						style="font-size:15pt; color: #000000; font-weight:bold; text-decoration:none">
						[<%=i + 1 %>]
					</a>
				<%
				}
			}
		%>
	</div>
	<script type="text/javascript">
		
		function searchBbs() {
			let choice = document.getElementById("choice").value;
			let word = document.getElementById("search").value;
			location.href = "bbsList.jsp?searchWord=" + word + "&choice=" + choice;
		}

		function goPage(pageNum){
			let choice = "<%=searchWord%>"; // 문자열로 선언해주어야한다.
			let word = "<%=choice%>";
			
			<%if(!choice.equals("sel")){ %>
				location.href = "bbsList.jsp?currentPageNum=" + pageNum
					+ "&searchWord=" + choice + "&choice=" + word;
				
			<%} else {%>
				location.href = "bbsList.jsp?currentPageNum=" + pageNum;
			<%}%>
		}
	</script>
</body>
</html>