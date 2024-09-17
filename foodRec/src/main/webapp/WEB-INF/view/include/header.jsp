<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Board</title>
    <!-- Bootstrap CSS 추가 -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding-top: 70px;
            background-color: #f8f9fa;
            padding: 20px;
        }
        
        .navbar {
            height: 160px; /* 네비게이션 바의 높이를 120px로 고정 */	
        }

        h1 {
            color: #007bff;
        }

        .user-info {
            margin-top: 10px;
        }
    </style>
</head>
<body>


<div class="container">
    <h1>모두의 레시피</h1>

    <div class="login-container">


<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
    <a class="navbar-brand" href="/">모두의 레시피</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="/">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                
                <a href="/user/join" class="nav-link">회원가입</a>
            </li>
				<li class="nav-item">
    			<a href="/board/test" class="nav-link">사진검색</a>
			</li>
        </ul>
    </div>
    <div class="login-container" style="padding-top:15px">

        <c:if test="${empty loginUser}">
        	<c:if test="${not empty loginmsg}">
                <div class="alert alert-danger text-left" role="alert">
                    ${loginmsg}
                </div>
            </c:if>
           

            <form method="post" action="/user/login" class="form-row">
			    <div class="form-group col">
			        <label for="id">아이디:</label>
			        <input type="text" class="form-control" id="id" name="id" required>
			    </div>
			    <div class="form-group col">
			        <label for="pass">비밀번호:</label>
			        <input type="password" class="form-control" id="pass" name="pass" required>
			    </div>
			    <div class="form-group col">
			        <button type="submit" class="btn btn-primary">로그인</button>
			    </div>
			</form>
			
            
        </c:if>

        <c:if test="${not empty loginUser}">
            <div class="user-info">

                <p style="color: white">${loginUser.name}님 반갑습니다.
                	<form class="form-inline" action="/board/search" method="get">
		                <div class="input-group">
		                    <input type="text" class="form-control form-control" id="query" name="query" placeholder="검색어 입력">
		                    <div class="input-group-append">
		                        <button type="submit" class="btn btn-outline-light">검색</button>
		                    </div>
		                </div>
		            </form>
                </p>
                <a href="/user/logout" class="btn btn-primary">로그아웃</a>
                <a href="#" onclick="confirmWithdrawal()" class="btn btn-primary">회원탈퇴</a>
                <a href="/board/regist" class="btn btn-primary">게시글 등록</a>
                <a href="/board/list" class="btn btn-primary">게시글 목록</a>
				
            </div>
        </c:if>
    </div>


</nav>

<div class="container mt-4">


    <hr>

    <script>
        function confirmWithdrawal() {
            var confirmWithdraw = confirm("정말 회원 탈퇴하시겠습니까?");
            if (confirmWithdraw) {
                window.location.href = "/user/secession";
            }
        }
    </script>

</div>

<!-- 부트스트랩 JS 및 Popper.js, jQuery CDN을 사용하는 경우 아래 스크립트 추가 -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
