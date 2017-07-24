<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="css/codemirror.css">
</head>
<body>
    <textarea name="text-area" id="test-text-area" cols="30" rows="10"></textarea>
    <!-- Create a simple CodeMirror instance -->
    <script src="js/codemirror.js"></script>
    <script>
        var mytextarea = document.getElementById("test-text-area");
        var myCodeMirror = CodeMirror.fromTextArea(mytextarea ,{
            value : "dsafsdfas \n",
            lineNumbers : true
        });
    </script>
</body>
</html>