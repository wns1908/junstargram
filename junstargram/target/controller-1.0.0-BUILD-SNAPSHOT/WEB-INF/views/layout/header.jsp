<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> --%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Photogram</title>

<!-- jquery -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Style -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/feed.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/explore.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/profile.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/upload.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/profileSetting.css">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/junsta.png">

<!-- Fontawesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<!-- Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700&display=swap" rel="stylesheet">

</head>

<body>
	<input type="hidden" id="principal-id" value="${principal.user.id}"/>
	<input type="hidden" id="principal-username" value="${principal.user.name}"/>
	
	<header class="header">
		<div class="container">
			<a href="/insta/feed" class="logo">
				<img src="${pageContext.request.contextPath}/resources/images/junsta.png" alt="">
			</a>
			<nav class="navi">
				<ul class="navi-list">
					<li class="navi-item"><a href="${pageContext.request.contextPath}/insta/feed">
							<i class="fas fa-home"></i>
						</a></li>
					<li class="navi-item"><a href="${pageContext.request.contextPath}/resources/explore">
							<i class="far fa-compass"></i>
						</a></li>
					<li class="navi-item"><a href="${pageContext.request.contextPath}/insta/user/${principal.user.id}">
							<i class="far fa-user"></i>
						</a></li>
				</ul>
			</nav>
		</div>
	</header>