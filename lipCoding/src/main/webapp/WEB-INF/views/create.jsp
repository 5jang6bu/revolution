<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-3.1.1.min.js"></script>
<style>
	#divRoot{
		margin:auto;
		width:1300px;
	}
	#divMain{
		width: 100%;
		height: 50px;
		background-color: lightblue;
	}
	.sideMenu{
		width: 8%;
		height: 600px;
		float: left;
		background-color: lightyellow;
	}
	#divExp{
		width: 21%;
		height: 600px;
		float: left;
		background-color: lightpink;
	}
	#divSpace{
		width: 70%;
		height: 600px;
		float: left;
		background-color: white;
	}
</style>
<script>
	$(document).ready(function() {
		settingName();
		voice();
	});
	
	function settingName(){
		var name = prompt('생성할 프로젝트 이름을 설정하세요');
		console.log(name);
	}
	
	function voice(){
		var final_transcript = '';
		var recognizing = false;
		var ignore_onend;
			var recognition = new webkitSpeechRecognition();
			recognition.continuous = true;
			recognition.interimResults = true;
		
			if (recognizing) {
				recognition.stop();
				alert('음성인식 종료');
				return;
			} else {
				final_transcript = '';
				recognition.lang = 'ko-KR';
				recognition.start();
				ignore_onend = false;
				console.log('음성인식 시작');
			}

			recognition.onend = function() {
				recognizing = false;
				if (ignore_onend) {
					return;
				}
				if (!final_transcript) {
					console.log('스타트하세옹');
					return;
				}
				console.log('');
				recognition.lang = 'ko-KR';
				recognition.start();
				ignore_onend = false;
				console.log('음성인식 시작');
			};

			recognition.onresult = function(event) {
				var interim_transcript = '';
				for (var i = event.resultIndex; i < event.results.length; ++i) {
					if (event.results[i].isFinal) {
						var command = event.results[i][0].transcript;
						final_transcript += command;
						if(final_transcript.match('김밥')){
							console.log('서버 연결 준비');
							var array = command.split(' ');
							for(var j = 0 ; j < array.length ; j++){
								console.log(array[j]);
								$.ajax({
									url: 'userCode',
									type: 'POST',
									data: {command: array[j]},
									dataType: 'text',
									success: output,
									error: function(e){
										alert(JSON.stringify(e));
									}
								});
							}
						}else console.log('매치안됨');
					}
				}
			};
	}
	
	function output(result){
		console.log(result);
		if(result.length != 0){
			$("#workspace").insertAtCaret(result);
		}
	}
	
    $.fn.insertAtCaret = function (myValue) {
    	return this.each(function(){
    			//IE support
    			if (document.selection) {
    					this.focus();
    					sel = document.selection.createRange();
    					sel.text = myValue;
    					this.focus();
    			}
    			//MOZILLA / NETSCAPE support
    			else if (this.selectionStart || this.selectionStart == '0') {
    					var startPos = this.selectionStart;
    					var endPos = this.selectionEnd;
    					var scrollTop = this.scrollTop;
    					this.value = this.value.substring(0, startPos)+ myValue+ this.value.substring(endPos,this.value.length);
    					this.focus();
    					this.selectionStart = startPos + myValue.length;
    					this.selectionEnd = startPos + myValue.length;
    					this.scrollTop = scrollTop;
    			} else {
    					this.value += myValue;
    					this.focus();
    			}
    	});
    };
    
</script>
</head>
<body>
	<div id = "divRoot">
	<div id="divMain">
	상단메뉴
	</div>
	<div id="divSide" class="sideMenu">
	사이드메뉴
	<table class="sideMenu">
		<tr>
			<td><input type="button" value="new"></td>
		</tr>
		<tr>
			<td><input type="button" value="diagram"></td>
		</tr>
		<tr>
			<td><input type="button" value="search"></td>
		</tr>
		<tr>
			<td><input type="button" value="export"></td>
		</tr>
		<tr>
			<td><a href="/lipcoding"><input type="button" value="home"></a></td>
		</tr>
	</table>
	</div>
	<div id="divExp">
	폴더구조
	</div>
	<div id="divSpace">
	코드치는창<br>
		<textarea rows="39" cols="140" id="workspace"></textarea>
	</div>
	</div>
</body>
</html>