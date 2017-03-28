package global.sesoc.lipcoding.dao;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.lipcoding.vo.User;

@Repository
public class UserDAO {
	@Autowired
	SqlSession sqlSession;
	
	
	public int insert(User user){		
		UserMapper mapper = sqlSession.getMapper(UserMapper.class);
		int result = mapper.insert(user);
		return result;
	}

	public User idCheck(String userId){
		UserMapper mapper=sqlSession.getMapper(UserMapper.class);
		User user = mapper.idCheck(userId);
		return user;
	}

/*	public void authNumInsert(int userNum, String joinCode) {
		UserMapper mapper=sqlSession.getMapper(UserMapper.class);
		mapper.authNumInsert(userNum, joinCode);
		
	}*/
	
}
