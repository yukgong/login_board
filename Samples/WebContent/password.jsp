<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String email = request.getParameter("email");
	System.out.println(email);
	
	MemberDao dao = MemberDao.getInstance();
	MemberDto dto = dao.selectMember(email);
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>

<link async rel="stylesheet" href="css/default.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/fonticon.css">

<script defer
	src="https://cdnjs.cloudflare.com/ajax/libs/gsap/2.0.2/TweenMax.min.js"></script>
<script defer src="js/main.js"></script>
<script defer src="js/buttonEvent.js"></script>
</head>

<body>
	<div class="outer">
		<div class="wrapper">
			<div class="inner__wrapper js-pw">
				<!-- <img class="logo" src="img/logo.svg" alt="logo"> -->
				<h2 class="greeting">반갑습니다. <%=dto.getName()%>님</h2>
				<p><%=dto.getEmail() %></p>
				<form action="signInAf.jsp" id="frm" method="post">
					<div class="inputWrapper">
						<div class="inputGroup">
							<label for="password" class="js-label">비밀번호 입력</label> 
							<input type="password" class="js-input" name="pwd" id="pwd" value="123"  placeholder="비밀번호 입력" autocomplete="off">
							<p class="notice">
								<i class="icon-icon_information"></i>6자리 이상의 비밀번호를 입력해주세요.
							</p>
							<p class="notice__error hide">
								<i class="icon-icon_cancel"></i>잘못된 비밀번호입니다. 다시 시도해주세요.
							</p>
						</div>
					</div>
					<div class="btnGroup">
						<a class="btn link" type="submit">비밀번호를 잊으셨나요?</a> 
						<input type="hidden" name="email" value="<%=dto.getEmail() %>">
						<a class="btn primary js-nextBtn" id="btnLogin" type="submit">다음</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script>
		$(document).ready(function() {
			$("#btnLogin").click(function() {
				if ($("#pwd").val().trim() == "") {
					alert("email을 입력해 주세요");
					$("#pwd").focus();
				} else {
					$("#frm").attr("action", "signInAf.jsp").submit();
				}
			});
		});
	</script>
</body>

</html>