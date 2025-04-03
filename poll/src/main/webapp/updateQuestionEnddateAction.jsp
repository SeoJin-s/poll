<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.QuestionDao" %>
<%@ page import="java.sql.*" %>
<%
    String questionIdParam = request.getParameter("id");
    String newEndDate = request.getParameter("enddate");
    boolean result = false;

    if (questionIdParam != null && !questionIdParam.isEmpty() && newEndDate != null && !newEndDate.isEmpty()) {
        int questionId = Integer.parseInt(questionIdParam);

        QuestionDao questionDao = new QuestionDao();
        
        // 종료일자 수정
        try {
            result = questionDao.updateEndDate(questionId, newEndDate); // 종료일자 업데이트
        } catch (SQLException | ClassNotFoundException e) {
            out.println("<script>alert('수정 중 오류가 발생했습니다.'); location.href='pollList.jsp';</script>");
            return;
        }
    }

    if (result) {
        // 수정 성공
        out.println("<script>alert('종료일자가 수정되었습니다.'); location.href='pollList.jsp';</script>");
    } else {
        // 수정 실패
        out.println("<script>alert('수정에 실패했습니다.'); location.href='pollList.jsp';</script>");
    }
%>