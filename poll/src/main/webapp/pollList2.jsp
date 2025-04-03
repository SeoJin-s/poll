<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "java.util.Date"%>

<%
	// question 테이블 리스트 -> 페이징 -> title 링크(startdate <= 오늘날짜 <= enddate) -> 투표프로그램
	// QuestionDao.selectQuestionList(Paging)
	QuestionDao questionDao = new QuestionDao();
	
	ArrayList<HashMap<String, Object>> list
		= questionDao.selectQuestionList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pollList</title>
</head>
<body>
	<h1>설문리스트</h1>
	<table border="1">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>시작일</td>
			<td>종료일</td>
			<td>현재투표현황</td>
			<td>투표</td>
			<td>삭제</td>
			<td>수정</td>
			<td>종료일수정</td>
			<td>결과</td>
		</tr>
		<%
			Calendar today = Calendar.getInstance();
			// yyyy-mm-dd
			int year = today.get(Calendar.YEAR);
			int mon = today.get(Calendar.MONTH)+1;
			int date = today.get(Calendar.DATE);
			
			String strToday = year+"-";
			if(mon<10) {
				strToday = strToday + "0" + mon + "-";
			} else {
				strToday = strToday + mon + "-";
			}
			if(date<10) {
				strToday = strToday + "0" + date;
			} else {
				strToday = strToday + date;
			}
			
			System.out.println(strToday);
			
			for(HashMap<String, Object> m : list) {
				String startDate = (String)m.get("startdate");
				String endDate = (String)m.get("enddate");
		%>
				<tr>
				<td><%=m.get("num")%></td>
				<td><%=m.get("title")%></td>
				<td><%=m.get("startdate")%></td>
				<td><%=m.get("enddate")%></td>
				<td><%=m.get("cnt")%>명</td>
				<td>
					<%
						// 오늘 날짜 빼기 - 시작날짜 : 결과가 + 양수 && 끝 날짜에서 - 오늘 날짜 : 양수 
						if(strToday.compareTo(startdate) < 0) {
					%>
							투표전
					<%		
						}else if(strToday.compareTo(enddate) >0){
					%>
							투표 종료
					<% 		
						} else {
					%>
							<a hreh="">투표</a>
					<% 		
						}
					%>
				</td>
				<td>
					<%
						if((Integer)(m.get("cnt")) > 0) {
					%>
							삭제불가
					<%		
						} else {
					%>
							<a href="">삭제</a>
					<%		
						}
					%>
				</td>
				<td>수정</td>
				<td>종료일수정</td>
				<td>결과</td>
		</tr>
		<%		
			}
		%>
	</table>
</body>
</html>
