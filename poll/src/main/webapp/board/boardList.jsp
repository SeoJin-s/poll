<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
	String searchType = request.getParameter("searchType");
	String searchWord = request.getParameter("searchWord");
	String orderBy = request.getParameter("orderBy");
	String orderDir = request.getParameter("orderDir");
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		if (currentPage < 1) currentPage = 1;
	}
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(10);
    p.setSearchType(searchType);
    p.setSearchWord(searchWord);
    p.setOrderBy(orderBy);
    p.setOrderDir(orderDir);
	
    BoardDao boardDao = new BoardDao();
	ArrayList<Board> list = boardDao.selectBoardList(p);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>목록</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

<style>
	body {
		background-color: #fdf9e7;
		font-family: 'Segoe UI', sans-serif;
	}

	.container-box {
		max-width: 900px;
		margin: 60px auto;
		background-color: #ffffff;
		border-radius: 16px;
		box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
		padding: 40px;
	}

	.board-title {
		text-align: center;
		font-size: 2.5rem;
		font-weight: 700;
		color: #795548;
		padding: 20px;
		margin-bottom: 30px;
		background: linear-gradient(to right, #fff8e1, #fceabb);
		border-radius: 15px;
		box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
		display: inline-block;
		width: 100%;
	}

	.board-title i {
		color: #ff9800;
		margin-right: 10px;
	}

	.table {
		border-radius: 12px;
		overflow: hidden;
	}

	.table thead {
		background-color: #fff8dc;
		color: #555;
	}

	.table-bordered th,
	.table-bordered td {
		border: 1px solid #ffeaa7;
		vertical-align: middle;
	}

	tr {
		transition: background-color 0.3s ease;
	}

	tr:hover {
		background-color: #fff3cd !important;
	}

	.subject-link {
		text-decoration: none;
		color: #333;
	}

	.subject-link:hover {
		text-decoration: underline;
		color: #e0a800;
	}
</style>
</head>
<body>

	<div class="container-box">
		<h1 class="board-title">
			<i class="bi bi-megaphone-fill"></i> 자유게시판
		</h1>

		<!-- nav.jsp include -->
		<div class="text-center mb-4">
			<jsp:include page="/inc/nav.jsp"></jsp:include>
		</div>

		<!-- 게시판 테이블 -->
		<table class="table table-bordered text-center">
			<thead>
				<tr>
					<th style="width: 10%">번호</th>
					<th style="text-align: left;">제목</th>
					<th style="width: 20%">작성자</th>
				</tr>
			</thead>
			<tbody>
			<%
				for(Board b : list) {
					boolean isReply = b.getDepth() > 0;
			%>
				<tr style="background-color: <%= isReply ? "#fffdf2" : "#ffffff" %>;">
					<td><%= b.getNum() %></td>
					<td style="text-align: left;">
						<%
							for(int i=0; i<b.getDepth(); i++) {
						%>
							<span style="padding-left: 20px;"></span>
						<%
							}
							if (isReply) {
						%>
							<span>└ </span>
						<%
							}
						%>
						<a class="subject-link" href="/poll/board/boardOne.jsp?num=<%=b.getNum()%>">
							<%= b.getSubject() %>
						</a>
					</td>
					<td><%= b.getName() %></td>
				</tr>
			<%
				}
			%>
			</tbody>
		</table>
	</div>
	<div class="d-flex justify-content-center mb-4">
    <form method="get" class="d-flex flex-wrap align-items-center gap-2">
        <select name="searchType" class="form-select w-auto">
            <option value="subject">제목</option>
            <option value="name">작성자</option>
        </select>
        <input type="text" name="searchWord" class="form-control w-25" placeholder="검색어"
               value="<%= searchWord != null ? searchWord : "" %>">
        <select name="orderBy" class="form-select w-auto">
            <option value="ref">작성일</option>
            <option value="subject">제목</option>
            <option value="count">조회수</option>
        </select>
        <select name="orderDir" class="form-select w-auto">
            <option value="desc">내림차순</option>
            <option value="asc">오름차순</option>
        </select>
        <button type="submit" class="btn btn-warning">검색</button>
    </form>
    <!-- 전체 목록으로 돌아가기 버튼 -->
    <a href="boardList.jsp" class="btn btn-outline-secondary ms-3">전체 목록</a>
</div>

</body>
</html>
