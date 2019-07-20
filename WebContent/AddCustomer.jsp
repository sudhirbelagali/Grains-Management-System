<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<%!String message, name, address, mobile;
	int account;
	float balance;
	Date date = new Date();
	Connection con;
	int count = 0, id = 0;
	Statement stmt;

	public void fetch(HttpServletRequest request) {
		try {
			name = request.getParameter("txt_name").toString().trim();
			address = request.getParameter("txt_address").toString().trim();
			mobile = request.getParameter("txt_mob_no").toString().trim();
			account = Integer.parseInt(request.getParameter("txt_acc_no").toString().trim());
			balance = Float.parseFloat(request.getParameter("txt_money_balance").toString());
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
			int k = stmt.executeUpdate("insert into customer values('" + id + "','" + name + "','" + address + "','"
					+ account + "','" + balance + "','" + mobile + "','" + date + "')");
			message = "Customer Details Added successfully!";
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void Retrieve() {
		try {
			ResultSet resultset = stmt.executeQuery("select count(*),max(account_no)from customer");
			resultset.next();
			count = resultset.getInt(1);
			if (count == 0) {
				id = 1;
			} else {
				id = resultset.getInt(2);
				id = id + 1;
			}
			resultset.close();
			stmt.close();

		} catch (Exception e) {
			message = e.getMessage();
		}
	}%>
<%
	connection();
	Retrieve();
	if (request.getParameter("btn_submit") != null) {
		fetch(request);
		connection();
		insert();
	}
%>
<head>
<meta charset="UTF-8">
<title>Insert Customer Details</title>
</head>
<body>
	<a href="index.html">BACK</a>
	<h1 align="center">Add Customer Details</h1>
	<form action="AddCustomer.jsp" method="post">
		<table align="center" border="2">
			<tr>
				<td>Date</td>
				<td><input type="text" value="<%=date%>" readonly="readonly"
					required="required"></td>
			</tr>
			<tr>
				<td>Full Name</td>
				<td><input type="text" name="txt_name" required="required"></td>
			</tr>
			<tr>
				<td>Address</td>
				<td><input type="text" name="txt_address" required="required"></td>
			</tr>
			<tr>
				<td>Mobile Number</td>
				<td><input type="text" name="txt_mob_no"></td>
			</tr>
			<tr>
				<td>Account Number</td>
				<td><input type="text" name="txt_acc_no" value="<%=id%>"
					required="required"></td>
			</tr>
			<tr>
				<td>Account Balance</td>
				<td><input type="text" name="txt_money_balance"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" name="btn_submit" value="SUBMIT"></td>
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