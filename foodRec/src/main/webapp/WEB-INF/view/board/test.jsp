<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이미지 업로드</title>
    <%@include file="/WEB-INF/view/include/header.jsp"%>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .image-upload-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            
            border: 1px solid #ccc;
            border-radius: 5px;
			margin-top: 10px; /* 상단 여백 조정 */
        }

        .image-upload-container input[type="file"] {
            margin-bottom: 10px;
        }

        .recipe-title {
            font-size: 36px;
            color: #007bff;
            margin-top: 100px;
            padding: 10px;
            border-radius: 5px;
            width: 100%;
            text-align: left;
        }
        
    </style>
</head>
<body>
    <div class="container">
        <div class="recipe-title">무슨 음식을 만들고 싶으신가요?</div>
        
        <div class="image-upload-container">
            <form id="uploadForm" enctype="multipart/form-data">
                <input type="file" name="image" onchange="previewImage(this)">
                <input type="button" value="Upload Image" onclick="uploadImage();">
                <img id="preview" width="299" height="299" style="display:none;">
            </form>
            <div id="prediction" style="margin-top: 20px;"></div>
            <div id="recipe" style="margin-top: 10px;"></div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function uploadImage() {
            let formData = new FormData($("#uploadForm")[0]);
            $.ajax({
                type: "POST",
                url: "http://127.0.0.1:5000/upload",
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function(res) {
                	console.log(res.prediction);
                    var hashtag = "<a href='/board/search?query=" + encodeURIComponent(res.prediction) + "'>#" + res.prediction + "</a>";
                    $("#prediction").html(hashtag + "의 레시피").css("font-size", "24px");
                    if (res.recipe) {
                        $("#recipe").html("<p>레시피: " + res.recipe + "</p>");
                    } else {
                        $("#recipe").html("<p>음식 레시피 정보가 없습니다.</p>");
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error: " + error);
                    $("#prediction").html("<p>분류에 실패했습니다.</p>");
                    $("#recipe").empty();
                }
            });
        }

        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                
                reader.onload = function(e) {
                    $('#preview').attr('src', e.target.result).show();
                }

                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>
