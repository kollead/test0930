package sns.board.action;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import sns.board.db.CommentDAO;
import sns.board.db.CommentDTO;

/**
 * Servlet implementation class CommentInsertServlet
 */
@WebServlet("/main/CommentInsertServlet")
public class CommentInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("comment doGet");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("comment doPost");
		request.setCharacterEncoding("UTF-8");
		
		String content=request.getParameter("content");
		System.out.println(content);
		
		int bNum=Integer.parseInt(request.getParameter("bNum"));
		System.out.println(bNum);
		
		HttpSession session=request.getSession();
		String email=(String)session.getAttribute("email");
		System.out.println(email);
		int m_num=(Integer)session.getAttribute("m_num");
		System.out.println(m_num);
				
		CommentDAO cdao=new CommentDAO();
		CommentDTO cdto= new CommentDTO();
		
		cdto=cdao.commentInsert(bNum,content,m_num);
		
		GsonBuilder builder=new GsonBuilder();
		Gson gson=new Gson();
		String json=gson.toJson(cdto);
		System.out.println(json);
		
		StringBuffer result=new StringBuffer();
		result.append(json);		
		
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(result.toString());
	}

}
