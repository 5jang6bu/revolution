package global.sesoc.lipcoding.vo;

public class User {
	private int userNum;
	private String userId;
	private String nickname;
	private String password;
	private String birthday;
	private String address;
	
	public User(){
		super();
	}
		
	public User(int userNum, String userId, String nickname, String password, String birthday, String address) {
		super();
		this.userNum = userNum;
		this.userId = userId;
		this.nickname = nickname;
		this.password = password;
		this.birthday = birthday;
		this.address = address;
	}

	public int getUserNum() {
		return userNum;
	}

	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public String toString() {
		return "usertable [userNum=" + userNum + ", userId=" + userId + ", nickname=" + nickname + ", password="
				+ password + ", birthday=" + birthday + ", address=" + address + "]";
	}	
}
