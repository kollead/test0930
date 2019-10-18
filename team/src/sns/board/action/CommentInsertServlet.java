package sns.board.action;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sns.board.db.CommentDAO;

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
				
		CommentDAO cdao=new CommentDAO();
		String name=cdao.commentInsert(bNum,content,email);
		System.out.println(name);
		response.setContentType("text/html;charset=utf-8"); 
		response.setCharacterEncoding("utf-8");
        response.getWriter().write(name);
	}

}
