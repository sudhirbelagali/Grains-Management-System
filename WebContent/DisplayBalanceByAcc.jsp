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
	int customerid = 0, account = 0;
	String message, name = "", mobile = "";
	Connection con;
	Statement stmt;
	PreparedStatement ps = null;
	Vector vec_cid = new Vector();
	Vector vec_cname = new Vector();
	String modifieddate;

	public void fetch(HttpServletRequest request) {
		try {
			customerid = Integer.parseInt(request.getParameter("txt_account_no").toString().trim());
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

	public void retrieve() {
		try {

			ResultSet resultset1 = stmt.executeQuery("select * from customer where account_no =" + customerid);
			resultset1.next();

			account = resultset1.getInt("id");
			name = resultset1.getString("name");
			mobile = resultset1.getString("mobile");
			amount = (resultset1.getInt("balance"));
			modifieddate = resultset1.getString("modifieddate");

			//resultset1.close();
			//stmt.close();

		} catch (Exception e) {
			message = e.getMessage();
		}
	}

	public void fetchaccdetails() {
		try {
			ResultSet resultset2 = stmt.executeQuery("select id, name from customer");
			while (resultset2.next()) {
				vec_cid.add(resultset2.getInt("id"));
				vec_cname.add(resultset2.getString("name"));
			}

		} catch (Exception e) {

		}
	}%>
<%
	connection();
	fetchaccdetails();
	if (request.getParameter("btn_submit") != null) {
		connection();
		fetch(request);
		retrieve();
	}
%>

<head>
<meta charset="UTF-8">
<title>Display Balance By Account Number</title>
</head>
<body>
	<a href="index.html">BACK</a>
	<h1 align="center">Display Balance By Account Number</h1>
	<form action="DisplayBalanceByAcc.jsp" method="post">
		<table align="center" border="1">
			<tr>
				<td>Enter the Valid Account Number</td>
				<td><input type="text" name="txt_account_no"
					required="required"></td>
				<td>Or look Here</td>
				<td><select name="txt_customerid">
						<%
							for (int i = 0; i < vec_cid.size(); i++) {
						%>

						<option value="<%=vec_cid.get(i)%>"><%=vec_cname.get(i)%>
							and
							<%=vec_cid.get(i)%></option>
						<%
							}

							vec_cid.clear();
							vec_cname.clear();
						%>
				</select></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" name="btn_submit"></td>
			</tr>
		</table>
	</form>
	<div align="center" id="printTable">
		<h3>
			Shree Banantidevi Milk Production Society Banantikodi <br>----------------------------------------------------------------------------<br>
			Contact - Mr. Kumar Huddar. Mob - 9449014942 <br> Following is
			your account and balance detail
		</h3>
		<table>
			<tr>
				<td>Account number</td>
				<td><%=customerid%></td>
			</tr>
			<tr>
				<td>Name</td>
				<td><%=name%></td>
			</tr>
			<tr>
				<td>Date</td>
				<td><%=modifieddate%></td>
			</tr>
			<tr>
				<td>Mobile Number</td>
				<td><%=mobile%></td>
			</tr>
			<tr>
				<td>Balance</td>
				<td><%=amount%></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td><button onclick="printFunction()">Print Report</button></td>
			</tr>
		</table>
	</div>
	<script>
		function printFunction() {
			var divToPrint = document.getElementById("printTable");
			newWin = window.open("");
			newWin.document.write(divToPrint.outerHTML);
			newWin.print();
			newWin.close();
			printData();
		}
	</script>
	<a href="index.html">BACK</a>
</body>
</html>