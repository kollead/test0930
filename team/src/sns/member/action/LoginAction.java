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
		int m_num=mdao.getMyM_num(email);
		
		
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
		
		
		HttpSession session= request.getSession();
		session.setAttribute("email", email);
		session.setAttribute("m_num", m_num);
		System.out.println("session 생성 : "+email);
		
		if(request.getParameter("loginCheck")!=null) {
			//로그인 상태 유지 쿠키 생성
			
			Cookie cookieE=new Cookie("AutoLog",email);
			Cookie cookieI=new Cookie("AutoLogI",request.getRemoteAddr());
			System.out.println("AutoLogI: "+request.getRemoteAddr());
			cookieE.isHttpOnly();
			cookieE.getSecure();
			cookieE.setMaxAge(60*60*24*7);
			cookieE.setDomain("localhost");
			cookieI.isHttpOnly();
			cookieI.getSecure();
			cookieI.setMaxAge(60*60*24*7);
			cookieI.setDomain("localhost");
			response.addCookie(cookieE);
			response.addCookie(cookieI);
		}		
		
		
		ActionForward forward=new ActionForward();
		forward.setPath("./Main.ma");
		forward.setRedirect(true);
				
		return forward;
	}
	
	

}
