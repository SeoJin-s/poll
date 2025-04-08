<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 입력</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
	body {
		background-color: #fdf9e7;
		font-family: 'Segoe UI', sans-serif;
	}

	.nav-wrapper {
		text-align: center;
		margin-top: 30px;
	}

	.form-container {
		max-width: 500px;
		margin: 40px auto;
		background-color: #ffffff;
		border: 1px solid #fceabb;
		padding: 35px 30px;
		border-radius: 12px;
		box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
	}

	h1 {
		font-size: 24px;
		text-align: center;
		color: #795548;
		margin-bottom: 25px;
	}

	.form-label {
		font-weight: 500;
		color: #555;
	}

	.form-control {
		border-radius: 8px;
		border: 1px solid #ddd;
	}

	.form-control:focus {
		box-shadow: none;
		border-color: #ffc107;
	}

.btn-yellow {
	background-color: #ffc107;
	color: #fff;
	border-radius: 8px;
	padding: 8px 16px;
	font-weight: 500;
	transition: all 0.3s ease;
	box-shadow: 0 4px 6px rgba(255, 193, 7, 0.3);
}

.btn-yellow:hover {
	background-color: #e0a800;
	transform: translateY(-2px);
	box-shadow: 0 6px 12px rgba(255, 193, 7, 0.4);
}
</style>
</head>
<body>

	<!-- nav.jsp include - 가운데 정렬 -->
	<div class="nav-wrapper">
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>

	<!-- form 영역 -->
	<div class="form-container">
		<h1>글입력</h1>
		<form method="post" action="/poll/board/insertBoardAction.jsp" autocomplete="off" role="form">
			<div class="mb-3">
				<label for="name" class="form-label">이름</label>
				<input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력하세요" required>
			</div>
			<div class="mb-3">
				<label for="subject" class="form-label">제목</label>
				<input type="text" id="subject" name="subject" class="form-control" placeholder="제목을 입력하세요" required>
			</div>
			<div class="mb-3">
				<label for="content" class="form-label">내용</label>
				<textarea id="content" name="content" rows="5" class="form-control" placeholder="내용을 입력하세요" required></textarea>
			</div>
			<div class="mb-4">
				<label for="pass" class="form-label">비밀번호</label>
				<input type="password" id="pass" name="pass" class="form-control" placeholder="비밀번호를 입력하세요" required>
			</div>
			<div class="text-center">
				<button type="submit" class="btn btn-yellow">
					<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
						<path d="M12.854.146a.5.5 0 0 1 .11.54l-1.528 3.822L11 4 12.854.146zM11.293 1.293a1 1 0 0 1 1.414 0l1 1a1 1 0 0 1 0 1.414l-9 9A1 1 0 0 1 4 13v1h1a1 1 0 0 1 .707.293l9-9z"/>
					</svg>
					글쓰기
				</button>
			</div>
		</form>
	</div>

</body>
</html>