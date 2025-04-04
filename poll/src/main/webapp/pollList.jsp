<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="java.util.*" %>
<%@ page import="model.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%
    // 현재 페이지를 가져오기 위한 코드 (페이징 처리)
    int currentPage = 1;
    if(request.getParameter("currentPage") != null) {
        try {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        } catch (NumberFormatException e) {
            currentPage = 1;  // Invalid number, default to page 1
        }
    }
    
    // 페이지당 표시할 행 수 설정
    int rowPerPage = 10;
    Paging p = new Paging();
    p.setCurrentPage(currentPage);
    p.setRowPerPage(rowPerPage);
    
    // QuestionDao 객체 생성 후 설문 리스트를 가져오기
    QuestionDao questionDao = new QuestionDao();
    ArrayList<Question> list = questionDao.selectQuestionList(p);  // 예외 처리 없이 호출
    Map<Integer, Boolean> deletableQuestions = questionDao.checkDeletableQuestions();  // 예외 처리 없이 호출
    
    // 현재 날짜를 가져오기
    Date now = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설문 리스트</title>
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEJ5vR1JU7+Y1K2YpT0mMyT8d/5m0I0f3x9+Ol2mWqf3pvr7+0JbOGwYp6bL5" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        /* 기본 레이아웃 스타일 */
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            height: 100vh;
        }

        h1 {
            font-size: 2.5rem;
            color: #3C3C3C;
            margin: 30px 0;
            font-weight: 500;
        }

        /* 테이블 스타일 */
        table {
            width: 90%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 20px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #FFDD00;  /* Kakao Yellow */
            color: #fff;
            font-weight: 600;
        }

        td {
            background-color: #fff;
        }

        tr:nth-child(even) td {
            background-color: #f9f9f9;
        }

        tr:hover td {
            background-color: #f1f1f1;
        }

        /* 버튼 스타일 */
        button {
            padding: 10px 20px;
            font-size: 14px;
            background-color: #FFDD00;  /* Kakao Yellow */
            color: white;
            border: none;
            border-radius: 30px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        button:hover {
            background-color: #FFBB00;  /* Darker yellow for hover */
            transform: scale(1.05);
        }

        button:disabled {
            background-color: #E5E5E5;
            cursor: not-allowed;
        }

        /* 페이징 버튼 스타일 */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            gap: 10px;
        }

        .pagination .page-item .page-link {
            border-radius: 30px;
        }

        .pagination .page-item.active .page-link {
            background-color: #FFDD00;
            border-color: #FFDD00;
        }

        .pagination button {
            padding: 10px 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 30px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        .pagination button:hover {
            background-color: #f1f1f1;
            transform: scale(1.05);
        }

        /* 버튼을 가운데로 배치 */
        .center-button {
            margin-top: 30px;
        }

        .center-button a button {
            padding: 12px 24px;
            background-color: #FFDD00;
            color: white;
            font-size: 18px;
            border-radius: 30px;
            text-decoration: none;
        }

        .center-button a button:hover {
            background-color: #FFBB00;
        }

    </style>
</head>
<body>

    <h1>리스트</h1>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>시작일</th>
                <th>투표현황</th>
                <th>투표자수</th>
                <th>투표</th>
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
                    Date startDate = sdf.parse(q.getStartdate());  // ParseException 처리 안함
                    Date endDate = sdf.parse(q.getEnddate());      // ParseException 처리 안함

                    // 설문 상태 설정
                    String voteStatus = "투표 준비중"; // 기본값
                    if (startDate != null && endDate != null) {
                        if (now.after(startDate) && now.before(endDate)) {
                            voteStatus = "투표중";
                        } else if (now.after(endDate)) {
                            voteStatus = "투표 종료";
                        }
                    }

                    // 투표자수를 가져오는 부분 추가
                    int voteCount = questionDao.getVoteCount(q.getNum());  // QuestionDao에서 투표자 수를 가져옴
                    System.out.println("Vote Count for Question " + q.getNum() + ": " + voteCount);  // 디버깅

                    Boolean isDeletable = deletableQuestions.get(q.getNum());
            %>
            <tr>
                <td><%= q.getNum() %></td>
                <td><%= q.getTitle() %></td>
                <td><%= q.getStartdate() %> ~ <%= q.getEnddate() %></td>
                <td><%= voteStatus %></td>
                <td><%= voteCount %></td>
                <td>
                    <% if ("투표중".equals(voteStatus)) { %> 
                       <a href="updateItemForm.jsp?qunm=<%= q.getNum() %>">
                            <button type="button">투표하기</button>
                        </a>
                    <% } else { %>
                        <button type="button" disabled>투표 불가</button>
                    <% } %>
                </td>
                <td>
                    <% if (isDeletable != null && isDeletable && !"투표 종료".equals(voteStatus)) { %>
                        <a href="deletePoll.jsp?id=<%= q.getNum() %>">
                            <button type="button">삭제</button>
                        </a>
                    <% } else { %>
                        <button type="button" disabled>삭제</button>
                    <% } %>
                </td>
                <td>
                    <% if (!"투표 종료".equals(voteStatus)) { %>
                        <a href="updatePollForm.jsp?id=<%= q.getNum() %>">
                            <button type="button">수정</button>
                        </a>
                    <% } else { %>
                        <button type="button" disabled>수정</button>
                    <% } %>
                </td>
                <td>
                    <a href="updateQuestionEnddateForm.jsp?id=<%= q.getNum() %>">
                        <button type="button">종료일자 수정</button>
                    </a>
                </td>
                <td>
                    <% if (now.after(endDate)) { %>
                        <a href="QuestionOneResult.jsp?qnum=<%= q.getNum() %>">
                            <button type="button">결과 보기</button>
                        </a>
                    <% } else { %>
                        <button type="button" disabled>투표진행중</button>
                    <% } %>
                </td>
            </tr>
            <%  
                }
            } else {
            %>
            <tr>
                <td colspan="10" class="text-center">데이터가 없습니다.</td>
            </tr>
            <% 
            }
            %>
        </tbody>
    </table>


    <!-- 설문 작성하기 버튼을 가운데로 배치 -->
    <div class="center-button">
        <a href="insertPollForm.jsp">
            <button type="button">설문 작성하기</button>
        </a>
    </div>

    <!-- Bootstrap JS, Popper.js, Bootstrap Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gyb3rGzj6et3R70AR0T/R3bpRmA4hbcb2h8XbFk9EghyVxUqdd" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq0p3wZkLfI6d9GVy0Wl1A6/kf5JQz6Vxy2dFvygf2g5vR6hfD" crossorigin="anonymous"></script>

</body>
</html>