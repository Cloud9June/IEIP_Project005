<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	StringBuffer sb = new StringBuffer();
	sb.append("update tbl_result_202004 set t_status = '2', t_result=?");
	sb.append(" where p_no="+request.getParameter("p_no"));
	sb.append(" and t_code='"+request.getParameter("t_code")+"'");
	
	String sql = sb.toString();
	
	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, request.getParameter("t_result"));
	pstmt.executeUpdate();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:forward page="testResultRef.jsp"></jsp:forward>
</body>
</html>