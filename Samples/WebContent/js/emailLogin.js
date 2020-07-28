
$(document).ready(function() {
	$("#btnLogin").click(function() {
		if ($("#email").val().trim() == "") {
			alert("email을 입력해 주세요");
			$("#email").focus();
		} else {
			$("#frm").attr("action", "loginAf.jsp").submit();
		}
	});
});

// 아이디 저장하기
// cookie : string	-> id
// session : Object -> login 개인정보 저장

let user_id = $.cookie("user_id"); 	// 쿠키 꺼내오기
if (user_id != null) { 				// 저장된 쿠키가 있다면? 
	alert("cookie 있음");
	$("#email").val(user_id);
	$("#chk_save_id").attr("checked", "checked");
}
$("#chk_save_id").click(function() {
	if ($("#chk_save_id").is(":checked")) { // check 되었을 때 실행
		// 				alert('체크됨');
		// cookie 저장
		if ($("#email").val().trim() == "") {
			alert("email을 입력해 주세요");
			$("#chk_save_id").prop("checked", false);
		} else {
			$.cookie("user_id", $("#email").val().trim(), { expires: 7, path: "/" })
			// expires -> 기한 설정 '일' 단위. -1로 표기시 무한 저장
		}
	}
	else {
		// 				alert('체크 없어짐');
		// cookie 삭제
		$.removeCookie("user_id", { path: '/' }); // 기한을 삭제함
	}
});