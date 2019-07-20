<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Vector"%>
<!DOCTYPE html>
<html>
<%!String message;
	Connection con;
	Statement stmt;
	String fromdate, todate;
	Vector vec_pid = new Vector();
	Vector vec_cid = new Vector();
	Vector vec_date = new Vector();
	Vector vec_quantity = new Vector();
	Vector vec_amount = new Vector();
	Vector vec_status = new Vector();

	public void fetch(HttpServletRequest request) {
		try {
			fromdate = (request.getParameter("txt_fromdate").toString().trim());
			todate = (request.getParameter("txt_todate").toString().trim());
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

	public void retrive() {
		try {
			ResultSet resultset = stmt
					.executeQuery("select * from orders where date between '" + fromdate + "' and '" + todate + "'");
			while (resultset.next()) {
				vec_pid.add(resultset.getInt("productid"));
				vec_cid.add(resultset.getInt("customerid"));
				vec_date.add(resultset.getString("date"));
				vec_quantity.add(resultset.getInt("quantity"));
				vec_amount.add(resultset.getFloat("amount"));
				vec_status.add(resultset.getString("status"));
			}
		} catch (Exception e) {
			message = e.getMessage();
		}
	}%>
<head>
<meta charset="UTF-8">
<title>Display Sales with Custom Dates</title>
</head>
<%
	if (request.getParameter("btn_submit") != null) {
		connection();
		fetch(request);
		retrive();
	}
%>
<body>
	<a href="index.html">BACK</a>
	<form action="ViewSalesDateswise.jsp" method="post">
		<h1 align="center">Display Sales with Customized Dates</h1>
		<table align="center" border="1">
			<tr>
				<td>From Date</td>
				<td><input type="date" name="txt_fromdate"></td>
			</tr>
			<tr>
				<td>To Date</td>
				<td><input type="date" name="txt_todate"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" name="btn_submit"></td>
			</tr>
		</table>
	</form>
	<h1 align="center">Display Sales with Custom Dates</h1>
	<table align="center" border="1">
		<tr>
			<td>Product ID</td>
			<td>Customer Account No</td>
			<td>Date</td>
			<td>Quantity</td>
			<td>Amount</td>
			<td>Status</td>
		</tr>
		<%
			for (int i = 0; i < vec_cid.size(); i++) {
		%>
		<tr>
			<td><%=vec_pid.get(i)%></td>
			<td><%=vec_cid.get(i)%></td>
			<td><%=vec_date.get(i)%></td>
			<td><%=vec_quantity.get(i)%></td>
			<td><%=vec_amount.get(i)%></td>
			<td><%=vec_status.get(i)%></td>
			<%
				}
				vec_pid.clear();
				vec_cid.clear();
				vec_date.clear();
				vec_quantity.clear();
				vec_amount.clear();
				vec_status.clear();
			%>
		</tr>
	</table>
	<a href="index.html">BACK</a>
</body>
</html>