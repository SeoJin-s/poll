<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	// 폼에서 넘어오는 파리미터 받기
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	String type = request.getParameter("type");
	
	// id 파라미터가 존재하는지 확인하고 id값 가져오기
	int id = 0;
	if(request.getParameter("id") != null) {
		id = Integer.parseInt(request.getParameter("id"));
	}
	
	// 디버깅 
	System.out.println("title" + title);
	System.out.println("content" + content);
	System.out.println("stratdate" + startdate);
	System.out.println("enddate" + enddate);
	System.out.println("type" + type);
	
	// db처리 객체 생성
	QuestionDao questionDao = new QuestionDao();
	ItemDao itemDao = new ItemDao();
	
	// 1. 설문 질문 객체 생성 및 수정
	Question question = new Question();
	question.setTitle(title);
	question.setStartdate(startdate);
	question.setEnddate(enddate);
	question.setType(Integer.parseInt(type)); // 복수투표 여부를 정수형으로 변환
	
    // 디버깅: Question 객체 상태 출력
    System.out.println("Question object: ");
    System.out.println("title = " + question.getTitle());
    System.out.println("startdate = " + question.getStartdate());
    System.out.println("enddate = " + question.getEnddate());
    System.out.println("type = " + question.getType());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

</body>
</html>