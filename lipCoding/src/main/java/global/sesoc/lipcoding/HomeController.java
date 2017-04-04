package global.sesoc.lipcoding;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "index";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(){
		return "create";
	}
	
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String login(){
		return "loginUI";
	}
	
	@RequestMapping(value="insert", method=RequestMethod.GET)
	public String insert(){
		return "insert";
	}
	
	@RequestMapping(value="open", method=RequestMethod.GET)
	public String open(){
		return "open";
	}
	
	/*@RequestMapping(value="index", method=RequestMethod.GET)
	public String index(){
		return "index";
	}*/
}
