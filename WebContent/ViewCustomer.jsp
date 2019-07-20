<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<%!String message;
	Connection con;
	Statement stmt;

	public void connection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("Jdbc:mysql://localhost:3306/kumar", "root", "sudhir");
			stmt = con.createStatement();
		} catch (Exception e) {
			message = e.getLocalizedMessage();
		}
	}%>
<head>
<meta charset="UTF-8">
<title>View Customers</title>
</head>
<body>
	<a href="index.html">BACK</a>
	<h1 align="center">Available Customers</h1>
	<table align="center" border="1">
		<tr>
			<td>Customer Account Number/ID</td>
			<td>Customer Name</td>
			<td>Address</td>
			<td>Mobile Number</td>
			<td>Account Number</td>
			<td>Date</td>
			<td>Balance</td>
		</tr>
		<%
			connection();
			ResultSet resultset = stmt.executeQuery("select * from customer order by id;");
			while (resultset.next()) {
		%>
		<tr>
			<td><%=resultset.getInt("id")%></td>
			<td><%=resultset.getString("name")%></td>
			<td><%=resultset.getString("address")%></td>
			<td><%=resultset.getString("mobile")%></td>
			<td><%=resultset.getInt("account_no")%></td>
			<td><%=resultset.getString("modifieddate")%></td>
			<td><%=resultset.getFloat("balance")%></td>
			<%
				}
			%>
		</tr>
	</table>
	<a href="index.html">BACK</a>
</body>
</html>
