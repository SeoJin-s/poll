<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
	body {
		background-color: #fdf9e7;
		font-family: 'Segoe UI', sans-serif;
	}

	.index-container {
		max-width: 600px;
		margin: 80px auto;
		background-color: #fff9e6;
		padding: 40px 30px;
		border-radius: 12px;
		box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
		text-align: center;
	}

	h1 {
		color: #795548;
		margin-bottom: 30px;
		font-size: 28px;
		font-weight: bold;
	}

	.btn-yellow {
		background-color: #ffc107;
		color: #fff;
		border-radius: 8px;
		padding: 10px 24px;
		font-weight: 500;
		transition: all 0.3s ease;
		box-shadow: 0 4px 6px rgba(255, 193, 7, 0.3);
		margin: 8px;
	}

	.btn-yellow:hover {
		background-color: #e0a800;
		transform: translateY(-2px);
		box-shadow: 0 6px 12px rgba(255, 193, 7, 0.4);
	}
</style>
</head>
<body>

	<!-- nav.jsp include (선택) -->
	<div class="nav-wrapper text-center mt-4">
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>

	<div class="index-container">
		<h1>Index</h1>
		<div class="d-grid gap-3">
			<a href="/poll/pollList.jsp" class="btn btn-yellow">투표(설문)</a>
			<a href="/poll/board/boardList.jsp" class="btn btn-yellow">게시판</a>
			<a href="/poll/imageBoard/imageboardList.jsp" class="btn btn-yellow">이미지게시판</a>
		</div>
	</div>

</body>
</html>