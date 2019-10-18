package sns.board.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sns.member.action.Action;
import sns.member.action.ActionForward;

public class BoardController extends HttpServlet{

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
