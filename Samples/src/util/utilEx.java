package util;

import java.util.List;
import calendarEx.CalendarDto;


// 캘린더 관련 유틸리티
public class utilEx {
	// 날짜를 클릭하면, 그날의 일정을 모두 볼 수 있는 calList.jsp로 이동하는 함수
	public static String dayList(int year, int month, int day) {
		String str = "";
		
		// format은 대입 문자를 출력한다.
		// %s => 문자열을 뜻함 | %d => 10진수를 뜻함
		str += String.format("&nbsp;<a href='%s?year=%d&month=%d&day=%d'>", 
						"dayList.jsp", year, month, day);
		
		str += String.format("%2s", two(day+""));
//		str += String.format("%2d", day );
		str += "</a>";
		
		// ex) <a href='calList.jsp?year=2020&month=07&day=31'>_5</a>
		
		return str;
	}
	
	// 일정을 기입하기 위한 pen 이미지를 클릭시, calWrite.jsp로 이동하는 함수
	public static String showPen(int year, int month, int day) {
		String str = "";
		
		String image = "<img src='../img/pen2.png' width='18px' height='18px'";
		str = String.format("<a href='%s?year=%d&month=%d&day=%d'>%s</a>", 
				"../calendar/calWrite.jsp", year, month, day, image);
		
		return str;
	}
	
	// 입력받은 문자의 길이(달, 날)가 2 이하면?
	// 1 -> 01 
	// 0을 추가해주는 메소드
	public static String two(String msg) {
		return msg.trim().length() < 2 ? "0" + msg.trim() : msg.trim();
	}
	
	// 날짜 안에서 설정할 테이블
	public static String makeTable(int year, int month, int day, List<CalendarDto> list) {
		String str = "";
		
		// 2020 7 31 -> 20200731로 형식을 만들어 준다.
		String dates = (year + "") + two(month + "") + two(day + "");
		
		str += "<table width='100%'>";
		str += "<col width='100%'>";
		
		for (CalendarDto dto : list) {
			
			// 넘겨받은 날짜 데이터와 dto에서 불러온 날짜를 비교해서 == 동일하다면
			// 조건에 만족한 것만, 테이블 안에 뿌려준다.
			if(dto.getRdate().substring(0, 8).equals(dates)) {
				str += "<tr bgcolor='#0000ff'>";
				str += "<td style='border:hidden'>";
				
				// 디테일로 넘어갈 때 시퀀스 넘버를 알아야하므로
				str += "<a href='./calDetail.jsp?seq=" + dto.getSeq() + "'>";
				str += "<font style='font-size:8px; color:red'>";
				str += titleOverFlow(dto.getTitle());
				
				// 닫아주기
				str += "</font>";
				str += "</a>";
				str += "</td>";
				str += "</tr>";
			}
		}
		str += "</table>";
		
		return str;
	}
	
	// 제목 길이가 일정 이상 넘어가면 말줄임표 처리 함수
	public static String titleOverFlow(String msg) {
		String str = "";
		if(msg.length() >= 6) {
			str = msg.substring(0, 6); // 0 ~ 5
			str += "...";
			
		} else {
			str = msg.trim();
		}
		return str;
	}
	
}
