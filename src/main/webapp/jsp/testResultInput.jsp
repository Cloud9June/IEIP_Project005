<%@page import="java.io.PrintWriter"%>
<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	PrintWriter writer = response.getWriter();

	try {
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
		
		response.sendRedirect("index.jsp");
	
	} catch(Exception e) {
		e.printStackTrace();
		writer.println("<script type='text/javascript'>");
		writer.println("alert('이미 받으신 검사입니다.');");
		writer.println("history.back();");
		writer.println("</script>");
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>