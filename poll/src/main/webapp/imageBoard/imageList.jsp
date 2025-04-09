<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 5;
	ImageDao imageDao = new ImageDao();
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(rowPerPage);
	
	ArrayList<Image> list = imageDao.selectImageList(p);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 목록</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
	body {
		background-color: #fdf9e7;
		font-family: 'Segoe UI', sans-serif;
		padding-top: 30px;
	}

	.card-img-top {
		height: 250px;
		object-fit: cover;
		border-bottom: 1px solid #eee;
	}

	.card {
		box-shadow: 0 4px 15px rgba(0,0,0,0.05);
		border: 1px solid #fceabb;
		border-radius: 12px;
		transition: transform 0.3s;
	}

	.card:hover {
		transform: scale(1.02);
	}

	.btn-delete {
		background-color: #dc3545;
		color: white;
		border-radius: 8px;
	}

	.btn-delete:hover {
		background-color: #bb2d3b;
		transform: translateY(-2px);
	}

	.memo-text {
		font-weight: 500;
		color: #795548;
	}

	.btn-back {
		margin-top: 40px;
	}
</style>
</head>
<body>

<!-- nav.jsp include -->
<div class="text-center mb-4">
	<jsp:include page="/inc/nav.jsp"></jsp:include>
</div>

<div class="container">
	<h2 class="text-center mb-5">
		<i class="bi bi-images text-warning"></i> 이미지 목록
	</h2>
	
	<div class="row row-cols-1 row-cols-md-3 g-4">
		<% for(Image i : list) { %>
			<div class="col">
				<div class="card h-100">
					<img src="/poll/upload/<%=i.getFilename()%>" class="card-img-top" alt="업로드 이미지">
					<div class="card-body">
						<p class="card-text memo-text">
							<i class="bi bi-stickies-fill text-warning"></i>
							<%=i.getMemo()%>
						</p>
					</div>
					<div class="card-footer text-center">
						<a href="/poll/imageBoard/deleteImage.jsp?num=<%=i.getNum()%>&filename=<%=i.getFilename()%>"
						   class="btn btn-delete btn-sm">
							<i class="bi bi-trash3-fill me-1"></i> 삭제
						</a>
					</div>
				</div>
			</div>
		<% } %>
	</div>

	<!-- 목록으로 돌아가기 버튼 -->
	<div class="text-center btn-back">
		<a href="/poll/imageBoard/imageBoardForm.jsp" class="btn btn-outline-secondary">
			<i class="bi bi-arrow-left-circle me-1"></i> 이미지 등록 페이지로
		</a>
	</div>
</div>

</body>
</html>