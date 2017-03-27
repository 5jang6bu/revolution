<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-3.1.1.min.js"></script>

<!-- layout CSS -->
<link href="resources/css/layout.css" rel="stylesheet">
  <style type="text/css" media="screen">
    body {
        overflow: hidden;
    }
    #editor{
    	float: left;
    	width: 570px;
		height: 600px;
    }
  </style>
</head>
<script>
	$(document).ready(function(){
		voice();
	});

	function voice() {
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
			recognition.lang = 'en-US';
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
			recognition.lang = 'en-US';
			recognition.start();
			ignore_onend = false;
			console.log('음성인식 시작');
		};

		recognition.onresult = function(event) {
			var interim_transcript = '';
			for (var i = event.resultIndex; i < event.results.length; ++i) {
					var command = event.results[i][0].transcript;
				if (event.results[i].isFinal) {
					final_transcript += command;
					if (final_transcript.match('hello')) {
						console.log('서버 연결 준비');
						var array = command.split(' ');
						for (var j = 0; j < array.length; j++) {
							console.log(array[j]);
							$.ajax({
								url : 'userCode',
								type : 'POST',
								data : {
									command : array[j]
								},
								dataType : 'text',
								success : output,
								error : function(e) {
									alert(JSON.stringify(e));
								}
							});
						}
					} else
						console.log('매치안됨');
				}
			}
		};
	}
</script>
</head>
<body>



		<div id="editor" contenteditable="true">public class Test {
		public static void main(String[] args) {
		}
	}</div>

	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.2.6/ace.js" type="text/javascript" charset="utf-8"></script>
	<script src="resources/js/ext-language_tools.js"></script>
	
	<script>
    // trigger extension
    ace.require("ace/ext/language_tools");
    var editor = ace.edit("editor");
    editor.session.setMode("ace/mode/java");
    editor.setTheme("ace/theme/monokai");
    // 자동완성
    editor.setOptions({
        enableBasicAutocompletion: true,
        enableSnippets: true,
        enableLiveAutocompletion: false
    });
    
    function output(result) {
		editor.insert(result);
    }
</script>
</body>
</html>