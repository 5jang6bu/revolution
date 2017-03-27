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

<script>
	$(document).ready(function() {
		//settingName();
	});

	function settingName() {
		var name = prompt('생성할 프로젝트 이름을 설정하세요');
		console.log(name);
	}
</script>
</head>
<body>

	<nav id="mainNav" class="navbar navbar-default navbar-fixed-top">
		<div id="divRoot">
			<div class="container-fluid">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span> Menu <i
							class="fa fa-bars"></i>
					</button>
					<a class="navbar-brand page-scroll" href="/lipcoding">Lip
						Coding</a>
				</div>

				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse"
					id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav navbar-right">
						<li><a class="page-scroll" href="/lipcoding#about">About</a>
						</li>
						<li><a class="page-scroll" href="/lipcoding#services">Services</a>
						</li>
						<li><a class="page-scroll" href="/lipcoding#portfolio">Team</a>
						</li>
						<li><a class="page-scroll" href="/lipcoding#contact">Contact</a>
						</li>
					</ul>
				</div>
			</div>
			
			<div class="userSpace">
				<%@ include file="create_menu.jsp" %>
				<%@ include file="create_folder.jsp" %>
				<div id="divSpace">
					<%@ include file="create_code.jsp" %>
				</div>
			</div>
		</div>
	</nav>
	
	<header>
        <div class="header-content">
            <div class="header-content-inner">
            </div>
        </div>
    </header>
	
	<!-- jQuery -->
    <!-- <script src="resources/bootstrap/vendor/jquery/jquery.min.js"></script> -->

    <!-- Bootstrap Core JavaScript -->
    <script src="resources/bootstrap/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
    <script src="resources/bootstrap/vendor/scrollreveal/scrollreveal.min.js"></script>
    <script src="resources/bootstrap/vendor/magnific-popup/jquery.magnific-popup.min.js"></script>

    <!-- Theme JavaScript -->
    <script src="resources/bootstrap/js/creative.min.js"></script>
	
</body>
</html>