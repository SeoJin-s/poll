<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "model.*" %>
<%@ page import = "dto.*" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	BoardDao boardDao = new BoardDao();
	Board b = boardDao.selectBoardOne(num);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
	body {
		background-color: #fdf9e7;
		font-family: 'Segoe UI', sans-serif;
	}

	.container-box {
		max-width: 700px;
		margin: 60px auto;
		background-color: #fff;
		border: 1px solid #fceabb;
		padding: 40px;
		border-radius: 12px;
		box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
	}

	h1 {
		text-align: center;
		color: #795548;
		margin-bottom: 30px;
	}

	td {
		padding: 10px;
		vertical-align: middle;
	}

	td:first-child {
		font-weight: bold;
		background-color: #fffde7;
		width: 150px;
		color: #555;
	}

	.btn-yellow {
		background-color: #ffc107;
		color: #fff;
		border-radius: 8px;
		padding: 10px 20px;
		margin: 0 10px;
		font-weight: 500;
		transition: all 0.3s ease;
		box-shadow: 0 4px 6px rgba(255, 193, 7, 0.3);
		text-decoration: none;
	}

	.btn-yellow:hover {
		background-color: #e0a800;
		transform: translateY(-2px);
		box-shadow: 0 6px 12px rgba(255, 193, 7, 0.4);
	}

	.button-group {
		text-align: center;
		margin-top: 30px;
	}
</style>
</head>
<body>

	<div class="container-box">
		<h1>게시글 상세</h1>

		<table class="table">
			<tr><td>번호</td><td><%=b.getNum()%></td></tr>
			<tr><td>이름</td><td><%=b.getName()%></td></tr>
			<tr><td>제목</td><td><%=b.getSubject()%></td></tr>
			<tr><td>내용</td><td><%=b.getContent()%></td></tr>
			<tr><td>등록일</td><td><%=b.getRegdate()%></td></tr>
			<tr><td>조회수</td><td><%=b.getCount()%></td></tr>
		</table>

		<!-- pos, ref, depth, ip는 안 보이게 처리하고 아래 form들로 전달 -->
		<div class="button-group">
			<form action="/poll/board/updateBoardForm.jsp" method="get" style="display: inline;">
				<input type="hidden" name="num" value="<%=b.getNum()%>">
				<input type="hidden" name="ref" value="<%=b.getRef()%>">
				<input type="hidden" name="pos" value="<%=b.getPos()%>">
				<input type="hidden" name="depth" value="<%=b.getDepth()%>">
				<input type="hidden" name="ip" value="<%=b.getIp()%>">
				<button type="submit" class="btn btn-yellow">수정</button>
			</form>

			<form action="/poll/board/deleteBoardForm.jsp" method="get" style="display: inline;">
				<input type="hidden" name="num" value="<%=b.getNum()%>">
				<input type="hidden" name="ref" value="<%=b.getRef()%>">
				<input type="hidden" name="pos" value="<%=b.getPos()%>">
				<input type="hidden" name="depth" value="<%=b.getDepth()%>">
				<input type="hidden" name="ip" value="<%=b.getIp()%>">
				<button type="submit" class="btn btn-yellow">삭제</button>
			</form>

			<form action="/poll/board/insertBoardReplayForm.jsp" method="get" style="display: inline;">
				<input type="hidden" name="ref" value="<%=b.getRef()%>">
				<input type="hidden" name="pos" value="<%=b.getPos()%>">
				<input type="hidden" name="depth" value="<%=b.getDepth()%>">
				<input type="hidden" name="ip" value="<%=b.getIp()%>">
				<button type="submit" class="btn btn-yellow">답글</button>
			</form>
				<!-- ✅ 목록으로 버튼 추가 -->
			<form action="/poll/board/boardList.jsp" method="get" style="display: inline;">
				<button type="submit" class="btn btn-yellow">목록</button>
	</form>
		</div>
	</div>

</body>
</body>
</html>