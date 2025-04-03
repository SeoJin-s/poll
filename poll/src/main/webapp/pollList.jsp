<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "java.util.Date"%>

<%
    // question 테이블 의 리스트 ㅡ> 페이징 ㅡ> title 링크( startdate <= 오늘날짜 <= enddate ) ㅡ> 투표 프로그램
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
    
    Map<Integer, Boolean> deletableQuestions = questionDao.checkDeletableQuestions();

    Date now = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    

 	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문 리스트</title>
</head>
<body>
    <h1>설문 리스트</h1>

<table border="1">
    <thead>
        <tr>
            <th>번호</th>
            <th>설문 주제</th>
            <th>설문 기간</th>
            <th>복수 투표</th>
            <th>투표 여부</th> <!-- 투표 여부 컬럼 추가 -->
            <th>삭제</th>
            <th>수정</th>
            <th>종료일수정</th>
            <th>결과</th>
        </tr>
    </thead>
    <tbody>
        <% 
        if (list != null && !list.isEmpty()) {
            for (Question q : list) {
                // 날짜 파싱
                Date startDate = null;
                Date endDate = null;

                if (q.getStartdate() != null && !q.getStartdate().isEmpty()) {
                    startDate = sdf.parse(q.getStartdate());
                }

                if (q.getEnddate() != null && !q.getEnddate().isEmpty()) {
                    endDate = sdf.parse(q.getEnddate());
                }

                // 설문 상태에 맞는 조건 설정
                boolean isActive = (startDate != null && endDate != null) && (now.after(startDate) && now.before(endDate));  // 진행 중인 설문
                boolean isBeforeStart = (startDate != null && now.before(startDate));  // 시작 전 설문
                boolean isAfterEnd = (endDate != null && now.after(endDate));  // 종료된 설문

                // 상태 표시
                String voteStatus = "";
                if (isActive) {
                    voteStatus = "투표중";
                } else if (isBeforeStart) {
                    voteStatus = "준비중";
                } else if (isAfterEnd) {
                    voteStatus = "종료";
                }

        %>
            <tr>
                <td><%= q.getNum() %></td>
                <td><%= q.getTitle() %></td>
                <td><%= q.getStartdate() %> ~ <%= q.getEnddate() %></td>
                <td><%= q.getCreatedate() %></td>

                <!-- 투표 여부 -->
                <td><%= voteStatus %></td>

                <!-- 삭제 버튼 및 상태 -->
                <td>
                    <% 
                    Boolean isDeletable = deletableQuestions.get(q.getNum());
                    if (isDeletable != null && isDeletable && !isAfterEnd) {  // 삭제 가능한 경우에만 삭제 버튼을 표시, 종료된 설문은 삭제 불가
                    %>
                        <a href="deletePoll.jsp?id=<%= q.getNum() %>">
                            <button type="button">삭제</button>
                        </a>
                    <% 
                    } else {
                    %>
                        <button type="button" disabled>삭제</button> <!-- 종료된 설문은 삭제 버튼 비활성화 -->
                    <% 
                    }
                    %>
                </td>

                <!-- 수정 버튼 (수정 페이지로 이동하는 링크) -->
				<td>
				    <% if (!isAfterEnd) { %>
				        <a href="updatePollForm.jsp?id=<%= q.getNum() %>">
				            <button type="button">수정</button>
				        </a>
				    <% } else { %>
				        <button type="button" disabled>수정</button>
				    <% } %>
				</td>
                <!-- 종료일자 및 결과 링크 -->
                <td>
				    <a href="updateQuestionEnddateForm.jsp?id=<%= q.getNum() %>">
				        <button type="button">종료일자 수정</button>
				    </a>
				</td>
                <td><a href="result.jsp?id=<%= q.getNum() %>">결과 보기</a></td>
            </tr>
        <%  
            }
        } else {
        %>
            <tr>
                <td colspan="9">데이터가 없습니다.</td>
            </tr>
        <% 
        }
        %>
    </tbody>
</table>

<!-- 설문 작성하기 버튼 -->
<br>
<a href="insertPollForm.jsp">
    <button type="button">설문 작성하기</button>
</a>
</body>
</html>