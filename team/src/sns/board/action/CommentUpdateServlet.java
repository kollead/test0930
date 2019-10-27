package sns.board.action;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sns.board.db.CommentDAO;

/**
 * Servlet implementation class CommentUpdateServlet
 */
@WebServlet("/main/CommentUpdateServlet")
public class CommentUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("UpdatedoGet");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("UpdatedoPost");
		
		int c_num=Integer.parseInt(request.getParameter("c_num"));
		String content=request.getParameter("content");
		
		System.out.println(c_num+" "+content);
		
		CommentDAO cdao=new CommentDAO();
		cdao.commentUpdate(c_num, content);
		
	}

}
