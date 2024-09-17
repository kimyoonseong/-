<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<style>
    .like-dislike-box {
        background-color: #F9F9F9; /* 흰 배경색 */
        padding: 10px;
        text-align: center;
    }
    .like-dislike-box p {
        margin: 0;
        font-size: 18px;
    }
    .like-dislike-box p:first-child {
        color: red; /* 좋아요 수 색상 */
    }
    .like-dislike-box p:last-child {
        color: blue; /* 싫어요 수 색상 */
    }
</style>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 상세</title>
    <!-- 부트스트랩 CDN을 사용하는 경우 아래 링크를 추가 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
    <%@include file="/WEB-INF/view/include/header.jsp"%>
     
   <div class="container mt-4" style="padding-top: 90px">
   
    <div class="row">
        <!-- 왼쪽에는 게시글 상세 -->
        <div class="col-md-6">
            <h1 class="mb-4">게시글 상세</h1>
            <!-- 게시글 상세 내용 등 추가 내용을 표시 -->
        </div>
        <!-- 오른쪽에는 좋아요, 싫어요 수 -->
        <div class="col-md-6">
            <!-- 좋아요, 싫어요 수를 나타내는 박스 -->
            <div class="like-dislike-box d-flex justify-content-end">
                <div class="text-center mr-4">
                    <img src="/upload/like.jpg" class="img-fluid" alt="좋아요 이미지" style="width: 80px;">
                    <br>
                    <span style="color: blue;">${board.likeRecipe}</span>
                </div>
                <div class="text-center">
                    <img src="/upload/unlike.jpg" class="img-fluid" alt="싫어요 이미지" style="width: 80px;">
                    <br>
                    <span style="color: red;">${board.unlikeRecipe}</span>
                </div>
            </div>
        </div>
    </div>
</div>
        <form method="post" action="/board/update" enctype="multipart/form-data">
            <div class="form-group">
                <input type="hidden" name="user_Id" value="${board.user.id}" class="form-control">
            </div>
            <div class="form-group">
                <label for="no">글 번호:</label>
                <input type="text" name="no" value="${board.no}" class="form-control" readonly>
            </div>
            <div class="form-group">
                <label for="name">작성자:</label>
                <input type="text" value="${board.user.name}" class="form-control" disabled>
                <br>
            <div class="form-group text-center">

    <div style="font-size: 36px; font-weight: bold; color: blue; font-weight: bold; margin-top: 5px;">
        ${board.title}
    </div>
</div>


            <!-- CKEditor 사용을 위한 textarea 및 히든 필드 추가 -->
			<div class="form-group">

		


		<div id="renderedContent">${board.content}</div>





    </div>
</div>
            <!-- 이미지 추가 -->
            <div class="form-group">
                <c:if test="${not empty board.imagePath}">
                    <img src="https://food-fisa.s3.ap-northeast-2.amazonaws.com/upload/${board.imagePath}" class="img-fluid" alt="이미지" width="300px">
                </c:if>
                <c:if test="${empty board.imagePath}">
                    <span>이미지 없음</span>
                </c:if>
            </div>
            <!-- 여기까지가 성욱이가 추가한 부분 -->
            <c:if test="${not empty loginUser && loginUser.id == board.user.id}">
                <button type="submit" class="btn btn-primary">수정</button>
                <a href="/board/delete?no=${board.no}" class="btn btn-danger">삭제</a>
            </c:if>
        </form>
        			<div class="d-flex justify-content-end gap-2">
    <form method="POST" action="/board/recommend">
        <input type="hidden" name="no" value="${board.no}">
        <button type="submit" class="btn btn-primary">추천</button>
    </form>
	
    <form method="POST" action="/board/notrecommend">
        <input type="hidden" name="no" value="${board.no}">
        <button type="submit" class="btn btn-danger" style="margin-left: 50px; margin-right:20px;">비추</button>
    </form>
</div>
		   </div>
    <!-- 부트스트랩 JS 및 Popper.js, jQuery CDN을 사용하는 경우 아래 스크립트 추가 -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>