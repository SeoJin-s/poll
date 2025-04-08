<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*, dto.*" %>

<%
	// [디버깅] num 파라미터가 제대로 넘어오는지 확인
	// System.out.println("updateBoardForm.jsp - num: " + request.getParameter("num"));

	// 게시글 번호 가져오기
	int num = Integer.parseInt(request.getParameter("num"));

	// [디버깅] DAO 생성 및 데이터 조회
	BoardDao boardDao = new BoardDao();
	Board b = boardDao.selectBoardOne(num);

	// 데이터 디버깅 
	// System.out.println("게시글 제목: " + b.getSubject());
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 수정</title>

	<!-- Bootstrap CSS (디자인 프레임워크) -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

	<!-- Bootstrap JS (모달, 드롭다운 등의 동작 지원) -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- 사용자 정의 CSS -->
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
	</style>	
</head>
<body>

	<!-- 메인 폼 영역 -->
	<div class="container-box">
		<h1>게시글 수정</h1>

		<!-- 게시글 수정 폼 -->
		<form action="/poll/board/updateBoardAction.jsp" method="post">
			
			<!-- 게시글 번호 (숨겨진 값으로 전달) -->
			<input type="hidden" name="num" value="<%=b.getNum()%>">

			<!-- 이름 입력 필드 -->
			<div class="mb-3">
				<label class="form-label">이름</label>
				<input type="text" name="name" class="form-control" value="<%=b.getName()%>" required>
			</div>

			<!-- 제목 입력 필드 -->
			<div class="mb-3">
				<label class="form-label">제목</label>
				<input type="text" name="subject" class="form-control" value="<%=b.getSubject()%>" required>
			</div>

			<!-- 내용 입력 필드 -->
			<div class="mb-3">
				<label class="form-label">내용</label>
				<textarea name="content" class="form-control" rows="6" required><%=b.getContent()%></textarea>
			</div>

			<!-- 버튼 영역 -->
			<div class="text-center">
				<!-- 수정 제출 버튼 -->
				<button type="submit" class="btn btn-yellow">수정 완료</button>

				<!-- 목록으로 돌아가기 버튼 -->
				<a href="/poll/board/boardList.jsp" class="btn btn-outline-secondary">취소</a>
			</div>
		</form>
	</div>

</body>
</html>