<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	StringBuffer sb = new StringBuffer();
	sb.append("select p.p_no, p.p_name, l.t_name,");
	sb.append(" to_char(r.t_sdate, 'YYYY-MM-DD') t_sdate,");
	sb.append(" case r.t_status when '1' then '검사중' when '2' then '검사완료' end t_sdate,");
	sb.append(" to_char(r.t_ldate,'YYYY-MM-DD') t_ldate,");
	sb.append(" case r.t_result when 'X' then '미입력' when 'P' then '양성' when 'N' then '음성' end t_result");
	sb.append(" from tbl_patient_202004 p, tbl_lab_test_202004 l, tbl_result_202004 r");
	sb.append(" where p.p_no = r.p_no and l.t_code=r.t_code");
	sb.append(" order by p_no");
	
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
		<h2>검사결과조회</h2>
		
		<table>
			<thead>
				<tr>
					<th>환자번호</th>
					<th>환자명</th>
					<th>검사명</th>
					<th>검사시작일</th>
					<th>검사상태</th>
					<th>검사완료일</th>
					<th>검사결과</th>
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
					<td><%= rs.getString(7)%></td>
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