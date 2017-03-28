package global.sesoc.lipcoding.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
/*import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;*/
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.lipcoding.dao.UserDAO;
import global.sesoc.lipcoding.vo.User;

@Controller
@RequestMapping("User")
public class UserController {
	/*@Autowired
	private JavaMailSender mailSender;*/
	
	@Autowired
	UserDAO dao;
	
	//회원가입창 열기
	@RequestMapping(value="joinForm", method=RequestMethod.GET)
	public String joinForm(Model model){
		return "User/joinForm";				
	}
	
	//회원가입 처리
	@RequestMapping(value="joinForm", method=RequestMethod.POST)
	public String join(User user){
				
		int result = 0;		
		
		try {
			result = dao.insert(user);			
			/*
			int ran = new Random().nextInt(1000000) + 1; // 1 ~ 999999
		    String joinCode = String.valueOf(ran);
		   
			String setfrom = "libcoding@gmail.com";         
		    String tomail  = user.getUserId();     			 	// 받는 사람 이메일
		    String title   = "libcoding 회원가입 인증 코드 발급 안내 입니다";    // 메일 제목		    
		    String content = "귀하의 인증 코드는 [ " + joinCode + " ] 입니다";   // 메일 내용
		   
		    
		      MimeMessage message = mailSender.createMimeMessage();
		      System.out.println(message);
		      MimeMessageHelper messageHelper 
		                        = new MimeMessageHelper(message, true, "UTF-8");
		 
		      messageHelper.setFrom(setfrom);  	// 보내는사람 생략하거나 하면 정상작동을 안함
		      messageHelper.setTo(tomail);     	// 받는사람 이메일
		      messageHelper.setSubject(title);	 // 메일제목은 생략이 가능하다
		      messageHelper.setText(content);  // 메일 내용
		 
		      mailSender.send(message);*/
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (result == 0) {			
			return "User/joinForm";
		}		
		return "redirect:/";
	}
	
	
	//아이디 중복확인
	@ResponseBody
	@RequestMapping(value = "idcheck", method = RequestMethod.POST)
	public int idCheck(String userId) {
		int result = 0;
		
		User user = dao.idCheck(userId);		
		if(user.getUserId() != null){
			result = 1;
		}
		return result;
	}
	
	//비밀번호 유효성체크
	@ResponseBody
	@RequestMapping(value = "password", method = RequestMethod.POST)
	public int password(String password) {		
		
		if(password.equals(null)){
			return 0;
		}else if(password.length() < 8 || password.length() > 16){						
			return -1;
		}else{			
		return 1;
		}
	}
		
	//비밀번호일치 여부를 확인
	@ResponseBody
	@RequestMapping(value = "passwordConfirm", method = RequestMethod.POST)
	public int passwordC(String password, String passwordConfirm) {				
		
		if(password.equals(passwordConfirm)){
			return 1;
		}else{				
			return -1;
		}
	}
		
	//닉네임 확인
	@ResponseBody
	@RequestMapping(value = "nickname", method = RequestMethod.POST)
	public int nickname(String nickname) {		
		
		if(nickname.length() < 4 || nickname.length() > 14){
			return -1;
		}else{
			return 1;
		}
	}
}




