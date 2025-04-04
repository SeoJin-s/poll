<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<% 
    // 설문 항목 번호 받기
    String qnumStr = request.getParameter("qnum");
    int qnum = Integer.parseInt(qnumStr);  // qnum 값 설정

    String[] inumArr = request.getParameterValues("inum");
    
    // inumArr 값이 null이거나 비어있는지 확인
    if (inumArr == null || inumArr.length == 0) {
        out.println("선택된 항목이 없습니다.");
        return;
    }

    // ItemDao 객체 생성
    ItemDao itemDao = new ItemDao();

    // 각 항목에 대해 카운트를 증가시키는 메소드 호출
    for (String inumStr : inumArr) {
        int inum = Integer.parseInt(inumStr);
        int count = 1; // 카운트를 증가시키기 위한 단위 값 (일반적으로 1)

        // 두 번째 인자도 필요하므로 count 값을 함께 전달
        itemDao.updateItemCountPlus(qnum, inum);  // 첫 번째는 항목 번호, 두 번째는 증가할 수
    }

    // 투표 후 설문 목록 페이지로 리다이렉트
    response.sendRedirect("/poll/pollList.jsp");
%>