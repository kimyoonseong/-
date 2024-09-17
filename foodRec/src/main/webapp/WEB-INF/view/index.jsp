<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>환영합니다!</title>
    <!-- 부트스트랩 CDN을 사용하는 경우 아래 링크를 추가 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        body {
            padding: 20px;
            padding-top: 100px;
        }

        hr {
            margin-top: 20px;
            margin-bottom: 20px;
        }

        img {
            max-width: 100%;
            height: auto;
            margin-top: 20px;
        }
        h1 {
        font-style: bold;}
    </style>
</head>
<body>

    <%@include file="/WEB-INF/view/include/header.jsp"%>

    <div class="container mt-4" style="padding-top: 90px; text-align :center">
    <h1>모두의 레시피</h1>
<p style="font-size: 35px; color: #333; font-family: 'Arial', sans-serif; font-weight: bold; text-align: center; margin: 20px;">
    맛있는 순간, 공유의 기쁨. 여러분의 요리 이야기가 시작되는 곳  </p>


        <hr>
        <!-- static 폴더가 기본 폴더가 됨 -->
	<img src="/upload/logo.png">
    </div>

    <!-- 부트스트랩 JS 및 Popper.js, jQuery CDN을 사용하는 경우 아래 스크립트 추가 -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
