<!DOCTYPE html>
<html>
<head>
    <%@include file="/WEB-INF/view/include/header.jsp"%>

    <meta charset="UTF-8">
    <title>Image Upload</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
    function uploadImage(){
        let formData = new FormData($("#uploadForm")[0]);
        $.ajax({
            type: "POST",
            url: "http://127.0.0.1:5000/upload", // Flask ìë² ìë¡ë URL
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function(res) {
                console.log(res.prediction); // ì½ìì ìì¸¡ ê²°ê³¼ ë¡ê¹
                $("#prediction").html(res.prediction + "</h3>").css("font-size", "24px");
                // ë ìí¼ ì ë³´ë¥¼ íìíë ì½ë
                if (res.recipe) { // ìëµì ë ìí¼ ì ë³´ê° í¬í¨ëì´ ìë ê²½ì°
                    $("#recipe").html(res.recipe + "</p>"); // ë ìí¼ ì ë³´ íì
                } else {
                    $("#recipe").html("<h3>ìì ë ìí¼ ì ë³´ê° ììµëë¤.</h3>"); // ë ìí¼ ì ë³´ê° ìë ê²½ì°ì ì²ë¦¬
                }
            },
            error: function(xhr, status, error) {
                console.error("Error: " + error); // ìë¬ ë¡ê¹
                $("#prediction").html("<p>ë¶ë¥ì ì¤í¨íìµëë¤.</p>"); // ìë¬ ë©ìì§ íì
                $("#recipe").empty(); // ê¸°ì¡´ì íìë ë ìí¼ ì ë³´ ì ê±°
            }
        });
    }
    </script>
</head>
<body>
    <form id="uploadForm" enctype="multipart/form-data">
        <input type="file" name="image" />
        <input type="button" value="Upload Image" onclick="uploadImage();" />
    </form>
    <div id="prediction"></div> <!-- ìì¸¡ë í´ëì¤ ì´ë¦ì íìí  div -->
    <div id="recipe"></div> <!-- ë ìí¼ ì ë³´ë¥¼ íìí  div -->
</body>
</html>
