<%@page import="dto.PdsDto"%>
<%@page import="dao.PdsDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
// 업로드 함수 
public String processUploadFile(FileItem fileItem, String dir) throws IOException{
	
	String filename = fileItem.getName(); // 경로 + 파일명 얻어오기
	long sizeInBytes = fileItem.getSize(); // 파일 크기 얻어오기
	
	// 파일이 정상일 경우
	if(sizeInBytes > 0){
		System.out.println("정상적으로 등록했습니다."); 
		
		// 파일명과 경로를 뽑아내기 위한 처리
		int	index = filename.lastIndexOf("\\"); // d:\\tmp\\abc.txt <- 마지막 \\을 찾으면 그 다음이 파일명이 된다.
		if(index == -1){
			index = filename.lastIndexOf("/"); // "\\"형식이 아니면, "/" 형식으로 되어있을 테니까. 둘다 처리할 수 있도록 구문 처리
		}
		
		
		filename = filename.substring(index + 1); // "\\"가 있는 인덱스를 기점으로 뒤의 인덱스 모두 잘라오기
		File upLoadFile = new File(dir, filename);
		
		try{
			fileItem.write(upLoadFile); // 실제 업로드 부분
		} catch(Exception e){}
	}
	return filename; // DB에 저장하기 위한 return
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
<%
// tomcat 배포(Server)
	String fupload = application.getRealPath("/upload");

// // 지정 폴더(client)
// 	String fupload = "d:\\temp";

System.out.println("업로드 폴더 : " + fupload);
String yourTempDir = fupload;

//파일의 최대 사이즈를 지정한다.
int yourMaxReqestSize = 100 * 1024 * 1024; 	// memory 크기 지정
int yourMaxMemorySize = 100 * 1024;			// client에서 server로 전송 되는 request의 총 용량 지정

// form field의 데이터를 저장할 변수 준비하기
String email = "";
String title = "";
String content = "";

// 파일 데이터를 저장할 변수 준비
String filename = "";

//  multiport/form-data 여부 확인
boolean isMultiPart = ServletFileUpload.isMultipartContent(request);

if(isMultiPart == true){
	// file 아이템 생성하기
	
	// 2. 메모리나 파일로 업로드 파일 보관하는 FileItem의 Factory 설정
	DiskFileItemFactory factory = new DiskFileItemFactory();
	
	// 3. 파일의  사이즈를 지정한다.
	factory.setSizeThreshold(yourMaxMemorySize); 
	
	factory.setRepository(new File(yourTempDir));
	
	// 4. 업로드 요청을 처리하는 ServletFileUpload 생성
	ServletFileUpload upload = new ServletFileUpload(factory);
	upload.setSizeMax(yourMaxReqestSize); // 총 request의 사이즈 설정

    
    // 5. 업로드 요청 파싱해서 FileItem 목록 구함
	List<FileItem> items = upload.parseRequest(request);
	Iterator<FileItem> it = items.iterator();

	// 구분
	while(it.hasNext()){
		FileItem item = it.next();
		if(item.isFormField()){ // email, title, content
			if(item.getFieldName().equals("email")){
				email = item.getString("utf-8"); // 왜 상단에서 email을 request로 받았는데, 여기서 다시 대입하는지 이유
				
			} else if (item.getFieldName().equals("title")) {
				title = item.getString("utf-8");
				
			} else if (item.getFieldName().equals("content")) {
				content = item.getString("utf-8"); 
			}
			
		} else { // fileload
			if(item.getFieldName().equals("fileUpLoad")){
				filename = processUploadFile(item, fupload);
			}
		}
	}
}

// DB에 저장
PdsDao dao = PdsDao.getInstance();
boolean isSuccess = dao.writePds(new PdsDto(email, title, content, filename));
if (isSuccess) {
	%>
	<script type="text/javascript">
	alert("성공");
	location.href = "pdsList.jsp";
	</script>
	<% 
} else { 
	%>
	<script type="text/javascript">
	alert("실패");
	location.href = "pdsList.jsp";
	</script>
	<%
	}
	%> 
	
</body>
</html>



















