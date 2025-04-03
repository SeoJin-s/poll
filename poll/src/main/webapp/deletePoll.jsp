<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.IOException" %>

<%
    // request에서 파라미터로 받은 'id' 값 확인
    String questionId = request.getParameter("id");

    if (questionId == null || questionId.isEmpty()) {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }

    try {
        int qnum = Integer.parseInt(questionId);  // id 값을 정수로 변환
        QuestionDao questionDao = new QuestionDao();

        // 먼저 item 테이블에서 해당 qnum에 대한 항목을 삭제
        // 투표자가 없을 경우에만 삭제
        boolean isVoteEmpty = questionDao.isVoteEmpty(qnum);

        if (isVoteEmpty) {
            // 투표자가 없으면 삭제 진행
            questionDao.deleteItemByQnum(qnum);
            boolean isDeleted = questionDao.deleteQuestion(qnum);  // deleteQuestion 호출
            
            if (isDeleted) {
                // 삭제 성공 시
                String message = "설문이 성공적으로 삭제되었습니다.";
%>
                <script type="text/javascript">
                    alert("<%= message %>");
                    setTimeout(function() {
                        window.location.href = "pollList.jsp";  // 2초 후에 pollList.jsp로 리디렉션
                    }, 2000);  // 2000ms = 2초
                </script>
<%
            } else {
                // 삭제 실패 시
                out.println("<script>alert('설문 삭제에 실패했습니다.'); history.back();</script>");
            }
        } else {
            // 투표자가 있을 경우
            out.println("<script>alert('투표가 진행 중인 설문은 삭제할 수 없습니다.'); history.back();</script>");
        }
    } catch (NumberFormatException e) {
        // id 파라미터가 정수로 변환되지 않은 경우
        out.println("<script>alert('잘못된 설문 ID입니다.'); history.back();</script>");
    } catch (SQLException e) {
        // SQL 예외 처리
        out.println("<script>alert('데이터베이스 오류 발생: " + e.getMessage() + "'); history.back();</script>");
    } catch (Exception e) {
        // 다른 예외 처리
        out.println("<script>alert('알 수 없는 오류 발생: " + e.getMessage() + "'); history.back();</script>");
    }
%>