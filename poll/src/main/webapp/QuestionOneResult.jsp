<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="model.*" %>
<%@ page import ="java.util.*" %>
<%@ page import = "dto.*" %>
<%
    // Controller: request 분석 + model 호출
    String qnumStr = request.getParameter("qnum");
    int qnum = -1;
    
    if (qnumStr != null && !qnumStr.isEmpty()) {
        qnum = Integer.parseInt(qnumStr);  // 정상적으로 qnum을 정수로 변환
    } else {
        out.println("qnum 파라미터가 전달되지 않았습니다.");
        return;  // qnum 파라미터가 없으면 더 이상 진행하지 않음
    }

    // 1) QuestionDao를 사용하여 설문 정보를 가져옴
    QuestionDao questionDao = new QuestionDao();
    Question question = questionDao.selectQuestionOne(qnum);
    
    // 2) 해당 설문에 대한 아이템 리스트를 가져옴
    ItemDao itemDao = new ItemDao();
    ArrayList<Item> itemList = itemDao.selectItemListByQnum(qnum);
    
    // 3) 총 투표수 
    int totalcount = itemDao.selectItemCountByQnum(qnum);
%>

<!-- view -->
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>설문 투표 결과</title>
<!-- 부트스트랩 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap" rel="stylesheet">
<style>
    body {
        background-color: #F8F8F8; /* 밝은 회색 배경 */
        font-family: 'Fredoka One', sans-serif;
    }

    .container {
        margin-top: 30px;
        width: 80%; /* 컨테이너 크기 축소 */
    }

    .header {
        font-size: 24px;
        color: #FFDD00; /* 카카오톡 노란색 */
        text-align: center;
        margin-bottom: 20px;
    }

    .pie-chart-container {
        position: relative;
        width: 60px;
        height: 60px;
        border-radius: 50%;
        margin: 10px;
        display: inline-block;
        background-color: #fff;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        border: 4px solid #f3f3f3;
    }

    /* 원형 차트 스타일 */
    .pie-chart {
        position: absolute;
        width: 100%;
        height: 100%;
        border-radius: 50%;
    }

    .pie-label {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        font-weight: bold;
        color: #333;
        font-size: 12px;
    }

    .table th, .table td {
        text-align: center;
        vertical-align: middle;
    }

    .table {
        background-color: #fff;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    /* 카카오톡 스타일 애니메이션 */
    .btn-back {
        display: block;
        margin: 20px auto;
        background-color: #00C300; /* 카카오톡 초록색 */
        color: white;
        padding: 10px 20px;
        font-size: 16px;
        border: none;
        border-radius: 25px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .btn-back:hover {
        background-color: #009900; /* hover 시 어두운 초록색 */
    }
</style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1><%= qnum %>번 설문 투표결과</h1>
    </div>

    <table class="table table-bordered">
        <tr>
            <td colspan="4">
                Q : <%= question.getTitle() %>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                총 투표수: <%= totalcount %>
            </td>
        </tr>
        <tr>
            <td>번호</td><td>내용</td><td>차트</td><td>투표수</td>
        </tr>
        <%
            String[] colors = {"#00C300", "#FFDD00", "#FF6347", "#8A2BE2", "#FF1493"};  // 색상 배열
            double totalPercentage = 0;

            for (Item i : itemList) {
                double percentage = (double) i.getCount() / totalcount * 100;
                totalPercentage += percentage;
        %>
            <tr>
                <td><%= i.getInum() %></td>
                <td><%= i.getContent() %></td>
                <td>
                    <!-- 원형 차트 -->
                    <div class="pie-chart-container">
                        <div class="pie-chart" style="background: conic-gradient(
                            <% 
                                double accumulatedPercentage = 0;
                                for (int j = 0; j < itemList.size(); j++) {
                                    Item item = itemList.get(j);
                                    double itemPercentage = (double) item.getCount() / totalcount * 100;
                                    accumulatedPercentage += itemPercentage;
                                    out.print(colors[j % colors.length] + " " + accumulatedPercentage + "%, ");
                                }
                            %>
                        );"></div>
                        <div class="pie-label"><%= i.getCount() %>표<br><%= (int)percentage %>%</div>
                    </div>
                </td>
                <td><%= i.getCount() %></td>
            </tr>
        <%
            }
        %>
    </table>

    <!-- 이전 페이지로 돌아가기 버튼 -->
    <a href="pollList.jsp">
        <button class="btn-back">확인</button>
    </a>
</div>

<!-- 부트스트랩 JS (옵션, 모달이나 다른 기능에 필요할 수 있음) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>