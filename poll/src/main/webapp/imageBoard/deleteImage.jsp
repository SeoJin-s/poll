<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String filename = request.getParameter("filename");
	
	// db 삭제
	ImageDao imageDao = new ImageDao();
	imageDao.deleteImage(num);
	// 파일 삭제
	String path = request.getServletContext().getRealPath("upload"); 
	File file = new File(path,filename); //  new file 경로에 파일이 없으면 빈 파일을 생성할 준비.
	if(file.exists()) {  // 빈 파일이 아니라면..
		file.delete();
	}
	response.sendRedirect("/poll/imageBoard/imageList.jsp");
	
%>