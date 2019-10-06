package sns.member.action;

import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sns.member.db.MemberDAO;

public class LoginAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("LoginAction-----------");
		
		String email=request.getParameter("email");
		String pass=request.getParameter("pass");
		
		
		System.out.println(email+" : "+pass);
		
		MemberDAO mdao=new MemberDAO();		
		int check=mdao.login(email, pass);
		
		
		if(check==0) {//비밀번호 오류
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script> ");
			out.println("  alert('비밀번호가 일치하지 않습니다'); ");
			out.println("  history.back(); ");
			out.println("</script>");
			
			out.close();
			return null;
			
		}else if(check==-1) {//아이디 존재 않음
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script> ");
			out.println("  alert('존재하지 않는 이메일입니다'); ");
			out.println("  history.back(); ");
			out.println("</script>");
			
			out.close();
			return null;
		}
		
		if(request.getParameter("loginCheck")!=null) {
			//로그인 상태 유지 쿠키 생성
			/*Cookie user=new Cookie("email", email);
			user.isHttpOnly();
			user.getSecure();
			user.setMaxAge(60*60*24*7);
			user.setDomain("localhost");
			Cookie pwd=new Cookie("pass",pass);
			pwd.isHttpOnly();
			pwd.getSecure();
			pwd.setMaxAge(60*60*24*7);
			pwd.setDomain("localhost");
			response.addCookie(user);
			response.addCookie(pwd);*/			
		}		
		
		HttpSession session= request.getSession();
		session.setAttribute("email", email);
		System.out.println("session 생성 : "+email);
		
		ActionForward forward=new ActionForward();
		forward.setPath("./Main.me");
		forward.setRedirect(true);
				
		return forward;
	}
	
	

}
