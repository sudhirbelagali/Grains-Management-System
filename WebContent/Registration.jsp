
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%!String message, name, usn;
	Connection con;
	Statement stmt;

	public void fetch(HttpServletRequest request) {
		try {
			usn = request.getParameter("txt_usn").toString();
			name = request.getParameter("txt_name").toString();
		} catch (Exception e) {
			message = e.getLocalizedMessage();
		}
	}

	public void connection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("Jdbc:mysql://localhost:3306/kumar", "root", "sudhir");
			stmt = con.createStatement();
		} catch (Exception e) {
			message = e.getLocalizedMessage();
		}
	}

	public void insert() {
		try {
			int k = stmt.executeUpdate("insert into student values('" + usn + "','" + name + "')");
			message = "Student Details Inserted successfully!";
		} catch (Exception e) {
			e.printStackTrace();
		}
	}%>
<%
	if (request.getParameter("btn_submit") != null) {
		fetch(request);
		connection();
		insert();
	}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Student Registration</title>
</head>
<body>
	<a href="index.html">BACK</a>
	<h1 align="center">Student Registration</h1>
	<form action="Registration.jsp" method="post">
		<table align="center" border="2">
			<tr>
				<td>USN</td>
				<td><input type="text" name="txt_usn"></td>
			</tr>
			<tr>
				<td>Name</td>
				<td><input type="text" name="txt_name"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" name="btn_submit" value="INSERT"></td>
			</tr>

		</table>
	</form>
	<script type="text/javascript">
<%if (request.getParameter("btn_submit") != null) {%>
	alert("<%=message%>");
	<%}%>
		
	</script>
	<a href="index.html">BACK</a>
</body>
</html>