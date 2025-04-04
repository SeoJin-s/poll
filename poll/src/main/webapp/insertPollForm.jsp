<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설문 작성</title>
    <!-- Bootstrap 5 CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #F2F2F2; /* 카카오톡 밝은 배경 */
            font-family: 'Arial', sans-serif;
        }

        h1, h2 {
            color: #F9E800; /* 카카오톡 노란색 */
            text-align: center;
        }

        h1 {
            font-size: 32px;
            margin-top: 30px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        h2 {
            font-size: 24px;
            margin-top: 20px;
        }

        .form-container {
            padding: 30px;
            background-color: white;
            margin: 20px auto;
            width: 80%;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            margin: 20px 0;
        }

        table td {
            padding: 12px;
            text-align: left;
        }

        .table input[type="text"], .table input[type="date"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #F9E800;
            border-radius: 5px;
            font-size: 14px;
        }

        .radio-group input[type="radio"] {
            margin-left: 10px;
        }

        .btn-custom {
            background-color: #00C300; /* 카카오톡 초록색 */
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 25px;
            padding: 12px 30px;
            font-size: 16px;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #009900; /* hover 시 어두운 초록색 */
        }

        .btn-container {
            text-align: center;
            margin-top: 20px;
        }

        .btn-container a button {
            background-color: #F9E800; /* 카카오톡 노란색 */
            color: black;
            border-radius: 25px;
            padding: 12px 30px;
            font-size: 16px;
            border: none;
            transition: background-color 0.3s ease;
        }

        .btn-container a button:hover {
            background-color: #F7D600; /* hover 시 어두운 노란색 */
        }

        .form-container .form-control {
            border-radius: 5px;
            border: 1px solid #F9E800;
        }

        .form-container .form-check-label {
            font-size: 14px;
        }

        /* 모바일 대응 */
        @media (max-width: 768px) {
            .form-container {
                width: 95%;
            }
        }
    </style>
</head>
<body>
    <h1>투표 프로그램</h1>
    <h2>설문 작성</h2>

    <div class="container form-container">
        <form method="post" action="/poll/insertPollAction.jsp">
            <table class="table table-bordered">
                <tr>
                    <td>질문</td>
                    <td colspan="2"><input type="text" name="title" class="form-control" required></td>
                </tr>
                <tr>
                    <td rowspan="8">항목</td>
                    <td>1) <input type="text" name="content" class="form-control"></td>
                    <td>2) <input type="text" name="content" class="form-control"></td>
                </tr>
                <tr>
                    <td>3) <input type="text" name="content" class="form-control"></td>
                    <td>4) <input type="text" name="content" class="form-control"></td>
                </tr>
                <tr>
                    <td>5) <input type="text" name="content" class="form-control"></td>
                    <td>6) <input type="text" name="content" class="form-control"></td>
                </tr>
                <tr>
                    <td>7) <input type="text" name="content" class="form-control"></td>
                    <td>8) <input type="text" name="content" class="form-control"></td>
                </tr>
                <tr>
                    <td>시작일</td>
                    <td><input type="date" name="startdate" class="form-control"></td>
                </tr>
                <tr>
                    <td>종료일</td>
                    <td><input type="date" name="enddate" class="form-control"></td>
                </tr>
                <tr>
                    <td>복수투표</td>
                    <td class="radio-group">
                        <input type="radio" name="type" value="1"> Yes
                        <input type="radio" name="type" value="0"> No
                    </td>
                </tr>
            </table>

            <div class="btn-container">
                <button type="submit" class="btn-custom">작성하기</button>
                <button type="reset" class="btn btn-secondary">다시 작성</button>
                <a href="/poll/pollList.jsp"><button type="button" class="btn-custom">리스트</button></a>
            </div>
        </form>
    </div>

    <!-- Bootstrap 5 JS & Popper.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>