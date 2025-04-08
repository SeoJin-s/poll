<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.BoardDao" %>
<%@ page import="java.sql.SQLException" %>

<%
    // 요청 파라미터에서 게시글 번호 받아오기
    int num = Integer.parseInt(request.getParameter("num"));

    // DAO 생성 후 삭제 처리하기
    BoardDao boardDao = new BoardDao();

    try {
        // 게시글 삭제 메서드 호출
        boardDao.deleteBoard(num);
        
        // 삭제 성공 -> 목록 페이지로 이동
        response.sendRedirect("/poll/board/boardList.jsp");

    } catch (SQLException | ClassNotFoundException e) {
        // 예외가 발생하면 에러 메시지 출력
%>  
        <script>
            alert('삭제에 실패했습니다: <%= e.getMessage() %>');
            history.back();
        </script>
<%
    }
%>