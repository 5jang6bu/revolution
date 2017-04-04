<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>Creative - Start Bootstrap Theme</title>

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

<link href="resources/css/style_loginModal.css" rel="stylesheet">

<script src="resources/js/jquery-3.1.1.min.js"></script>
<script>
	$(document).ready(function(){
		$('#register').on('click',function(){
			$('#login-modal').modal('hide');
		});
		$("#userId").on('keyup', check);	
		$("#password").on('keyup', passwordSpan);
		$("#passwordConfirm").on('keyup', passwordConfirmSpan);
		$("#nickname").on('keyup', nicknameSpan);
	});
	
	var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	var idConfirm = false;

	function formCheck(){
		
		var userId=document.getElementById("userId").value;
		var password=document.getElementById("password").value;
		var passwordConfirm=document.getElementById("passwordConfirm").value;
		var nickname=document.getElementById("nickname").value;
		var check = h_check(nickname);
		
		console.log(userId);
		
		//아이디 공백확인
		if(userId==""){		
			userId.focus();
			password.select();
			return false;	
		//아이디 이메일 형식 체크
		 }else if(regex.test(userId) === false){		
			 return false;
		//비밀번호 공백확인
		}else if(password==""){		
			password.focus();
			password.select();
			return false; 
		//비밀번호 자릿수 확인
		 }else if(password.length < 8 || password.length > 16){				
			return false;
		//비밀번호 일치 확인
		}else if(password != passwordConfirm){
			return false; 
		//닉네임 자릿수 체크
		}else if(nickname.length < 4 || nickname.length > 14){				
			return false;
		//닉네임 특수문자 입력 체크
		}else if(check == -1){		
			return false;
		//아이디 사용체크 안하면 false
		}else if(!idConfirm){
			return false;
		}
		
		alert('가입이 완료되었습니다');
	}

	//특수문자 체크
	function h_check(Objectname) {
		var intErr = 0;
		var strValue = Objectname;
		var retCode = 0;
		  
	    //특수문자 정규식 변수 선언
		var re = /[~!@\#$%<>^&*\()\-=+_\']/gi;
		 
			for (i = 0; i < strValue.length; i++) {
				var retCode = strValue.charCodeAt(i);
				var retChar = strValue.substr(i,1).toUpperCase();
				retCode = parseInt(retCode);	
		    
		//입력받은 값중에 특수문자가 있으면 에러
					if(re.test(strValue)) {
						intErr = -1;
						break;
		   			}
			}
			return (intErr);
	}


	//아이디 중복 체크 ajax
	function check(){	
		var id=$('#userId').val();
		
		$.ajax({
			url: 'idcheck',
			type:'POST',
			data: {userId: id},
			dataType: 'json',
			success: function(ob){
				var sstr = '<p style="color:red; font-size:90%">중복된 ID입니다.</p>';
				$('#userIdAjax').html(sstr);
			},
			error: function(e){
				var estr = '<p style="color:green; font-size:90%">사용가능한 ID입니다. '
				+'<input type="button" id="idselect" value="사용하기"></p>';
				var est = '<p style="color:red; font-size:90%">잘못된 이메일 형식입니다.</p>'
				if(regex.test(document.getElementById("userId").value) === false){				
					$('#userIdAjax').html(est);
				}else{
					$('#userIdAjax').html(estr);
					$('#idselect').on('click',useId);				
				}			
			}
		});
	}
	//사용하기 버튼 보이기
	function useId(){
		var id = $('#userId').val();	
		document.getElementById('userId').readOnly = true;
		document.getElementById('userIdAjax').style.display = "none";
		idConfirm = true;
	}
	//비밀번호 ajax
	function passwordSpan(){
		var password=$('#password').val();	
		
		$.ajax({
		url: 'password',
		type:'POST',
		data: {password: password},
		dataType: 'json',
		success: function(ob){		
			if(ob == 0){
				var est1 = '<p style="color:red; font-size:90%">필수 항목입니다.</p>'
				$('#passwordSpan').html(est1);
			}else if(ob == -1){
				
				var est2 = '<p style="color:red; font-size:90%">비밀번호는 8~16자리로 입력해주세요.</p>'
					document.getElementById('passwordSpan').style.display = "block";
				$('#passwordSpan').html(est2);			
			}else if(ob == 1){
				document.getElementById('passwordSpan').style.display = "none";		
			}
			
			if ($('#passwordConfirm').val() != "" ){
				var est = '<p style="color:red; font-size:90%">비밀번호가 일치하지 않습니다.</p>'
					document.getElementById('passwordCSpan').style.display = "block";
					$('#passwordCSpan').html(est);
				}
		}
		});
	}

	//비밀번호확인 ajax
	function passwordConfirmSpan(){
		var password = $('#password').val();
		var passwordConfirm = $('#passwordConfirm').val();
		
		$.ajax({
		url: 'passwordConfirm',
		type:'POST',
		data: { password: password,	passwordConfirm: passwordConfirm },
		dataType: 'json',
		success: function(ob){
			if(ob == -1){
				var est = '<p style="color:red; font-size:90%">비밀번호가 일치하지 않습니다.</p>'
					document.getElementById('passwordCSpan').style.display = "block";
				$('#passwordCSpan').html(est);
			}else if(ob == 1){
				document.getElementById('passwordCSpan').style.display = "none";		
			}
		}
		});
	}


	//닉네임 ajax
	function nicknameSpan(){
		var nickname = $('#nickname').val();
		
		
		$.ajax({
		url: 'nickname',
		type:'POST',
		data: { nickname: nickname },
		dataType: 'json',
		success: function(ob){
			if(h_check(nickname) == -1 ){
				var est1 = '<p style="color:red; font-size:90%">닉네임에는 특수문자를 사용할 수 없습니다.</p>'
					document.getElementById('nicknameSpan').style.display = "block";
				$('#nicknameSpan').html(est1);
			}else{
				
				if(ob == -1){
					var est2 = '<p style="color:red; font-size:90%">닉네임은 4~14자 사이로 입력해주세요.</p>'
						document.getElementById('nicknameSpan').style.display = "block";
					$('#nicknameSpan').html(est2);
				}else if(ob == 1){
					document.getElementById('nicknameSpan').style.display = "none";
				}			
			}
		}
		});
	}
</script>

</head>

<body id="page-top" style="overflow: hidden;">
	<!-- style="overflow:hidden;" -->
	<nav id="mainNav" class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> Menu <i
						class="fa fa-bars"></i>
				</button>
				<a class="navbar-brand page-scroll" href="#page-top">Lip Coding</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#" data-toggle="modal" data-target="#login-modal">Login</a>
					</li>
					<li><a class="page-scroll" href="#services">Services</a></li>
					<li><a class="page-scroll" href="#portfolio">Team</a></li>
					<li><a class="page-scroll" href="#contact">Contact</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container-fluid -->
	</nav>

	<header>
		<div class="header-content">
			<div class="header-content-inner">
				<h1 id="homeHeading">CREATE YOUR JAVA PROJECT ON WEB</h1>
				<hr>
				<p>We provide .......</p>
				<!-- <a href="#" data-toggle="modal" data-target="#login-modal" class="btn btn-primary btn-xl">LOGIN</a> -->
			</div>
		</div>
	</header>

	<!-- login modal -->
	<div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
    	  <div class="modal-dialog">
				<div class="loginmodal-container">
					<h1>Login to Your Account</h1><br>
				  <form>
					<input type="text" name="user" placeholder="Username">
					<input type="password" name="pass" placeholder="Password">
					<input type="submit" name="login" class="login loginmodal-submit" value="Login">
				  </form>
					
				  <div class="login-help">
					<a href="#" data-toggle="modal" data-target="#join-modal">Register</a> - <a href="#">Forgot Password</a>
				  </div>
				</div>
			</div>
		  </div>

	<!-- join modal -->
	<div class="modal fade" id="join-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog">
			<div class="loginmodal-container">
				<h1>Let's get you sign up</h1>
				<br>
				<form action="joinForm" method="post" onsubmit="return formCheck();">
					<table>
						<tr>
							<td>
								<input type="text" name="userId" id="userId" placeholder="ID(이메일)" autocomplete="off">
								<!-- <input type="button" value = "check" id="checkBtn"> -->			
								<span id="userIdAjax"></span>
							</td>
						</tr>
						<tr>
							<td><input type="password" name="password" id="password" placeholder="create a password">
								<span id="passwordSpan"></span>
							</td>
						</tr>
						<tr>
							<td><input type="password" name="passwordConfirm" id="passwordConfirm" placeholder="check a password">
								<span id="passwordCSpan"></span>
							</td>
						</tr>
						<tr>
							<td><input type="text" name="name" id="name" placeholder="name" ></td>
						</tr>
						<tr>
							<td><input type="date" name="birthday"></td>
						</tr>
						<tr>
							<td><input type="text" name="nickname" id="nickname" placeholder="nickname" >
								<span id="nicknameSpan"></span>
							</td>
							
						</tr>
						<tr>
							<td><input type="text" name="address" placeholder="address" ></td>
						</tr>
					</table>
						<input type="submit" value="Sign up" id="signBtn" class="loginmodal-submit">
				</form>
			</div>
		</div>
	</div>


	<section class="bg-primary" id="about">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-lg-offset-2 text-center">
					<h2 class="section-heading">We've got what you need!</h2>
					<hr class="light">
					<p class="text-faded">Start Bootstrap has everything you need
						to get your new website up and running in no time! All of the
						templates and themes on Start Bootstrap are open source, free to
						download, and easy to use. No strings attached!</p>
					<a href="#services"
						class="page-scroll btn btn-default btn-xl sr-button">Get
						Started!</a>
				</div>
			</div>
		</div>
	</section>

	<section id="services">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading">Services</h2>
					<hr class="primary">
				</div>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-md-6 text-center">
					<div class="service-box">
						<a href="create"><i
							class="fa fa-4x fa-diamond text-primary sr-icons"></i></a>
						<h3>Create New Project</h3>
						<p class="text-muted">We provide various functions</p>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 text-center">
					<div class="service-box">
						<a href="insert"><i
							class="fa fa-4x fa-paper-plane text-primary sr-icons"></i></a>
						<h3>Insert Command</h3>
						<p class="text-muted">Insert your own command</p>
					</div>
				</div>
				<div class="col-lg-3 col-md-6 text-center">
					<div class="service-box">
						<a href="open"><i
							class="fa fa-4x fa-newspaper-o text-primary sr-icons"></i></a>
						<h3>Open</h3>
						<p class="text-muted">We update dependencies to keep things
							fresh.</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="no-padding" id="portfolio">
		<div class="container-fluid">
			<div class="row no-gutter popup-gallery">
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box"> <img
						src="resources/bootstrap/img/portfolio/thumbnails/1.jpg"
						class="img-responsive" alt="">
						<div class="portfolio-box-caption">
							<div class="portfolio-box-caption-content">
								<div class="project-category text-faded">Category</div>
								<div class="project-name">Project Name</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box"> <img
						src="resources/bootstrap/img/portfolio/thumbnails/2.jpg"
						class="img-responsive" alt="">
						<div class="portfolio-box-caption">
							<div class="portfolio-box-caption-content">
								<div class="project-category text-faded">Category</div>
								<div class="project-name">Project Name</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box"> <img
						src="resources/bootstrap/img/portfolio/thumbnails/3.jpg"
						class="img-responsive" alt="">
						<div class="portfolio-box-caption">
							<div class="portfolio-box-caption-content">
								<div class="project-category text-faded">Category</div>
								<div class="project-name">Project Name</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box"> <img
						src="resources/bootstrap/img/portfolio/thumbnails/4.jpg"
						class="img-responsive" alt="">
						<div class="portfolio-box-caption">
							<div class="portfolio-box-caption-content">
								<div class="project-category text-faded">Category</div>
								<div class="project-name">Project Name</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box"> <img
						src="resources/bootstrap/img/portfolio/thumbnails/5.jpg"
						class="img-responsive" alt="">
						<div class="portfolio-box-caption">
							<div class="portfolio-box-caption-content">
								<div class="project-category text-faded">Category</div>
								<div class="project-name">Project Name</div>
							</div>
						</div>
					</a>
				</div>
				<div class="col-lg-4 col-sm-6">
					<a class="portfolio-box"> <img
						src="resources/bootstrap/img/portfolio/thumbnails/6.jpg"
						class="img-responsive" alt="">
						<div class="portfolio-box-caption">
							<div class="portfolio-box-caption-content">
								<div class="project-category text-faded">Category</div>
								<div class="project-name">Project Name</div>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</section>

	<aside class="bg-dark">
		<div class="container text-center">
			<div class="call-to-action">
				<h2>Free Download at Start Bootstrap!</h2>
				<a href="http://startbootstrap.com/template-overviews/creative/"
					class="btn btn-default btn-xl sr-button">Download Now!</a>
			</div>
		</div>
	</aside>

	<section id="contact">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-lg-offset-2 text-center">
					<h2 class="section-heading">Let's Get In Touch!</h2>
					<hr class="primary">
					<p>Ready to start your next project with us? That's great! Give
						us a call or send us an email and we will get back to you as soon
						as possible!</p>
				</div>
				<div class="col-lg-4 col-lg-offset-2 text-center">
					<i class="fa fa-phone fa-3x sr-contact"></i>
					<p>123-456-6789</p>
				</div>
				<div class="col-lg-4 text-center">
					<i class="fa fa-envelope-o fa-3x sr-contact"></i>
					<p>
						<a href="mailto:your-email@your-domain.com">feedback@startbootstrap.com</a>
					</p>
				</div>
			</div>
		</div>
	</section>

	<!-- jQuery -->
	<script src="resources/bootstrap/vendor/jquery/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="resources/bootstrap/vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Plugin JavaScript -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
	<script
		src="resources/bootstrap/vendor/scrollreveal/scrollreveal.min.js"></script>
	<script
		src="resources/bootstrap/vendor/magnific-popup/jquery.magnific-popup.min.js"></script>

	<!-- Theme JavaScript -->
	<script src="resources/bootstrap/js/creative.min.js"></script>

</body>

</html>
