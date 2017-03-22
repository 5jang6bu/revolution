<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-3.1.1.min.js"></script>
<script>
	$(document).ready(function(){
		$('#insertBt').on('click',insert);
	});
	
	function insert(){
		var command = $('#command').val();
		var code = $('#code').val();
		
		$.ajax({
			url: 'insert',
			type:'POST',
			data:{
				command: command,
				code: code
			},
			success: complete,
			error: function(e){
				alert(JSON.stringify(e));
			}
		});
	}
	
	function complete(result){
		alert('등록완료!');
	}
</script>
</head>
<body>
<h1>[음성명령어 등록하기]</h1>
<form id="insertForm">
	명령어: <input type="text" id="command" name="command" size="50">
	<br>
	해당코드: <textarea id="code" row="10" cols="50"></textarea>
	<br>
	<input type="button" value="등록" id="insertBt" name="insertBt">
</form>
	<p><a href="/lipcoding">home</a></p>
</body>
</html>