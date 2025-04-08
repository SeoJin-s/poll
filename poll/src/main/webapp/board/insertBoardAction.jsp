<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>

<%
	// Controller Layer(request분석, model 호출)
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String pass = request.getParameter("pass");

	 
	
	// 답글이면 부모글의 num 값을 받아온다 아니면 본인pk
	
	int ref = 0;	// 답글이 아니면 0을 입력하고 입력직후에는 본인의 num값 (pk) 과 동일하게
	if(request.getParameter("ref") != null) {
		ref = Integer.parseInt(request.getParameter("ref")); 
	}
	
	// 개별적으로 안하기때문에 Form 입력 타입으로 묶는다 (DTO 사용가능)
	Board board = new Board();
	board.setName(name);
	board.setSubject(subject);
	board.setContent(content);
	board.setRef(ref);
	board.setPass(pass);
	board.setIp(request.getRemoteAddr());   // 다른 API를 이용하여 IP를 구하는 경우가 많다 board.setIp(request.getHeader("Proxy-Client-IP"));
	
	// logging (디버깅....)
	System.out.println(board.toString());		// = System.out.printil(board); 

	BoardDao boardDao = new BoardDao();
	boardDao.insertBoard(board);
	
	// 뷰가 있다면 뷰를 연결( 디스패츠 ex :  include ), 뷰가 없다면 클라이언트에 다른 요청을 강제 ( 리다이렉트 )
	
	response.sendRedirect("/poll/board/boardList.jsp");
%>