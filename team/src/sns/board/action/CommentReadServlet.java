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

/**
 * Servlet implementation class CommentReadServlet
 */
@WebServlet("/main/CommentReadServlet")
public class CommentReadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("get");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Read Comm post");
		
		request.setCharacterEncoding("UTF-8");
		int bNum=Integer.parseInt(request.getParameter("bNum"));
		int num=Integer.parseInt(request.getParameter("getNum"));
		System.out.println(bNum);
		
		response.setCharacterEncoding("UTF-8");		
		response.getWriter().write(getJSON(bNum,num));
		
		
	}
	
	public String getJSON(int bNum,int num) {
		ArrayList<CommentDTO> arr=new ArrayList<CommentDTO>();
		StringBuffer result=new StringBuffer();
		
		CommentDAO cdao=new CommentDAO();		
		
		arr=cdao.commentRead(bNum,num*5);
		
		GsonBuilder builder=new GsonBuilder();
		Gson gson=new Gson();
		String json=gson.toJson(arr);
				
		result.append(json);
		
		System.out.println(result.toString());
		return result.toString();
	}

}
