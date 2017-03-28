package global.sesoc.lipcoding.dao;

import global.sesoc.lipcoding.vo.User;

public interface UserMapper {

	//회원가입
	public int insert(User user);

	public User idCheck(String searchid);

	public void authNumInsert(int userNum, String joinCode);

}
