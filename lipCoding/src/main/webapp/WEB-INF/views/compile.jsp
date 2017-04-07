<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form  action="startProject" method="post">
프로젝트 이름<input type="text" name="projectName"><br>
<input type="submit" value= "초기화">
</form>

<form action="save" method="post">

프로젝트 이름<input type="text" name="projectName"><br>
패키지 이름<input type="text" name="packageName"> <br>
클래스 이름<input type="text" name="className"><br>

<br>
<textarea rows="10" cols="10" name="text">
package a;
public class User2 {
	private int userNum = 5;
	public User2(){
 System.out.println("출력");
}
}
</textarea><br>
	
<input type="submit" value="보내기">
</form>

<form action="run" method="post">

프로젝트 이름<input type="text" name="projectName"><br>
패키지 이름<input type="text" name="packageName"> <br>
클래스 이름<input type="text" name="className"><br>

<input type="submit" value="전송">	
</form>
</body>
</html>