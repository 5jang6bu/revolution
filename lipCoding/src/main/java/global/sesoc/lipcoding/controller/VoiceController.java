package global.sesoc.lipcoding.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.lipcoding.dao.VoiceDAO;
import global.sesoc.lipcoding.vo.Voice;

@Controller
public class VoiceController {
	private static final Logger logger = LoggerFactory.getLogger(VoiceController.class);
	
	@Autowired
	VoiceDAO dao;
	
	@ResponseBody
	@RequestMapping(value="userCode", method=RequestMethod.POST)
	public String insert(String command){
		String code = dao.userCode(command);
		return code;
	}
	
	@ResponseBody
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public void insert(Voice voice){
		logger.debug(voice.toString());
		dao.insert(voice);
	}
	
	@ResponseBody
	@RequestMapping(value="getList", method=RequestMethod.GET)
	public ArrayList<Voice> getList(){
		ArrayList<Voice> commandList = dao.getList();
		logger.debug(commandList.toString());
		return commandList;
	}
	
	@ResponseBody
	@RequestMapping(value="create", method=RequestMethod.POST)
	public String create(String className){
		return className;
	}
}
