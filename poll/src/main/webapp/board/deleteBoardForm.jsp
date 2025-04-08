<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제 확인</title>

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
		max-width: 600px;
		margin: 100px auto;
		background-color: #fff;
		border: 1px solid #fceabb;
		padding: 40px;
		border-radius: 12px;
		box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
		text-align: center;
	}

	h2 {
		color: #dc3545;
		margin-bottom: 20px;
	}

	p {
		color: #555;
		margin-bottom: 30px;
	}

	.btn-yellow {
		background-color: #ffc107;
		color: #fff;
		border-radius: 8px;
		padding: 10px 20px;
		font-weight: 500;
		margin-right: 10px;
		box-shadow: 0 4px 6px rgba(255, 193, 7, 0.3);
		border: none;
	}

	.btn-yellow:hover {
		background-color: #e0a800;
		box-shadow: 0 6px 12px rgba(255, 193, 7, 0.4);
		transform: translateY(-2px);
	}

	.btn-cancel {
		padding: 10px 20px;
		border-radius: 8px;
		border: 1px solid #ccc;
		background-color: #fff;
		color: #555;
		font-weight: 500;
		transition: all 0.3s ease;
	}

	.btn-cancel:hover {
		background-color: #f8f9fa;
		transform: translateY(-2px);
	}
</style>
</head>
<body>

	<div class="container-box">
		<h2>정말 삭제하시겠습니까?</h2>
		<p>삭제한 내용은 복구할 수 없습니다.</p>

		<div class="d-flex justify-content-center">
			<form action="/poll/board/deleteBoardAction.jsp" method="post" style="display:inline;">
				<input type="hidden" name="num" value="<%= num %>">
				<button type="submit" class="btn btn-yellow">삭제</button>
			</form>
			<a href="/poll/board/boardList.jsp" class="btn btn-cancel">취소</a>
		</div>
	</div>

</body>
</html>