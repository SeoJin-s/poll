<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
    int id = 0;
    
    if(request.getParameter("id") != null){
        id = Integer.parseInt(request.getParameter("id"));
    }
    
    QuestionDao questionDao = new QuestionDao();
    ItemDao itemDao = new ItemDao(); 
    
    //메소드 불러오기
    HashMap<String,Object> map = questionDao.selectQuestion(id);

    ArrayList<Item> list = itemDao.selectItemList(id);
    int size = list.size();
    Item[] items = new Item[size];
    
    int idx = 0;
    for(Item i : list){
        items[idx] = i;
        idx++;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설문 수정</title>
    <!-- Bootstrap 5 CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Font (Roboto) for consistent styling -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa; /* 밝은 회색 배경 */
            font-family: 'Roboto', sans-serif;
        }

        h1 {
            text-align: center;
            color: #FF6347; /* 카카오톡과 유사한 톤의 빨간색 */
            font-size: 32px;
            margin-top: 30px;
        }

        h2 {
            text-align: center;
            color: #FF6347;
            font-size: 24px;
            margin-top: 20px;
        }

        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }

        .btn-custom {
            background-color: #FFDD00; /* 카카오톡 노란색 */
            color: white;
            border-radius: 25px;
            font-size: 16px;
            padding: 10px 20px;
            border: none;
            transition: background-color 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #FFBB00; /* hover 시 더 어두운 노란색 */
        }

        .form-container {
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
        }

        .btn-container {
            text-align: center;
            margin-top: 20px;
        }

        .btn-container a button {
            padding: 10px 20px;
            background-color: #FF6347;
            color: white;
            font-size: 16px;
            border-radius: 25px;
            border: none;
            text-decoration: none;
        }

        .btn-container a button:hover {
            background-color: #FF4500;
        }
    </style>
</head>
<body>
    <h1>투표 프로그램</h1>
    <h2>설문 수정</h2>
    <div class="container form-container">
        <form method="post" action="/poll/updatePollAction.jsp">
            <table class="table table-bordered">
                <tr>
                    <td>질문</td>
                    <td colspan="2">
                        <input type="text" name="title" value="<%=map.get("title")%>" class="form-control" required>
                    </td>
                </tr>
                <tr>
                    <td rowspan="8">항목</td>
                    <td>1) <input type="text" name="content[]" value="<%=size > 1 ? items[0].getContent() : ""%>" class="form-control"></td>
                    <td>2) <input type="text" name="content[]" value="<%=size > 2 ? items[1].getContent() : ""%>" class="form-control"></td>
                </tr>
                <tr>
                    <td>3) <input type="text" name="content[]" value="<%=size > 3 ? items[2].getContent(): ""%>" class="form-control"></td>
                    <td>4) <input type="text" name="content[]" value="<%=size > 4 ? items[3].getContent(): ""%>" class="form-control"></td>
                </tr>
                <tr>
                    <td>5) <input type="text" name="content[]" value="<%=size > 5 ? items[4].getContent(): ""%>" class="form-control"></td>
                    <td>6) <input type="text" name="content[]" value="<%=size > 6 ? items[5].getContent(): ""%>" class="form-control"></td>
                </tr>
                <tr>
                    <td>7) <input type="text" name="content[]" value="<%=size > 7 ? items[6].getContent(): ""%>" class="form-control"></td>
                    <td>8) <input type="text" name="content[]" value="<%=size > 8 ? items[7].getContent(): ""%>" class="form-control"></td>
                </tr>
                <tr>
                    <td>시작일</td>
                    <td><input type="date" name="startdate" value="<%=map.get("startdate") %>" class="form-control" disabled></td> 
                </tr>
                <tr>
                    <td>종료일</td>
                    <td><input type="date" name="enddate" value="<%=map.get("enddate") %>" class="form-control" disabled></td>
                </tr>
                <tr>
                    <td>복수투표</td>
                    <td>
                        <input type="radio" name="type" value="1" <%= (Integer)map.get("type") == 1 ? "checked" : "" %> > Yes
                        <input type="radio" name="type" value="0" <%= (Integer)map.get("type") == 0 ? "checked" : "" %> > No
                    </td>
                </tr>
            </table>
            <div class="btn-container">
                <button type="submit" class="btn btn-custom">수정하기</button>
                <button type="reset" class="btn btn-secondary">다시 작성</button>
                <a href="/poll/pollList.jsp"><button type="button" class="btn btn-custom">리스트</button></a>
            </div>
        </form>
    </div>

    <!-- Bootstrap 5 JS & Popper.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>