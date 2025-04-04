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
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #F5F5F5; /* 배경 색상 */
            font-family: 'Arial', sans-serif;
            padding-top: 30px;
        }

        .container {
            max-width: 600px;
        }

        .card {
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background-color: #FFDD00; /* 카카오톡 노란색 */
            color: white;
            font-weight: bold;
            text-align: center;
            border-radius: 10px 10px 0 0;
        }

        .card-body {
            background-color: white;
            padding: 30px;
            border-radius: 0 0 10px 10px;
        }

        .btn-custom {
            background-color: #00C300; /* 카카오톡 녹색 */
            color: white;
            font-weight: bold;
            width: 100%;
            padding: 12px 0;
            border-radius: 25px;
            border: none;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #009900; /* 카카오톡 녹색 어두운 색 */
        }

        .btn-secondary {
            background-color: #D3D3D3;
            color: black;
            width: 100%;
            border-radius: 25px;
            padding: 12px 0;
        }

        a {
            text-decoration: none;
            font-size: 14px;
            color: #FFDD00; /* 카카오톡 노란색 */
        }

        a:hover {
            color: #00C300; /* 카카오톡 녹색 */
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <h4>종료일자 수정</h4>
            </div>
            <div class="card-body">
                <% if (question != null) { %>
                    <form action="updateQuestionEnddateAction.jsp" method="post">
                        <input type="hidden" name="id" value="<%= question.getNum() %>" />

                        <div class="mb-3">
                            <label for="title" class="form-label">설문 제목</label>
                            <input type="text" class="form-control" name="title" value="<%= question.getTitle() %>" disabled />
                        </div>

                        <div class="mb-3">
                            <label for="enddate" class="form-label">종료일자</label>
                            <input type="date" class="form-control" name="enddate" value="<%= question.getEnddate() %>" required />
                        </div>
                        
                        <button type="submit" class="btn btn-custom">수정</button>
                    </form>
                <% } %>
            </div>
        </div>

        <div class="text-center mt-3">
            <a href="pollList.jsp">돌아가기</a>
        </div>
    </div>

    <!-- Bootstrap 5 JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>