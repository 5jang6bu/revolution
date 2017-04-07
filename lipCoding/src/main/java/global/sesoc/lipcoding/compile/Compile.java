package global.sesoc.lipcoding.compile;

import java.io.File;
import java.io.FileOutputStream;

import global.sesoc.lipcoding.vo.JavaFile;

public class Compile {

	public JavaFile java;
	// sb.append(" cd C:/temp && javac -encoding utf-8 -d . Test1.java&& javac
	// -encoding utf-8 -d . Test.java&& java ss.Test ");
	// javac -encoding UTF-8 -d bin src/Test.java

//	public String compile() {
//
//		StringBuilder sb = new StringBuilder();
//
//		Process process = null;
//
//		BufferedReader br = null;
//		StringBuffer stdMsg = new StringBuffer();
//		StringBuffer errMsg = new StringBuffer();
//		try {
//
//			String[] cmd = new String[] { "cmd.exe", "/y", "/c", sb.toString() };
//			sb.append("cd " + this.path);
//
//			for (PackageName p : project.getPlist()) {
//
//				File path = new File(this.path + "/bin/");
//				if (!path.isDirectory()) {
//					path.mkdirs();
//				}
//
//				sb.append("&&javac -encoding utf-8 -d bin/");
//				String str = "{packagename}";
//				// int var = sb.indexOf("{packagename}");
//				// sb.replace(var, var + str.length(), p.getPackageName());
//
//				sb.append(" src/{packagename}/*.java");
//				int var = sb.indexOf("{packagename}");
//				sb.replace(var, var + str.length(), p.getPackageName());
//
//				// for (JavaFile j : p.getClasslist()) {
//				// sb.append("src/{classname}.java");
//				// str = "{classname}";
//				// var = sb.indexOf(str);
//				// sb.replace(var, var + str.length(), j.getClassName());
//				// }
//			}
//			System.out.println(" - StringBuilder capacity: " + sb.capacity());
//
//			System.out.println(" - StringBuilder length: " + sb.length());
//
//			System.out.println(" - Command: " + sb.toString());
//
//			// 콘솔 명령 실행
//			process = Runtime.getRuntime().exec(cmd);
//			// 실행 결과 확인 (에러)
//
//			// 스레드로 inputStream 버퍼 비우기
//
//			ProcessOutputThread o = new ProcessOutputThread(process.getInputStream(), stdMsg);
//			o.start();
//			// 스레드로 errorStream 버퍼 비우기
//
//			o = new ProcessOutputThread(process.getErrorStream(), errMsg);
//
//			o.start();
//
//			// 수행종료시까지 대기
//
//			process.waitFor();
//		} catch (IOException e) {
//
//			e.printStackTrace();
//
//		} catch (InterruptedException e) {
//			e.printStackTrace();
//		}
//
//		process.destroy();
//		sb.delete(0, sb.length());
//
//		sb.setLength(0);
//
//		sb = null;
//		if (errMsg == null)
//			return stdMsg.toString();
//		else
//			return errMsg.toString();
//	}// src는 java파일
//		// bin class 파일

	public void save(JavaFile java) {
		String path = "C:/temp/" + java.getProjectName();
		String javapath = path + "/src/" + java.getPackageName();
		File src = new File(javapath);

		if (!src.isDirectory()) {
			src.mkdirs();
		}

		File javafile = new File(javapath + "/" + java.getClassName()+".java");
		FileOutputStream fos;
		try {
			fos = new FileOutputStream(javafile);
			fos.write(java.getText().getBytes());
			fos.flush();
			fos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		
		
		StringBuilder sb = new StringBuilder();
		Process process = null;

		StringBuffer stdMsg = new StringBuffer();
		StringBuffer errMsg = new StringBuffer();
		
		sb.append("cd " +path );//home지정
		sb.append("&& javac -cp bin -encoding utf-8 -d bin src/"+java.getPackageName()+"/"+java.getClassName()+".java");
		try {
			String[] cmd = new String[] { "cmd.exe", "/y", "/c", sb.toString() };
		
			process = Runtime.getRuntime().exec(cmd);
			
			ProcessOutputThread o = new ProcessOutputThread(process.getInputStream(), stdMsg);
			o.start();
			// 스레드로 errorStream 버퍼 비우기

			o = new ProcessOutputThread(process.getErrorStream(), errMsg);

			o.start();

			// 수행종료시까지 대기

			process.waitFor();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		process.destroy();
		sb.delete(0, sb.length());

		sb.setLength(0);

		sb = null;

	}

	public void run(JavaFile java){
		String path = "C:/temp/" + java.getProjectName();
		
		StringBuilder sb = new StringBuilder();
		Process process = null;
		StringBuffer stdMsg = new StringBuffer();
		StringBuffer errMsg = new StringBuffer();
		
		//java -cp c:\temp\show\bin a.User2 javac -d . a/*.java
		
		sb.append("java -cp "+path+"/bin " + java.getPackageName()+"."+java.getClassName());
		System.out.println(sb.toString());
		try {

			String[] cmd = new String[] { "cmd.exe", "/y", "/c", sb.toString() };
		
			process = Runtime.getRuntime().exec(cmd);
			
			ProcessOutputThread o = new ProcessOutputThread(process.getInputStream(), stdMsg);
			o.start();
			// 스레드로 errorStream 버퍼 비우기

			o = new ProcessOutputThread(process.getErrorStream(), errMsg);

			o.start();

			// 수행종료시까지 대기

			process.waitFor();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		process.destroy();
		sb.delete(0, sb.length());

		sb.setLength(0);

		sb = null;
		
	}
}
