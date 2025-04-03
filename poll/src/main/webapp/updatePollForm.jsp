<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
	int id = 0;
	
	if(request.getParameter("id") != null){
		id = Integer.parseInt(request.getParameter("id"));
	}
	
	QuestionDao questionDao = new QuestionDao();
	ItemDao itemDao = new ItemDao(); 
	
	//메소드 불러오기
	HashMap<String,Object> map = questionDao.selectQuestion(id);

	ArrayList<Item> list = itemDao.selectItemList(id);
	int size = list.size();
	Item[] items = new Item[size];
	
	int idx = 0;
	for(Item i : list){
		items[idx] = i;
		idx++;
	}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문 수정</title>
</head>
<body>
	<h1>투표 프로그램</h1>
	<hr>
	<h2>설문 수정</h2>

	<!-- 수정할 설문을 업데이트하는 페이지로 폼 액션을 설정 -->
	<form method="post" action="/poll/updatePollAction.jsp">
		<table border="1">
			<tr>
				<td>질문</td>
				<td colspan="2">
					<!-- Title input field, will show the current title of the poll -->
					<input type="text" name="title" value="<%=map.get("title")%>" required>
				</td>
			</tr>
			
			<tr>
			    <td rowspan="8">항목</td>
			    <td>1) <input type="text" name="content[]" value="<%=size > 1 ? items[0].getContent() : ""%>"></td>
			    <td>2) <input type="text" name="content[]" value="<%=size > 2 ? items[1].getContent() : ""%>"></td>
			</tr>
			                
			<tr>
			    <td>3) <input type="text" name="content[]" value="<%=size > 3 ? items[2].getContent(): ""%>"></td>
			    <td>4) <input type="text" name="content[]" value="<%=size > 4 ? items[3].getContent(): ""%>"></td>
			</tr>
			<tr>
			    <td>5) <input type="text" name="content[]" value="<%=size > 5 ? items[4].getContent(): ""%>"></td>
			    <td>6) <input type="text" name="content[]" value="<%=size > 6 ? items[5].getContent(): ""%>"></td>
			</tr>
			<tr>
			    <td>7) <input type="text" name="content[]" value="<%=size > 7 ? items[6].getContent(): ""%>"></td>
			    <td>8) <input type="text" name="content[]" value="<%=size > 8 ? items[7].getContent(): ""%>"></td>
			</tr>
			
			<tr>
			    <td>시작일</td>
			    <td><input type="date" name="startdate" value="<%=map.get("startdate") %>" disabled></td> 
			</tr>
						
			<tr>
				<td>종료일</td>
				<td><input type="date" name="enddate" value="<%=map.get("enddate") %>"  disabled></td>
			</tr>
			
			<tr>
				<td>복수투표</td>
				<td>
				    <input type="radio" name="type" value="1" <%
				    if((Integer)map.get("type") == 1){
				   	 	%>checked<%
				    } %>> yes
				    <input type="radio" name="type" value="0" <%
				    if((Integer)map.get("type") == 0){
				   	 	%>checked<%
				    } %>>no
				</td>
			</tr>
		</table>
		
		<button type="submit">수정하기</button>
		<button type="reset">다시 작성</button>
		<a href="/poll/pollList.jsp">리스트</a>
	</form>
</body>
</html>