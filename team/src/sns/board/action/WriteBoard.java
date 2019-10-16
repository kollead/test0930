package sns.board.action;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold=1024*1024*10, maxFileSize=1024*1024*50,maxRequestSize=1024*1024*100)
@WebServlet("/board/WriteBoard")
public class WriteBoard extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	private static final String UPLOAD_DIR = "filefolder";
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGetWrite");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		System.out.println("doPostWrite");
		
		String applicationPath = request.getServletContext().getRealPath("");
		String uploadFilePath = applicationPath + UPLOAD_DIR;
		
		// creates the save directory if it does not exists
		File fileSaveDir = new File(uploadFilePath);
				
		// 파일 경로 없으면 생성
		if (!fileSaveDir.exists()) {
					fileSaveDir.mkdirs();
				}
		
		Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">
	    String fileName = UUID.randomUUID().toString()+filePart.getSubmittedFileName();
	    // MSIE fix.
	    System.out.println(fileName+" "+uploadFilePath);
	    filePart.write(uploadFilePath+ File.separator +fileName);
		
	}

}
