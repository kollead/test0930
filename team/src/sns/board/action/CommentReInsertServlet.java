package sns.board.action;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		
		//c_num 만 들고가서... db를 조회하면..,. 되지 않나...........왜이런...어차피...re_ref는....글 조회하면서 만들어 졌으므로... 굳이 다 가져갈필요... X......
		String content=request.getParameter("content");
		int c_num=Integer.parseInt(request.getParameter("c_num"));
		
		HttpSession session=request.getSession();
		String email=(String)session.getAttribute("email");
		System.out.println(email);
		
		
		CommentDAO cdao=new CommentDAO();
		String name=cdao.commentReInsert(content, c_num, email);
		
		System.out.println(name);
		response.setContentType("text/html;charset=utf-8"); 
		response.setCharacterEncoding("utf-8");
        response.getWriter().write(name);
		
	}

}
