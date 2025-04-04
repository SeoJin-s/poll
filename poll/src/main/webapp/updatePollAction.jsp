<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
    // 폼에서 넘어오는 파라미터를 받기
    String title = request.getParameter("title"); // 설문 제목
    String content = request.getParameter("content"); // 설문 내용
    String startdate = request.getParameter("startdate"); // 설문 시작일
    String enddate = request.getParameter("enddate"); // 설문 종료일
    String type = request.getParameter("type"); // 복수투표 여부

    // num 파라미터가 존재하는지 확인하고 num값 가져오기 (수정할 설문인지, 새로 추가할 설문인지 구분)
    int num = 0;
    if (request.getParameter("num") != null) {
        num = Integer.parseInt(request.getParameter("num")); // num 값이 있으면 수정할 설문 ID
    }
    // 
    if (startdate == null || startdate.isEmpty()) {
    	startdate = "2025-01-01";
    }
    
    if (enddate == null || enddate.isEmpty()) {
    	enddate = "2999-12-31";
    }

    // DB 처리 객체 생성
    QuestionDao questionDao = new QuestionDao(); 
    ItemDao itemDao = new ItemDao(); 

    // 설문 질문 객체 생성 및 수정
    Question question = new Question();
    question.setTitle(title); // 설문 제목 설정
    question.setStartdate(startdate); // 시작일 설정
    question.setEnddate(enddate); // 종료일 설정
    question.setType(Integer.parseInt(type)); // 복수투표 여부를 정수형으로 변환하여 설정

    // 결과 처리 변수 (수정/추가 여부에 따라 결정)
    boolean result = false;

    // num이 0보다 크면 수정, 0이면 새로 추가
    if (num > 0) {
        // num이 존재하면 수정 처리
        question.setNum(num);  // 수정할 설문 ID 설정
        result = questionDao.updateQuestion(question); // updateQuestion 메소드 호출
    } else {
        // num이 없으면 새로운 설문 추가
        num = questionDao.insertQuestion(question);  // insertQuestion 메소드 호출하여 새로운 설문 추가 후 생성된 ID 반환
        question.setNum(num);  // 반환된 생성된 ID를 question 객체에 설정
        result = true;  // 추가된 경우 성공으로 설정
    }

 // 설문 항목 처리
    String[] itemContents = request.getParameterValues("items"); // 항목 내용 파라미터 배열 받기

    if (itemContents != null && itemContents.length > 0) {
        for (String itemContent : itemContents) {
            // 설문 항목 객체 생성
            Item item = new Item();
            
            // 이미 정의된 setQnum 메서드를 사용하여 qnum 설정
            item.setQnum(question.getNum());  // question.getNum() 값을 Item에 설정
            
            item.setContent(itemContent);  // 항목 내용 설정
            
            // 항목 DB에 저장
            itemDao.insertItem(item); // ItemDao에서 insertItem 메소드 호출하여 항목 저장
        }
    }

    // 결과 처리: 설문이 성공적으로 저장되었는지 확인 후 메시지 출력
    if (result) {
        // 성공적으로 저장된 경우
        out.println("<script>alert('설문이 성공적으로 저장되었습니다.'); location.href='pollList.jsp';</script>");
    } else {
        // 저장 실패한 경우
        out.println("<script>alert('설문 저장에 실패했습니다.'); location.href='pollList.jsp';</script>");
    }
%>