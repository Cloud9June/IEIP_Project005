<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	StringBuffer sb = new StringBuffer();
	sb.append("select p_no, p_name,");
	sb.append(" substr(p_birth,1,4)||'년'||substr(p_birth,5,2)||'월'||substr(p_birth,7,2)||'일' p_birth,");
	sb.append(" case p_gender when 'M' then '남' else '여' end p_gender,");
	sb.append(" p_tel1||'-'||p_tel2||'-'||p_tel3 tel,");
	sb.append(" case p_city when '10' then '서울' when '20' then '경기' when '30' then '강원' when '40' then '대구' end p_city");
	sb.append(" from tbl_patient_202004");
	
	String sql = sb.toString();

	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css?ver=1">
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/nav.jsp"></jsp:include>
	<section id="section">
		<h2>환자조회</h2>
		
		<table width="40%">
			<colgroup>
				<col width="15%">
				<col width="15%">
				<col width="20%">
				<col width="15%">
				<col width="20%">
				<col width="15%">
			</colgroup>
			<thead>
				<tr>
					<th>환자번호</th>
					<th>환자성명</th>
					<th>생년월일</th>
					<th>성별</th>
					<th>전화번호</th>
					<th>지역</th>
				</tr>
			</thead>
			<tbody>
				<%
					while(rs.next()) {
				%>
				<tr>
					<td><%= rs.getString(1)%></td>
					<td><%= rs.getString(2)%></td>
					<td><%= rs.getString(3)%></td>
					<td><%= rs.getString(4)%></td>
					<td><%= rs.getString(5)%></td>
					<td><%= rs.getString(6)%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>	
	</section>
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>