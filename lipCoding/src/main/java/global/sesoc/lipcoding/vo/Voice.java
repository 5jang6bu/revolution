package global.sesoc.lipcoding.vo;

public class Voice {
	
	private String command;
	private String code;
	
	public Voice() {
		// TODO Auto-generated constructor stub
	}

	public String getCommand() {
		return command;
	}

	public void setCommand(String command) {
		this.command = command;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Override
	public String toString() {
		return "Voice [command=" + command + ", code=" + code + "]";
	}
	
}