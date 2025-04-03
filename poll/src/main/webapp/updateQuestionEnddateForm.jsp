<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.QuestionDao" %>
<%@ page import="dto.Question" %>
<%@ page import="java.sql.*" %>
<%
    String questionIdParam = request.getParameter("id");
    Question question = null;

    if (questionIdParam != null && !questionIdParam.isEmpty()) {
        int questionId = Integer.parseInt(questionIdParam);
        QuestionDao questionDao = new QuestionDao();
        question = questionDao.selectQuestionById(questionId);
        
        if (question == null) {
            out.println("<script>alert('유효한 설문 정보를 찾을 수 없습니다.'); location.href='PollList.jsp';</script>");
            return;
        }
    } else {
        out.println("<script>alert('잘못된 설문 번호입니다.'); location.href='PollList.jsp';</script>");
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>종료일자 수정</title>
</head>
<body>
    <h1>종료일자 수정</h1>
    
    <% if (question != null) { %>
    <form action="updateQuestionEnddateAction.jsp" method="post">
        <input type="hidden" name="id" value="<%= question.getNum() %>" />
        <label for="title">설문 제목:</label>
        <input type="text" name="title" value="<%= question.getTitle() %>" disabled />
        <br>

        <label for="enddate">종료일자:</label>
        <input type="date" name="enddate" value="<%= question.getEnddate() %>" required />
        <br>
        
        <button type="submit">수정</button>
    </form>
    <% } %>

    <a href="pollList.jsp">돌아가기</a>
</body>
</html>