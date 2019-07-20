<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Vector"%>
<!DOCTYPE html>
<html>
<%!int amount = 0;
	int customerid;
	String message;
	Connection con;
	Statement stmt;
	PreparedStatement ps = null;
	Date date = new Date();

	Vector vec_cid = new Vector();
	Vector vec_cname = new Vector();
	Vector vec_balance = new Vector();
	public void fetch(HttpServletRequest request) {
		try {
			customerid = Integer.parseInt(request.getParameter("txt_customerid").toString().trim());
			amount = Integer.parseInt(request.getParameter("txt_amount").toString());
		} catch (Exception e) {
			message = e.getLocalizedMessage();
		}
	}

	public void update() {
		try {
			String sql = "update customer set balance = balance + ?, modifieddate=? where account_no=" + customerid;
			ps = con.prepareStatement(sql);
			ps.setInt(1, amount);
			ps.setString(2, date.toGMTString());
			int i = ps.executeUpdate();
			if (i > 0) {
				message = "Amount Added successfully!";
			}
		} catch (Exception e) {
			message = e.getMessage();
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

	public void retrieve() {
		try {

			ResultSet resultset1 = stmt.executeQuery("select id, name, balance from customer");
			while (resultset1.next()) {
				vec_cid.add(resultset1.getInt("id"));
				vec_cname.add(resultset1.getString("name"));
				vec_balance.add(resultset1.getFloat("balance"));
			}
			//resultset1.close();
			//stmt.close();

		} catch (Exception e) {
			message = e.getMessage();
		}
	}%>
<%
	connection();
	retrieve();
	if (request.getParameter("btn_submit") != null) {
		connection();
		fetch(request);
		update();
	}
%>
<head>
<meta charset="UTF-8">
<title>Give Advance Money</title>
</head>
<body>
	<a href="index.html">BACK</a>
	<h1 align="center">Give some Advance Money</h1>
	<form action="AdvanceMoney.jsp">
		<table align="center" border="1">
			<tr>
				<td>Select Customer Name/AccountNo/Balance</td>
				<td><select name="txt_customerid">
						<%
							for (int i = 0; i < vec_cid.size(); i++) {
						%>

						<option value="<%=vec_cid.get(i)%>"><%=vec_cname.get(i)%>
							/
							<%=vec_cid.get(i)%>/<%=vec_balance.get(i)%></option>
						<%
							}
						%>
				</select></td>
			</tr>
			<tr>
				<td>Enter the Amount</td>
				<td><input type="text" name="txt_amount" required="required"></td>
			</tr>
			<tr>
				<td>Date</td>
				<td><input type="text" value="<%=date%>" readonly="readonly"
					required="required"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" name="btn_submit"></td>
			</tr>
		</table>
	</form>
	<h1 align="center">Available Customers with Balance</h1>
	<table align="center" border="1">
		<tr>
			<td>Customer Account Number</td>
			<td>Customer Name</td>
			<td>Balance</td>
		</tr>
		<%
			for (int i = 0; i < vec_cid.size(); i++) {
		%>
		<tr>
			<td><%=vec_cid.get(i)%></td>
			<td><%=vec_cname.get(i)%></td>
			<td><%=vec_balance.get(i)%></td>
			<%
				}
				vec_cid.clear();
				vec_cname.clear();
				vec_balance.clear();
			%>
		</tr>
	</table>
	<script type="text/javascript">
<%if (request.getParameter("btn_submit") != null) {%>
	alert("<%=message%>");
	<%}%>
		
	</script>
	<a href="index.html">BACK</a>
</body>
</html>