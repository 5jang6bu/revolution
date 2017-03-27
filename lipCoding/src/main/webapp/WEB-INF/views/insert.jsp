<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-3.1.1.min.js"></script>
<!-- Bootstrap Core CSS -->
<link href="resources/bootstrap/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom Fonts -->
<link
	href="resources/bootstrap/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic'
	rel='stylesheet' type='text/css'>

<!-- Plugin CSS -->
<link
	href="resources/bootstrap/vendor/magnific-popup/magnific-popup.css"
	rel="stylesheet">

<!-- Theme CSS -->
<link href="resources/bootstrap/css/creative.min.css" rel="stylesheet">

<!-- layout CSS -->
<link href="resources/css/layout.css" rel="stylesheet">

<!-- style_insert -->
<link href="resources/css/style_insert.css" rel="stylesheet">

<script>
	$(document).ready(function() {
		$('#insertBt').on('click', insert);
		listBtAttr();
		$('#listBt').on('click',showlist);
	});

	function insert() {
		var command = $('#command').val();
		var code = $('#code').val();

		$.ajax({
			url : 'insert',
			type : 'POST',
			data : {
				command : command,
				code : code
			},
			success : complete,
			error : function(e) {
				alert(JSON.stringify(e));
			}
		});
	}

	function complete() {
		$('.listDiv').css('display','block');
		getList();
	}
	
	function showlist(){
		getList();
		$('.listDiv').toggle();
	}
	
	function getList(){
		$('#command').val('');
		$('#code').val('');
		
		$.ajax({
			url: 'getList',
			type: 'GET',
			dataType: 'json',
			success: output,
			error:function(e) {
				alert(JSON.stringify(e));
			}
		});
	}
	
	function output(result){
		var str = '<table class="listTable">';
		$.each(result,function(i,item){
			str += '<tr><td>'+item.command+'</td>';
			str += '<td>'+item.code+'</td></tr>';
		});
		$('.listDiv').html(str);
	}
	
	function listBtAttr(){
		$('#listBt').mouseenter(function(){
			$(this).attr('src','resources/img/arrow.png');
		});
		$('#listBt').mouseleave(function(){
			$(this).attr('src','resources/img/arrow1.png');
		});
	}
</script>
</head>
<body>
	<nav id="mainNav" class="navbar navbar-default navbar-fixed-top">
		<div class="divRoot">
			<div class="container-fluid">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span> Menu <i
							class="fa fa-bars"></i>
					</button>
					<a class="navbar-brand page-scroll" href="/lipcoding">LipCoding</a>
				</div>

				<div class="collapse navbar-collapse"
					id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav navbar-right">
						<li><a class="page-scroll" href="/lipcoding#about">About</a></li>
						<li><a class="page-scroll" href="/lipcoding#services">Services</a></li>
						<li><a class="page-scroll" href="/lipcoding#portfolio">Team</a></li>
						<li><a class="page-scroll" href="/lipcoding#contact">Contact</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>

	<header>
		<div class="header-root">
			<div class="header-left">
				<div class="header-content">
					<div class="header-content-inner"></div>
					<div class="userCommand">
						<div class="insertCommand">
							<table>
								<tr>
									<td class="tName">command</td>
									<td><input type="text" id="command" name="command"></td>
								</tr>
								<tr>
									<td class="tName">code</td>
									<td><textarea id="code"></textarea></td>
								</tr>
							</table>
							<br> <input type="button" value="insert" id="insertBt" name="insertBt">
						</div>
					</div>
				</div>
			</div>
			<div class="header-right">
				<div class="" style="float: right; margin-top: 45%;">
					<img id="listBt" src="resources/img/arrow1.png">
				</div>
				<div class="listDiv">
					<!-- 사용자 등록 명령어 및 코드 -->
				</div>
			</div>
		</div>
	</header>
</body>
</html>