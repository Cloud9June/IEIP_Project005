<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	StringBuffer sb = new StringBuffer();
	sb.append("select p.p_city, ");
	sb.append(" case p_city when '10' then '서울' when '20' then '경기' when '30' then '강원' when '40' then '대구' end p_cityName,");
	sb.append(" count(*)");
	sb.append(" from tbl_patient_202004 p, tbl_result_202004 r");
	sb.append(" where p.p_no = r.p_no");
	sb.append(" group by p.p_city");
	sb.append(" order by p_city");
	
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
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/nav.jsp"></jsp:include>
	<section id="section">
		<h2>(지역별)검사건수통계</h2>
		
		<table>
			<colgroup>
				<col width="20%">
				<col width="60%">
				<col width="20%">
			</colgroup>
			<thead>
				<tr>
					<th>지역코드</th>
					<th>지역명</th>
					<th>검사건수</th>
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