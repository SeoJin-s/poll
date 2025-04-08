<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%
	//요청 파라미터에서 게시글 번호 받아오기
	int num = Integer.parseInt(request.getParameter("num"));

	// DAO 생성 후 삭제 처리하기
	BoardDao boardDao = new BoardDao();
	int result = boardDao.deleteBoard(num);	
	// 1 : 성공 , 0 : 실패 등..
	
	if(result >0) {
		// 삭제 성공 ㅡ> 목록 페이지로 이동
		response.sendRedirect("/poll/board/boardList.jsp");
	}else {
		// 삭제 실패 ㅡ> 에러 메세지 출력
	
%>	
	<script>
		alert('삭제에 실패했습니다.');
			history.back();
	</script>

<% 
	}
%>
