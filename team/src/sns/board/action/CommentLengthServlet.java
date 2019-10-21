package sns.board.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import sns.board.db.CommentDAO;
import sns.board.db.CommentDTO;


@WebServlet("/main/CommentLengthServlet")
public class CommentLengthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bNum=Integer.parseInt(request.getParameter("bNum"));
		CommentDAO cdao=new CommentDAO();
		int num=cdao.commentLength(bNum);
		System.out.println("CommentLengthServ "+num);
		response.setContentType("text/html;charset=utf-8"); 
		response.setCharacterEncoding("utf-8");
        response.getWriter().write(getJSON(num));
		
	}
	
	public String getJSON(int num) {
		
		StringBuffer result=new StringBuffer();
				
		JsonObject json=new JsonObject();
		json.addProperty("number", num);
						
		result.append(json);
		
		System.out.println(result.toString());
		return result.toString();
	}
	
	

}
