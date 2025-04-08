<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	// 디버깅 
	System.out.println("updateBoardAction.jsp 실행?");

	// 파라미터 받기
	int num = Integer.parseInt(request.getParameter("num"));
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");

	System.out.println("num=" + num);
	System.out.println("name=" + name);
	System.out.println("subject=" + subject);
	System.out.println("content=" + content);

	// DTO 생성 및 값 세팅
	Board b = new Board();
	b.setNum(num);
	b.setName(name);
	b.setSubject(subject);
	b.setContent(content);

	BoardDao boardDao = new BoardDao();
	int result = boardDao.updateBoard(b);

	if(result > 0) {
		// 수정 성공 → 상세 페이지로 이동
		response.sendRedirect("/poll/board/boardOne.jsp?num=" + num);
	} else {
%>
	<script>
		alert('수정에 실패했습니다.');
		history.back();
	</script>
<%
	}
%>