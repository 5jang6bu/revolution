package global.sesoc.lipcoding.dao;

import global.sesoc.lipcoding.vo.Voice;

public interface VoiceMapper {

	public String userCode(String command);
	
	public void insert(Voice voice);
}
