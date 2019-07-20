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
<title>Ledger Book</title>
</head>
<body>
	<a href="index.html">BACK</a>
	<h1 align="center">Ledger Book</h1>
	<table align="center" border="1">
		<tr>
			<td>Customer Name</td>
			<td>Product Name</td>
			<td>Date</td>
			<td>Quantity</td>
			<td>Amount</td>
		</tr>


		<%
			connection();
			ResultSet resultset = stmt.executeQuery(
					"select c.name, p.productname, o.date, o.quantity, o.amount from customer c, product p, orders o where c.id=o.customerid && o.productid=p.pid");
			while (resultset.next()) {
		%>
		<tr>
			<td><%=resultset.getString("name")%></td>
			<td><%=resultset.getString("productname")%></td>
			<td><%=resultset.getString("date")%></td>
			<td><%=resultset.getInt("quantity")%></td>
			<td><%=resultset.getFloat("amount")%></td>
			<%
				}
			%>
		</tr>
	</table>
	<a href="index.html">BACK</a>
</body>
</html>