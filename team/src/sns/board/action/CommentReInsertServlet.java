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
		
		
		CommentDAO cdao=new CommentDAO();
		ArrayList arr=cdao.commentReInsert(content, c_num, email);
				
		StringBuffer result=new StringBuffer();
		
		JsonObject json=new JsonObject();
		
		String name=(String)arr.get(0);
		int re_lev=(int) arr.get(1);
		json.addProperty("name", name);
		json.addProperty("re_lev", re_lev);
								
		result.append(json);
		
		System.out.println("result: "+result.toString());
		
		response.setCharacterEncoding("UTF-8");			
		response.getWriter().write(result.toString());
		
	}

}
