<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 업로드</title>

<!-- Bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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

	<!-- nav.jsp include (선택사항) -->
	<div class="nav-wrapper">
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>

	<!-- 이미지 업로드 form -->
	<div class="form-container">
		<h1>이미지 업로드</h1>
		<form action="/poll/imageBoard/insertImageAction.jsp" method="post" enctype="multipart/form-data" autocomplete="off" role="form">
			<div class="mb-3">
				<label for="memo" class="form-label">메모</label>
				<input type="text" id="memo" name="memo" class="form-control" placeholder="메모를 입력하세요" required>
			</div>
			<div class="mb-4">
				<label for="imageFile" class="form-label">이미지 파일</label>
				<input type="file" id="imageFile" name="imageFile" class="form-control" accept="image/*" required>
			</div>
			<div class="text-center">
				<button type="submit" class="btn btn-yellow">
					📷 이미지 등록
				</button>
			</div>
		</form>
	</div>

</body>
</html>