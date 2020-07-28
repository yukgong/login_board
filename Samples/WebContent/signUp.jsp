<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String email = request.getParameter("email");
	if(email == null){
		email = "";
	}
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

    <script defer src="https://cdnjs.cloudflare.com/ajax/libs/gsap/2.0.2/TweenMax.min.js"></script>
    <script defer src="js/main.js"></script>
    <script defer src="js/buttonEvent.js"></script>
</head>

<body>
    <div class="outer">
        <div class="wrapper">
            <div class="inner__wrapper js-email">
                <!-- <img class="logo" src="img/logo.svg" alt="logo"> -->
                <h2>회원가입</h2>
                <form action="signUpAf.jsp">
                    <div class="inputWrapper">
                        <div class="inputGroup">
                            <label for="email" class="js-label">이메일</label>
                            <input type="text" class="js-input" name="email" placeholder="이메일" autocomplete="off" value="<%=email%>">
<%--                             <input type="text" name="name" placeholder="이메일" autocomplete="off" value="<%if(!email.equals("")){%><%=email%><%} else {%><%}%>"> --%>
                        </div>
                        <div class="inputGroup">
                            <label for="name" class="js-label">이름</label>
                            <input type="text" class="js-input" name="name" placeholder="이름" autocomplete="off">
                        </div>
                        <div class="inputGroup">
                            <label for="pwd" class="js-label">비밀번호</label>
                            <input type="password" class="js-input" name="pwd" id="pwd" placeholder="비밀번호" autocomplete="off">
                            <p class="notice__error"><i class="icon-icon_cancel"></i>6자리 이상의 비밀번호를 입력하세요.</p>
                        </div>
                    </div>
                    <div class="btnGroup">
                        <input class="btn primary js-nextBtn" type="submit" value="회원가입">
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>

</html>