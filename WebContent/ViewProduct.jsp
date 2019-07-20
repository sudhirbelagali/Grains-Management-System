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
<title>View Products</title>
</head>
<body>
	<a href="index.html">BACK</a>
	<h1 align="center">Available Products</h1>
	<table align="center" border="1">
		<tr>
			<td>Product ID</td>
			<td>Product Name</td>
			<td>Product Price</td>
			<td>Stock in bags</td>
		</tr>


		<%
			connection();
			ResultSet resultset = stmt.executeQuery("select * from product");
			while (resultset.next()) {
		%>
		<tr>
			<td><%=resultset.getInt("pid")%></td>
			<td><%=resultset.getString("productname")%></td>
			<td><%=resultset.getFloat("price")%></td>
			<td><%=resultset.getInt("stock")%></td>
			<%
				}
			%>
		</tr>
	</table>
	<a href="index.html">BACK</a>
</body>
</html>