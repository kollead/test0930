package sns.member.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class MemberController extends HttpServlet{
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("doProcess() 호출!");
		
		String requestURI = request.getRequestURI();
		System.out.println("requestURI: "+requestURI);
		StringBuffer requestURL = request.getRequestURL();
		String contextPath = request.getContextPath();
		System.out.println("contextPath: "+contextPath);
		String command = requestURI.substring(contextPath.length());
		System.out.println("command: "+command);
		
		Action action = null;
		ActionForward forward = null;
		
		if(command.equals("/Login.me")){	
			
			forward=new ActionForward();
			forward.setPath("./member/login.jsp");
			forward.setRedirect(false);
			
		}else if(command.equals("/LoginAction.me")) {
			
			action= new LoginAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {				
				e.printStackTrace();
			}
			
		}else if(command.equals("/Main.me")) {
			
			forward=new ActionForward();
			forward.setPath("./member/main.jsp");
			forward.setRedirect(false);
			
		}
		
		
		//------------------------------------------
		if(forward != null){			
			if(forward.isRedirect()){				
				response.sendRedirect(forward.getPath());
			}else{				
				RequestDispatcher dis =
						request.getRequestDispatcher(forward.getPath());
				dis.forward(request, response);				
			}
			
		}
		
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
}
