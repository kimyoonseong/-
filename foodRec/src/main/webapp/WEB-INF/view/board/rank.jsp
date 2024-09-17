<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<style>
.title22 {
    font-size: 50px;
    
    color: blue;
}
.link-button {
    display: inline-block;
    padding: 5px 10px;
    font-size: 16px;
    text-align: center;
    text-decoration: none;
    cursor: pointer;
    border: 2px solid #3498db; /* 버튼 테두리 색상 */
    color: #3498db; /* 버튼 텍스트 색상 */
    background-color: white; /* 버튼 배경색 */
    border-radius: 3px; /* 버튼 테두리 둥글기 */
    transition: background-color 0.3s, color 0.3s; /* 호버 효과 속도 조절 */
}

.link-button:hover {
    background-color: #3498db; /* 호버 시 버튼 배경색 */
    color: white; /* 호버 시 버튼 텍스트 색상 */
}
thead {
            background-color: #bdd5ea;
            color: white;
        }
</style>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글목록</title>
    <!-- 부트스트랩 CDN을 사용하는 경우 아래 링크를 추가 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
    <%@include file="/WEB-INF/view/include/header.jsp"%>

    <div class="container mt-4" style="padding-top: 90px">
        <h1>* 레시피 추천 순위 *</h1>

        <table class="table">
            <thead>
                <tr>
                  
                            <th>번호</th>
		                    <th>제목</th>
		                    <th>작성자</th>
		                    <th>추천수</th>
		                    <th>비추천수</th>
		                    <th>조회수</th>
                     
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${pageInfo.content}" var="board">
                    <tr>
                       <td>${board.no}</td>
                        <form action="/board/views" method=post class="form-inline">
       				 	<td>
       				 	<button type="submit" class="link-button" name="boardId" value="${board.no}">
        				${board.title}
    					</button>
    					</td>
    					</form>
                        <td>${board.user.name}</td>
                    
                        <td>${board.likeRecipe}</td>
                         <td>${board.unlikeRecipe}</td>
                         <td>${board.allViews1}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <form action="/board/rank" method="get" class="form-inline">
            <div class="form-group mr-2">
                <label for="page">페이지:</label>
                <input type="text" name="page" class="form-control" value="${pageInfo.number + 1}">
            </div>
            <div class="form-group">
                <label for="totalPages">/ ${pageInfo.totalPages}</label>
            </div>
            <button type="submit" class="btn btn-primary">이동</button>
        </form>
    </div>

    <!-- 부트스트랩 JS 및 Popper.js, jQuery CDN을 사용하는 경우 아래 스크립트 추가 -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
