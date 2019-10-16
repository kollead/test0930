package sns.board.action;


import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold=1024*1024*10, maxFileSize=1024*1024*50,maxRequestSize=1024*1024*100,location="D:\\workspace_jsp7\\JQuery\\WebContent\\vid")
@WebServlet("/JQPractice/InputForm")
public class InputForm extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		System.out.println("doGet");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("doPost");
		
		Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">
	    String fileName = UUID.randomUUID().toString()+filePart.getSubmittedFileName();
	    // MSIE fix.
	    filePart.write(fileName);    
		
	}

}
