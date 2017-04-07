package global.sesoc.lipcoding.compile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class Initialization {

	String projectName;
	public String homePath = "C:/temp/";

	public Initialization() {
		// TODO Auto-generated constructor stub
	}

	public Initialization(String projectName) {
		this.projectName = projectName;
	}

	public void classpath() {
		this.homePath += /* 이곳에 아이디 경로 추가하는게 좋을듯 ex id= happy /happy */projectName;
		File path = new File(this.homePath);

		if (!path.isDirectory()) {
			path.mkdirs();
		}

		File classpath = new File(this.homePath + "/.classpath");
		File projectFile = new File(this.homePath+ "/.project");

		String projectText = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" + "<projectDescription>\n"
				+ "<name>{projectname}</name>\n" + "<comment></comment>\n" + "<projects>\n" + "</projects>\n"
				+ "<buildSpec>\n" + "	<buildCommand>\n" + "		<name>org.eclipse.jdt.core.javabuilder</name>\n"
				+ "		<arguments>\n" + "		</arguments>\n" + "	</buildCommand>\n" + "</buildSpec>\n"
				+ "<natures>\n" + "	<nature>org.eclipse.jdt.core.javanature</nature>\n" + "</natures>\n"
				+ "</projectDescription>";

		projectText = projectText.replace("{projectname}", projectName);

		String classpathtext = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" + "<classpath>\n"
				+ "<classpathentry kind=\"src\" path=\"src\"/>\n"
				+ "<classpathentry kind=\"con\" path=\"org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/JavaSE-1.8\"/>\n"
				+ "<classpathentry kind=\"output\" path=\"bin\"/>\n" + "</classpath>";

		FileOutputStream fos;
		try {
			fos = new FileOutputStream(classpath);
			fos.write(classpathtext.getBytes());
			fos.flush();
			fos.close();
			fos = new FileOutputStream(projectFile);
			fos.write(projectText.getBytes());
			fos.flush();
			fos.close();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
		File file = new File(this.homePath+"/src/");

		if (!file.isDirectory()) {
			file.mkdirs();
		}
		
		File file2 = new File(this.homePath+"/bin/");

		if (!file2.isDirectory()) {
			file2.mkdirs();
		}
	}

}
