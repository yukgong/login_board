package calendarEx;

import java.io.Serializable;

/*
 CREATE TABLE CALENDAR(
	SEQ NUMBER(8) PRIMARY KEY, -- 조인을 할 경우에는 기본키로 잡아주고, 아닌 경우에는 빼도됨
	EMAIL VARCHAR2(50) NOT NULL,
	TITLE VARCHAR2(200) NOT NULL,
	CONTENT VARCHAR2(4000) NOT NULL,
	RDATE VARCHAR2(12) NOT NULL,
	WDATE DATE NOT NULL
); 
 */

public class CalendarDto implements Serializable {
	private int seq; // 시퀀스 넘버
	private String email; // 계정
	private String title; // 일정관리 주제
	private String content; // 일정 내용
	private String rdate; // 일정이 있는 날
	private String wdate; // 일정 작성일 -> 오늘 날짜
	
	public CalendarDto() {
	}
	
	// 외부에서 입력 받을 요소만으로 생성자 만들기
	public CalendarDto(String email, String title, String content, String rdate) {
		super();
		this.email = email;
		this.title = title;
		this.content = content;
		this.rdate = rdate;
	}

	public CalendarDto(int seq, String email, String title, String content, String rdate, String wdate) {
		super();
		this.seq = seq;
		this.email = email;
		this.title = title;
		this.content = content;
		this.rdate = rdate;
		this.wdate = wdate;
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


	public void setEmail(String email) {
		this.email = email;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getRdate() {
		return rdate;
	}


	public void setRdate(String rdate) {
		this.rdate = rdate;
	}


	public String getWdate() {
		return wdate;
	}


	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	@Override
	public String toString() {
		return "CalendarDto [seq=" + seq + ", email=" + email + ", title=" + title + ", content=" + content + ", rdate="
				+ rdate + ", wdate=" + wdate + "]";
	}
	
}
