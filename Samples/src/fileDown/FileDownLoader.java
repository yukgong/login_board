package fileDown;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/fileDown")
public class FileDownLoader extends HttpServlet {

	ServletConfig mConfig = null;
	final int BUFFER_SIZE = 8192;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		mConfig = config; // 파일 업로드 경로를 취득하기 위함
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String fileName = req.getParameter("fileName");
		
		// download 횟수 증가
		BufferedOutputStream out = new BufferedOutputStream(resp.getOutputStream());
		String filePath = "";
		
		// tomcat(server)에서 가져오는 방법
		filePath = mConfig.getServletContext().getRealPath("/upload");
		
		// 폴더(client)에서 가져오는 방법
		// filePath = "d:\\tmp";
		
		filePath = filePath + "\\" + fileName;
		System.out.println("filePath : " + filePath);
		
		File f = new File(filePath);
		if(f.exists() && f.canRead()) {
			resp.setHeader("Content-Disposition", "attachment; fileName=\"" + fileName + "\";");
			resp.setHeader("Content-Transfer-Encoding", "binary;");
			resp.setHeader("Content-Length", "" + f.length());
			resp.setHeader("Pragma", "no-cache;"); 
			resp.setHeader("Expires", "-1;");
		}
		
		// 파일 생성, 기입
		BufferedInputStream fileInput = new BufferedInputStream(new FileInputStream(f));
		byte buffer[] = new byte[BUFFER_SIZE];
		int read = 0;
		
		while((read = fileInput.read(buffer)) != -1) {
			out.write(buffer, 0, read); // 실제 다운로드 되는 부분
		}
		
		fileInput.close(); // 꼭 닫아주기!
		out.flush(); // 꼭 닫아주기!
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
}
