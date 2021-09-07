<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sql = "select t_code, t_name from tbl_lab_test_202004";
	
	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css?ver=5">
<script type="text/javascript">

	function chkVal() {

		var test = document.tData;
		var status = document.getElementsByName("t_status");
		var result = document.getElementsByName("t_result");
		
		
		if(!test.p_no.value) {
			alert("환자번호가 입력되지 않았습니다!");
			test.p_no.focus();
			return false;
		}
		if(test.t_code.value=="none") {
			alert("검사코드가 선택되지 않았습니다!");
			test.t_code.focus();
			return false;
		}
		if(!test.t_sdate.value) {
			alert("검사시작일자가 입력되지 않았습니다!");
			test.t_sdate.focus();
			return false;
		}
		if(status[0].checked!=true && status[1].checked!=true) {
			alert("검사상태가 선택되지 않았습니다!");
			return false;
		}
		if(!test.t_ldate.value) {
			alert("검사완료일자가 입력되지 않았습니다!");
			test.t_ldate.focus();
			return false;
		}
		if(result[0].checked!=true && result[1].checked!=true && result[2].checked!=true){
			alert("검사결과가 선택되지 않았습니다!");
			return false;
		}
	}
	
	function re() {
		var hidden = document.getElementsByClassName("hidden");
		alert("정보를 지우고 처음부터 다시 입력 합니다!");
		document.tData.reset();
		document.tData.p_no.focus();
		hidden[0].style.display = "inline-block";
		hidden[1].style.display = "inline-block";
		document.getElementsByClassName("toggle")[0].style.display = "none";
	}
	function marking1() {
		var hidden = document.getElementsByClassName("hidden");
		for(var i=0; i<hidden.length; i++) {
			hidden[i].style.display = "none";
		}
		hidden[0].style.display = "inline-block";
		hidden[1].style.display = "inline-block";
		hidden[0].checked = true;
	}
	
	function marking2() {
		var hidden = document.getElementsByClassName("hidden");
		hidden[0].checked = false; 
		for(var i=0; i<hidden.length; i++) {
			if(i<2) {
				hidden[i].style.display = "none";				
			} else {
				hidden[i].style.display = "inline-block";
			}
			
		}
	}
	
	function marking3() {
		document.getElementsByClassName("row_hidden")[1].style.display="none";
		document.getElementsByClassName("row_hidden")[0].style.display="table-row";
	}
	
	function marking4() {
		document.getElementsByClassName("row_hidden")[0].style.display="none";
		document.getElementsByClassName("row_hidden")[1].style.display="table-row";
	}

</script>
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/nav.jsp"></jsp:include>
	
	<section id="section">
		<h2>검사결과입력</h2>
		
		<form action="testResultInput.jsp" name="tData" method="post" onsubmit="return chkVal()">
			<table class="inputTable">
				<tr>
					<th>환자번호</th>
					<td>
						<input type="text" name="p_no" size="15">
						<span>예)1001</span>
					</td>
				</tr>
				<tr>
					<th>검사코드</th>
					<td>
						<select name="t_code">
							<option value="none">검사명</option>
							<%
								while (rs.next()) {
							%>
								<option value="<%=rs.getString("t_code")%>">[<%=rs.getString("t_code")%>]<%=rs.getString("t_name")%></option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<th>검사시작일자</th>
					<td>
						<input type="text" name="t_sdate" size="15">
						<span>예)20200101</span>
					</td>
				</tr>
				<tr>
					<th>검사상태</th>
					<td>
						<input type="radio" name="t_status" value="1" onclick="marking1()">검사중
						<input type="radio" name="t_status" value="2" onclick="marking2()">검사완료
					</td>
				</tr>
				<tr>
					<th>검사완료일자</th>
					<td>
						<input type="text" name="t_ldate" size="15">
						<span>예)20200101</span>
					</td>
				</tr>
				<tr>
					<th>검사결과</th>
					<td>
						<input type="radio" name="t_result" value="X" class="hidden"><span class="hidden">미입력</span>
						<input type="radio" name="t_result" value="P" class="hidden" onclick="marking3()"><span class="hidden">양성</span>
						<input type="radio" name="t_result" value="N" class="hidden" onclick="marking4()"><span class="hidden">음성</span>
					</td>
				</tr>
				<tr class="row_hidden">
					<td colspan="2">
						<span>양성을 누르셨습니다. 최종확인 후 등록하십시오.</span>
					</td>
				</tr>
				<tr class="row_hidden">
					<td colspan="2">
						<span>음성을 누르셨습니다. 최종확인 후 등록하십시오.</span>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="검사결과등록">
						<input type="button" value="다시쓰기" onclick="re()">
					</td>
				</tr>
			</table>
		</form>
	</section>

	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>