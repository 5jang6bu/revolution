package global.sesoc.lipcoding.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.lipcoding.compile.Compile;
import global.sesoc.lipcoding.compile.Initialization;
import global.sesoc.lipcoding.vo.JavaFile;

@Controller
public class CompileController {

	private static final Logger logger = LoggerFactory.getLogger(CompileController.class);

	public static String projectName;
	public static ArrayList<JavaFile> javafilelist = new ArrayList<>();

	public static String path = "C:/temp/";

	@RequestMapping(value = "compile", method = RequestMethod.GET)
	public String get() {

		return "compile";
	}


	@ResponseBody
	@RequestMapping(value = "save", method = RequestMethod.POST)
	public void save(JavaFile javafile) {
		logger.debug(javafile.toString());
		
		Compile compile = new Compile();
		compile.save(javafile);
		
		//return "compile";
	}

	@ResponseBody
	@RequestMapping(value = "startProject", method = RequestMethod.POST)
	public void startProject(String projectName) {
		
		//logger.debug(projectName);
		
		Initialization init = new Initialization(projectName);
		init.classpath();
		//return "compile";
	}
	
	//@ResponseBody
	@RequestMapping(value = "run", method = RequestMethod.POST)
	public String run(JavaFile javafile) {
		logger.debug(javafile.toString());
		
		Compile compile = new Compile();
		compile.run(javafile);
		
		return "compile";
	}

}
