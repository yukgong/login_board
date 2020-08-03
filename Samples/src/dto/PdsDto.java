package dto;

import java.io.Serializable;

public class PdsDto implements Serializable {
	private int seq;
	private String email;
	private String title;
	private String contents;
	
	private String fileName; // 경로 + 파일명(파일 확장자 추가)
	private int readcount;
	private int downcount;
	
	private String regdate; // 등록(register)

	public PdsDto() {
	}
	
	public PdsDto(int seq, String email, String title, String contents, String fileName, int readcount, int downcount,
			String regdate) {
		super();
		this.seq = seq;
		this.email = email;
		this.title = title;
		this.contents = contents;
		this.fileName = fileName;
		this.readcount = readcount;
		this.downcount = downcount;
		this.regdate = regdate;
	}
	
	// 외부에서 입력 받을 요소
	public PdsDto(String email, String title, String contents, String fileName) {
		super();
		this.email = email;
		this.title = title;
		this.contents = contents;
		this.fileName = fileName;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String id) {
		this.email = email;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public int getDowncount() {
		return downcount;
	}

	public void setDowncount(int downcount) {
		this.downcount = downcount;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "PdsDto [seq=" + seq + ", email=" + email + ", title=" + title + ", contents=" + contents + ", fileName="
				+ fileName + ", readcount=" + readcount + ", downcount=" + downcount + ", regdate=" + regdate + "]";
	}

}
