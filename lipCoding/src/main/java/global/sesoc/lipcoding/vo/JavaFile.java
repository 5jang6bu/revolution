package global.sesoc.lipcoding.vo;

public class JavaFile {

	String className;
	String text;
	String packageName;
	String projectName;

	public JavaFile() {
		// TODO Auto-generated constructor stub
	}

	public JavaFile(String className, String text, String packageName, String projectName) {
		super();
		this.className = className;
		this.text = text;
		this.packageName = packageName;
		this.projectName = projectName;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	@Override
	public String toString() {
		return "JavaFile [className=" + className + ", text=" + text + ", packageName=" + packageName + ", projectName="
				+ projectName + "]";
	}

}
