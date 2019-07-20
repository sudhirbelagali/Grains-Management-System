<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Vector"%>
<!DOCTYPE html>
<html>
<%!int stock = 0;
	int productid;
	String message;
	Connection con;
	Statement stmt;
	PreparedStatement ps = null;
	Date date = new Date();

	Vector vec_pid = new Vector();
	Vector vec_pname = new Vector();

	public void fetch(HttpServletRequest request) {
		try {
			productid = Integer.parseInt(request.getParameter("txt_productid").toString().trim());
			stock = Integer.parseInt(request.getParameter("txt_stock").toString());
		} catch (Exception e) {
			message = e.getLocalizedMessage();
		}
	}

	public void update() {
		try {
			String sql = "update product set stock = ? where pid=" + productid;
			ps = con.prepareStatement(sql);
			ps.setInt(1, stock);
			int i = ps.executeUpdate();
			if (i > 0) {
				message = "Stock Updated successfully!";
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
			ResultSet resultset1 = stmt.executeQuery("select pid, productname from product");
			while (resultset1.next()) {
				vec_pid.add(resultset1.getInt("pid"));
				vec_pname.add(resultset1.getString("productname"));
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
<title>Update Stock Successfully!</title>
</head>
<body>
	<a href="index.html">BACK</a>
	<h1 align="center">Update the Stock</h1>
	<form action="UpdateStock.jsp" method="get">
		<table align="center" border="1">
			<tr>
				<td>Select product Name/ID</td>
				<td><select name="txt_productid">
						<%
							for (int i = 0; i < vec_pid.size(); i++) {
						%>

						<option value="<%=vec_pid.get(i)%>"><%=vec_pname.get(i)%>
							and
							<%=vec_pid.get(i)%></option>
						<%
							}

							vec_pid.clear();
							vec_pname.clear();
						%>
				</select></td>
			</tr>
			<tr>
				<td>Enter the stock</td>
				<td><input type="text" name="txt_stock" required="required"></td>
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