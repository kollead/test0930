package sns.board.action;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sns.board.db.CommentDAO;


@WebServlet("/main/CommentDeleteServlet")
public class CommentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("get Delete");
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("post Delete");
		
		int c_num=Integer.parseInt(request.getParameter("c_num"));
		System.out.println(c_num);
		
		CommentDAO cdao=new CommentDAO();
		cdao.commentDelete(c_num);
	}

}
