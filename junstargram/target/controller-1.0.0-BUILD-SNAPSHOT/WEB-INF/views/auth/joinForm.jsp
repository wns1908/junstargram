<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photogram</title>
    <link rel="stylesheet" href="../resources/css/style.css">
    <link rel="shortcut icon" href="../images/insta.svg">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
        integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<script type="text/javascript">
//아이디 유효성 검사(1 = 중복 / 0 != 중복)
$("#id").blur(function() {
	// id = "id_reg" / name = "userId"
	var id = $('#id').val();
	$.ajax({
		url : '${pageContext.request.contextPath}/insta/idCheck?id='+ id,
		type : 'get',
		success : function(data) {
			console.log("1 = 중복o / 0 = 중복x : "+ data);							
			
			if (data == 1) {
					// 1 : 아이디가 중복되는 문구
					$("#id_check").text("사용중인 아이디입니다 :p");
					$("#id_check").css("color", "red");
					$("#reg_submit").attr("disabled", true);
				} else {
					
					if(idJ.test(user_id)){
						// 0 : 아이디 길이 / 문자열 검사
						$("#idCheck").text("");
						$("#reg_submit").attr("disabled", false);
			
					} else if(id == ""){
						
						$('#idCheck').text('아이디를 입력해주세요 :)');
						$('#idCheck').css('color', 'red');
						$("#reg_submit").attr("disabled", true);				
						
					} else {
						
						$('#idCheck').text("아이디는 소문자와 숫자 4~12자리만 가능합니다 :) :)");
						$('#idCheck').css('color', 'red');
						$("#reg_submit").attr("disabled", true);
					}
					
				}
			}, error : function() {
					console.log("실패");
			}
		});
	});
</script>
</script>
    <div class="container">
        <main class="loginMain">
           <!--회원가입섹션-->
            <section class="login">
                <article class="login__form__container">
                  
                   <!--회원가입 폼-->
                    <div class="login__form">
                        <!--로고-->
                        <h1><img src="${pageContext.request.contextPath}/resources/images/junsta.png" alt=""></h1>
                         <!--로고end-->
                         
                         <!--회원가입 인풋-->
                        <form class="login__input" action="/insta/join" method="post">
                            <input type="text" name="id" id="id" placeholder="아이디" required="required">
                            <div class="check_font" id="idCheck"></div>
                            <input type="password" name="pw" placeholder="패스워드" required="required">
                            <input type="email" name="email" placeholder="이메일" required="required">
                            <input type="text" name="name" placeholder="이름" required="required">
                            <button>가입</button>
                        </form>
                        <!--회원가입 인풋end-->
                    </div>
                    <!--회원가입 폼end-->
                    
                    <!--계정이 있으신가요?-->
                    <div class="login__register">
                        <span>계정이 있으신가요?</span>
                        <a href="/auth/loginForm">로그인</a>
                    </div>
                    <!--계정이 있으신가요?end-->
                    
                </article>
            </section>
        </main>
    </div>
</body>

</html>