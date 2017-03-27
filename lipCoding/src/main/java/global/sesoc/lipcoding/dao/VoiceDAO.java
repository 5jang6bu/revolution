package global.sesoc.lipcoding.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.lipcoding.vo.Voice;

@Repository
public class VoiceDAO {

	@Autowired
	SqlSession sqlSession;
	
	public String userCode(String command){
		VoiceMapper mapper = sqlSession.getMapper(VoiceMapper.class);
		String code = mapper.userCode(command);
		return code;
	}
	
	public void insert(Voice voice){
		VoiceMapper mapper = sqlSession.getMapper(VoiceMapper.class);
		mapper.insert(voice);
	}
	
	public ArrayList<Voice> getList(){
		VoiceMapper mapper = sqlSession.getMapper(VoiceMapper.class);
		ArrayList<Voice> commandList = mapper.getList();
		return commandList;
	}
}

