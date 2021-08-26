<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String sql = "insert into tbl_result_202004 values (?, ?, ?, ?, ?, ?)";
	
	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, request.getParameter("p_no"));
	pstmt.setString(2, request.getParameter("t_code"));
	pstmt.setString(3, request.getParameter("t_sdate"));
	pstmt.setString(4, request.getParameter("t_status"));
	pstmt.setString(5, request.getParameter("t_ldate"));
	pstmt.setString(6, request.getParameter("t_result"));
	
	pstmt.executeUpdate();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:forward page="index.jsp"></jsp:forward>
</body>
</html>