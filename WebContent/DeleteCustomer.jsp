<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Vector"%>
<!DOCTYPE html>
<html>
<%!int account = 0;
	int customerid;
	String message;
	Connection con;
	Statement stmt;
	PreparedStatement ps = null;

	Vector vec_cid = new Vector();
	Vector vec_cname = new Vector();

	public void fetch(HttpServletRequest request) {
		try {
			//		customerid = Integer.parseInt(request.getParameter("txt_customerid").toString().trim());
			account = Integer.parseInt(request.getParameter("txt_account").toString());
		} catch (Exception e) {
			message = e.getLocalizedMessage();
		}
	}

	public void update() {
		try {
			String sql = "delete from customer where account_no=" + account;
			ps = con.prepareStatement(sql);
			int i = ps.executeUpdate();
			if (i > 0) {
				message = "Customer Deleted successfully!";
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

			ResultSet resultset1 = stmt.executeQuery("select id, name from customer");
			while (resultset1.next()) {
				vec_cid.add(resultset1.getInt("id"));
				vec_cname.add(resultset1.getString("name"));
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
<title>Delete Customer</title>
</head>
<body>
	<a href="index.html">BACK</a>
	<h1 align="center">Delete Customer</h1>
	<form action="DeleteCustomer.jsp" method="get">
		<table align="center" border="1">
			<tr>
				<td>Select Customer Name and Account number</td>
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
				<td>Customer Account Number or ID</td>
				<td><input type="text" name="txt_account" required="required"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" name="btn_submit"></td>
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