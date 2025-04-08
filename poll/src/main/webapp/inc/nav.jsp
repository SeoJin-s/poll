<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
	String path = request.getRequestURI();
%>

<!-- Bootstrap Icons CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<style>
	.nav-link {
		transition: background-color 0.3s, color 0.3s;
		border-radius: 8px;
		padding: 8px 12px;
	}

	.nav-link:hover {
		background-color: #fff8dc;
		color: #d39e00 !important;
	}

	.navbar-brand:hover {
		color: #d39e00 !important;
	}

	.btn-success {
		transition: background-color 0.3s, box-shadow 0.3s;
	}

	.btn-success:hover {
		background-color: #218838;
		box-shadow: 0 0 10px rgba(33, 136, 56, 0.3);
	}
</style>

<nav class="navbar navbar-expand-lg navbar-light bg-light px-4 shadow-sm">
  <a class="navbar-brand d-flex align-items-center text-warning fw-bold fs-5" href="/poll/index.jsp">
    <i class="bi bi-house-fill me-2"></i> HOME
  </a>

  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse justify-content-between" id="navbarNav">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link d-flex align-items-center text-warning fs-5 
           <%= path.contains("pollList.jsp") ? "active fw-bold" : "" %>" 
           href="/poll/pollList.jsp">
          <i class="bi bi-card-list me-2"></i> LIST
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link d-flex align-items-center text-warning fs-5 
           <%= path.contains("insertPollForm.jsp") ? "active fw-bold" : "" %>" 
           href="/poll/insertPollForm.jsp">
          <i class="bi bi-ui-checks me-2"></i> 설문추가
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link d-flex align-items-center text-warning fs-5 
           <%= path.contains("boardList.jsp") ? "active fw-bold" : "" %>" 
           href="/poll/board/boardList.jsp">
          <i class="bi bi-chat-dots-fill me-2"></i> 게시판
        </a>
      </li>
    </ul>

    <!-- 오른쪽 '글쓰기' 버튼 (초록색) -->
    <a href="/poll/board/insertBoardForm.jsp" class="btn btn-success d-flex align-items-center fs-5">
      <i class="bi bi-pencil-fill me-2"></i> 글쓰기
    </a>
  </div>
</nav>