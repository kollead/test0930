package sns.board.action;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import sns.board.db.BoardDTO;


@WebServlet("/board/BoardInsertServlet")
public class BoardInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		HttpSession session = request.getSession();
		
		String email = (String) session.getAttribute("email");
		String imgs = null;
		
		
		// 비 로그인 시 로그인 페이지로 이동
		if (email == null) {
			response.sendRedirect("Login.me");
		}
		
		// 파일 저장 경로
		String savePath = request.getServletContext().getRealPath("/upload/board_img");
		
		// 파일 최대 크기
		int maxSize = 10 * 1024 * 1024;
		
		// 저장 폴더 없으면 생성
		File file;
		if (!(file = new File(savePath)).isDirectory()) {
			file.mkdirs();
		}
		System.out.println("BoardInsertServlet.java - savePath: " + savePath);
		ArrayList<String> filename = new ArrayList<String>();
		
		MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", 
				new DefaultFileRenamePolicy());
		
		// 파일처리
		Enumeration<String> files = multi.getFileNames();
		
		while(files.hasMoreElements()){
			String name = files.nextElement();
			filename.add(multi.getFilesystemName(name));
		}
		System.out.println("BoardInsertServlet.java - filename: " + filename);
		
		System.out.println("BoardInsertServlet.java - filesize: " + filename.size());
		
				
				
/*		String content = ;
		content = content.replace("\r\n","<br>");*/
		
	}

}
