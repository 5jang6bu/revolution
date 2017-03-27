package global.sesoc.lipcoding.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.lipcoding.vo.Parsing;

@Controller
public class DiaController {
	private static final Logger logger = LoggerFactory.getLogger(VoiceController.class);
	
	@ResponseBody
	@RequestMapping(value = "textparsing", method = RequestMethod.POST)
	public ArrayList<Parsing> textparsing(String text) {
		int parents =0;
		String title =null;
		String name =null;
		int key=0;
		
		ArrayList<Parsing> cList = new ArrayList<>();
	
		String[] str = new String(text).split(" |\\{|;|\n|\t");
		System.out.println(text);
		Parsing parsing = new Parsing(1,"project","project");
		cList.add(parsing);
		
		for(int i=0; i<str.length; i++) {
			if(str[i].equals("package")){
				key=2;
				title ="package";
				parents=1;
				name = str[i+1];
				System.out.println(str[i+1]);
				Parsing parsing2 = new Parsing(key, name, title, parents);
				cList.add(parsing2);
			}
			if(str[i].equals("class")){
				key=3;
				title ="class";
				parents=2;
				name=str[i+1];
				Parsing parsing3 = new Parsing(key, name, title, parents);
				cList.add(parsing3);
			}
		}
		return cList;
	}
	
}
