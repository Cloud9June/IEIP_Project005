<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String p_no = request.getParameter("p_no");
	String t_name = request.getParameter("t_name");
	
	StringBuffer sb = new StringBuffer();
	
	sb.append("select p.p_no, p.p_name, l.t_name,");
	sb.append(" to_char(r.t_sdate, 'YYYY-MM-DD') t_sdate,");
	sb.append(" case r.t_status when '1' then '검사중' when '2' then '검사완료' end t_sdate,");
	sb.append(" to_char(r.t_ldate,'YYYY-MM-DD') t_ldate,");
	sb.append(" case r.t_result when 'X' then '미입력' when 'P' then '양성' when 'N' then '음성' end t_result");
	sb.append(" from tbl_patient_202004 p, tbl_lab_test_202004 l, tbl_result_202004 r");
	sb.append(" where p.p_no = r.p_no and l.t_code=r.t_code");
	sb.append(" and p.p_no="+p_no);
	sb.append(" and l.t_name='"+t_name+"'");
	sb.append(" order by p_no");
	
	String sql = sb.toString();

	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css?ver=1">
<script type="text/javascript">

	function chkVal() {
		
		var status = document.getElementsByName("t_status");
		var result = document.getElementsByName("t_result");

		if(result[0].checked!=true && result[1].checked!=true){
			alert("검사결과가 선택되지 않았습니다!");
			return false;
		}
		
		document.tData.p_no.disabled = "";
		document.tData.t_code.disabled = "";
	}
	
	function marking() {
		var status = document.getElementsByName("t_status");
		status[1].checked = true;
	}

</script>
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/nav.jsp"></jsp:include>
	
	<section id="section">
		<h2>검사결과입력_수정</h2>
		
		<form action="testResultUpt.jsp" name="tData" method="post" onsubmit="return chkVal()">
			<table class="inputTable">
				<tr>
					<th>환자번호</th>
					<td>
						<input type="text" name="p_no" size="15" value="<%= rs.getString(1) %>" disabled="disabled">
					</td>
				</tr>
				<tr>
					<th>환자이름</th>
					<td>
						<input type="text" name="p_name" size="15" value="<%= rs.getString(2) %>" disabled="disabled">
					</td>
				</tr>
				<tr>
					<th>검사명</th>
					<td>
						<select name="t_code" disabled="disabled"">
							<option value="none">검사명</option>
 							<option value="T001" <%= t_name.equals("결핵")?"selected":"" %>>[T001]결핵</option>
							<option value="T002" <%= t_name.equals("장티푸스")?"selected":"" %>>[T002]장티푸스</option>
							<option value="T003" <%= t_name.equals("수두")?"selected":"" %>>[T003]수두</option>
							<option value="T004" <%= t_name.equals("홍역")?"selected":"" %>>[T004]홍역</option>
							<option value="T005" <%= t_name.equals("콜레라")?"selected":"" %>>[T005]콜레라</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>검사시작일자</th>
					<td>
						<input type="text" name="t_sdate" size="15" value="<%= rs.getString(4) %>" disabled="disabled">
					</td>
				</tr>
				<tr>
					<th>검사상태</th>
					<td>
						<input type="radio" name="t_status" value="1" checked onclick="return(false);">검사중
						<input type="radio" name="t_status" value="2" onclick="return(false);">검사완료
					</td>
				</tr>
				<tr>
					<th>검사완료일자</th>
					<td>
						<input type="text" name="t_ldate" size="15" value="<%= rs.getString(6) %>" disabled="disabled">
					</td>
				</tr>
				<tr>
					<th>검사결과</th>
					<td>
						<input type="radio" name="t_result" value="P" onclick="return marking()">양성
						<input type="radio" name="t_result" value="N" onclick="return marking()">음성
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="검사결과등록">
					</td>
				</tr>
			</table>
		</form>
	</section>

	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>