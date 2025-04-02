<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "java.util.Date"%>

<%
	// question 테이블 의 리스트 ㅡ> 페이징 ㅡ> title 링크( startdate <= 오늘날짜 <= enddate ) ㅡ> 투표 프로그램
	// questionDao.selectQuestionList(paging)
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
	}
	
	int rowPerPage = 10;
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(rowPerPage);
	
	QuestionDao questionDao = new QuestionDao();
	ArrayList<Question> list = questionDao.selectQuestionList(p);

    Date now = new Date();
    String inputDateString = "2025-04-02";  // 예시 날짜
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Date inputDate = sdf.parse(inputDateString);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>설문 리스트</h1>
	    <table border="1">

               <% 
            if (list != null && !list.isEmpty()) {
                for (Question q : list) {
                    // null 값 체크 후 날짜 파싱
                    Date startDate = null;
                    Date endDate = null;
                    
                    if (q.getStartdate() != null && !q.getStartdate().isEmpty()) {
                        startDate = sdf.parse(q.getStartdate());
                    }
                    
                    if (q.getEnddate() != null && !q.getEnddate().isEmpty()) {
                        endDate = sdf.parse(q.getEnddate());
                    }

                    // startDate와 endDate가 모두 존재하고, 현재 날짜가 그 사이에 있으면 표시
                    if (startDate != null && endDate != null && now.after(startDate) && now.before(endDate)) {
        %>
                    <tr>
                        <td><%= q.getNum() %></td>
                        <td><%= q.getTitle() %></td>
                        <td><%= q.getStartdate() %></td>
                        <td><%= q.getEnddate() %></td>
                        <td><%= q.getCreatedate() %></td>
                        <td><a href="vote.jsp?id=<%= q.getNum() %>">투표하기</a></td>
                    </tr>
        <% 
                    }
                }
            } else {
        %>
        <tr>
            <td colspan="6">데이터가 없습니다.</td>
        </tr>
        <% 
            }
        %>
    </table>
</body>
</html>