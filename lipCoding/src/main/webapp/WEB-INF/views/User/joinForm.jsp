<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Let's get you sign up</title>
<script src="../resources/js/jquery-3.1.1.min.js"></script>
<script>
$(document).ready(function() {
	$("#userId").on('keyup', check);	
	$("#password").on('keyup', passwordSpan);
	$("#passwordConfirm").on('keyup', passwordConfirmSpan);
	$("#nickname").on('keyup', nicknameSpan);
	/* $("#checkBtn").on('click',check); */
});
var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
var idConfirm = false;

function formCheck(){
	
	var userId=document.getElementById("userId").value;
	var password=document.getElementById("password").value;
	var passwordConfirm=document.getElementById("passwordConfirm").value;
	var nickname=document.getElementById("nickname").value;
	var check = h_check(nickname);
	
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
<body>
<h1> Let's get you sign up</h1>



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
	<input type="submit" value="Sign up" id="signBtn">
</form>

</body>
</html>