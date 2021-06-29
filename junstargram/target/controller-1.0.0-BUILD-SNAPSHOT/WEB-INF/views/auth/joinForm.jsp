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
                        <form class="login__input" action="/insta/join" method="post" id="signFrm" name="signFrm">
                            <!-- <div class="form-group">
								<label for="id">아이디</label>
								<input type="text" class="form-control" id="id" name="id" placeholder="아이디" required>
								<div class="check_font" id="idCheck"></div>
							</div> -->
                            <input type="text" name="id" placeholder="아이디" required="required" id="id">
                            <input type="button" id="idCheck" value="중복확인">
                            <input type="password" name="pw" placeholder="패스워드" required="required" id="pw">
                            <input type="email" name="email" placeholder="이메일" required="required" id="email">
                            <div class="mail_check_wrap">
                            	<div class="mail_check_input_box" id="mail_check_input_box_false">
                            		<input class="mail_check_input" disabled="disabled">
                            	</div>
                            	<div class="mail_check_button">
                            		<span>인증번호 전송</span>
                            	</div>
                            	<div class="clearfix"></div>
                            </div>
                            <input type="text" name="name" placeholder="이름" required="required" id="name">
                            <input type="button" id="signUp" value="회원가입">
                        </form>
                        <!--회원가입 인풋end-->
                    </div>
                    <!--회원가입 폼end-->
                    
                    <!--계정이 있으신가요?-->
                    <div class="login__register">
                        <span>계정이 있으신가요?</span>
                        <a href="/">로그인</a>
                    </div>
                    <!--계정이 있으신가요?end-->
                    
                </article>
            </section>
        </main>
    </div>
</body>
<script type="text/javascript">
    $(document).ready(function(e){
        var idx = false;
        $('#signUp').click(function(){
            if($.trim($('#id').val()) == ''){
                alert("아이디 입력");
                $('#id').focus();
                return;
            } else if($.trim($('#pw').val()) == ''){
                alert("패스워드 입력");
                $('#pw').focus();
                return;
            } else if($.trim($('#email').val()) == '') {
                alert("이메일 입력");
                $('#email').focus();
                return;
            } else if($.trim($('#name').val()) == '') {
                alert("이름 입력");
                $('#name').focus();
                return;
            }
            if(idx == false) {
                alert("아이디 중복체크를 해주세여");
                return;
            } else {
                $('#signFrm').submit();
            }
        });
        $('#idCheck').click(function() {
            $.ajax({
                url : "${pageContext.request.contextPath}/insta/idCheck",
                type : "GET",
                data : {"id" : $("#id").val()},
                success : function(data){
                     if(data == 0 && $.trim($('#id').val()) != '') {
                        idx = true;
                        /* $('#id').attr("readonly",true); */
                        alert("사용가능한 아이디입니다.")
                        $("#pw").focus();
                    } else{
                        alert("중복된 아이디입니다.")
                    }
                },
                error: function() {
                    alert("서버에러");
                }
            });
        });
        
        /* 인증번호 이메일 전송*/
        $(".mail_check_button").click(function() {
        	var email = $(".mail_input").val(); 	// 입력한 이메일
        	
        	$.ajax({
        		type:"GET",
        		url:"mailCheck?email=" + email
        	})
        });
        /* $("#id").blur(function() {
    		// id = "id_reg" / name = "userId"
    		var user_id = $('#id').val();
    		$.ajax({
    			url : '${pageContext.request.contextPath}/insta/idCheck?id='+ id,
    			type : 'get',
    			success : function(data) {
    				console.log("1 = 중복o / 0 = 중복x : "+ data);							
    				
    				if (data == 1) {
    						// 1 : 아이디가 중복되는 문구
    						$("#idCheck").text("사용중인 아이디입니다 :p");
    						$("#idCheck").css("color", "red");
    						$("#reg_submit").attr("disabled", true);
    					} else {
    						
    						if(idJ.test(user_id)){
    							// 0 : 아이디 길이 / 문자열 검사
    							$("#idCheck").text("");
    							$("#reg_submit").attr("disabled", false);
    				
    						} else if(user_id == ""){
    							
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
    		}); */
    });
</script>
</html>