package sns.board.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import sns.board.db.CommentDAO;
import sns.board.db.CommentDTO;

@WebServlet("/main/CommentReInsertServlet")
public class CommentReInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ReInsert Get");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("ReInsert Post");
		//content:content, b_num:b_num, c_num:c_num
		
		String content=request.getParameter("content");
		int c_num=Integer.parseInt(request.getParameter("c_num"));
		
		HttpSession session=request.getSession();
		String email=(String)session.getAttribute("email");
		System.out.println(email);
		int m_num=(Integer)session.getAttribute("m_num");
		
		
		CommentDAO cdao=new CommentDAO();
		CommentDTO cdto=new CommentDTO();
		cdto=cdao.commentReInsert(content, c_num, m_num);
				
		StringBuffer result=new StringBuffer();
		
		
		GsonBuilder builder=new GsonBuilder();
		Gson gson=new Gson();
		String json=gson.toJson(cdto);
		System.out.println(json);
								
		result.append(json);
		
		System.out.println("result: "+result.toString());
		
		response.setCharacterEncoding("UTF-8");			
		response.getWriter().write(result.toString());
		
	}

}
