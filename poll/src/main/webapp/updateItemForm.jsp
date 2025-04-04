<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="java.util.*" %>
<%@ page import="model.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%
    // 요청 파라미터로 전달된 qunm 값을 가져옴
    String qnumStr = request.getParameter("qunm");
    int qnum = -1;  // qnum 초기값 설정

    // qunm 값이 null이 아니고 빈 값이 아닌 경우 qnum을 정수로 변환
    if (qnumStr != null && !qnumStr.isEmpty()) {
        qnum = Integer.parseInt(qnumStr); // qnum을 정수로 파싱
    }
    
    // qnum 값이 유효하지 않으면 에러 메시지 출력
    if (qnum == -1) {
        out.println("유효한 설문 ID가 없습니다.");
        return; // 더 이상 진행하지 않음
    }

    // 1) QuestionDao를 사용하여 설문 정보를 가져옴
    QuestionDao questionDao = new QuestionDao();
    Question question = questionDao.selectQuestionOne(qnum);

    // 2) 해당 설문에 대한 아이템 리스트를 가져옴
    ItemDao itemDao = new ItemDao();
    ArrayList<Item> itemList = itemDao.selectItemListByQnum(qnum);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>투표하기</title>
    <!-- Bootstrap 5 CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #F0F0F0;  /* 배경 색상 */
            font-family: 'Arial', sans-serif; /* 부드러운 폰트 */
            padding-top: 30px;
        }

        h1, h2 {
            text-align: center;
            color: #00C300;  /* 카카오톡 녹색 */
        }

        h1 {
            font-size: 2.5rem;
        }

        h2 {
            font-size: 1.8rem;
        }

        .card {
            width: 100%;
            max-width: 500px;
            margin: 0 auto;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background-color: #FFDD00;  /* 카카오톡 노란색 */
            color: white;
            font-weight: bold;
            text-align: center;
            border-radius: 15px 15px 0 0;
        }

        .card-body {
            background-color: white;
            padding: 30px;
            border-radius: 0 0 15px 15px;
        }

        .form-check {
            margin-bottom: 10px;
        }

        .btn-custom {
            background-color: #00C300; /* 카카오톡 녹색 */
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 25px;
            padding: 12px 30px;
            font-size: 16px;
            width: 100%;
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
        }

        .btn-container {
            text-align: center;
            margin-top: 20px;
        }

        .form-check-label {
            font-size: 16px;
        }
    </style>
</head>
<body>
    <h1>투표하기</h1>

    <!-- 설문 투표 카드 -->
    <div class="card">
        <div class="card-header">
            <h2>Q: <%= question.getTitle() %></h2>
            <p>(<%= question.getType() == 1 ? "복수투표 가능" : "복수투표 불가" %>)</p>
        </div>
        <div class="card-body">
            <form action="/poll/updateItemAction.jsp" method="post">
                <input type="hidden" name="qnum" value="<%=qnum%>">
                
                <!-- 설문 항목 출력 -->
                <div class="mb-3">
                    <%
                        // 설문 항목 리스트를 반복하며 항목들을 출력
                        for (Item i : itemList) {
                    %>
                        <div class="form-check">
                            <%
                                // 설문이 radio 타입이면 radio 버튼을 출력
                                if (question.getType() == 0) {    // type = radio
                            %>
                                <input class="form-check-input" type="radio" value="<%= i.getInum() %>" name="inum" id="inum_<%= i.getInum() %>">
                                <label class="form-check-label" for="inum_<%= i.getInum() %>">
                                    <%= i.getContent() %>
                                </label>
                            <%         
                                } else {    // type = checkbox일 경우 체크박스를 출력
                            %>
                                <input class="form-check-input" type="checkbox" value="<%= i.getInum() %>" name="inum[]" id="inum_<%= i.getInum() %>">
                                <label class="form-check-label" for="inum_<%= i.getInum() %>">
                                    <%= i.getContent() %>
                                </label>
                            <%         
                                }
                            %>
                        </div>
                    <%
                        }
                    %>
                </div>

                <!-- 제출 버튼 -->
                <div class="btn-container">
                    <button type="submit" class="btn-custom">투표</button>
                    <button type="reset" class="btn-secondary">다시 작성</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap 5 JS & Popper.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>