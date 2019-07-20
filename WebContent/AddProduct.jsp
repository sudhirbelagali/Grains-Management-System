<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<%!String message, pname;
	int pid = 0, stock = 0;
	float price;

	Connection con;
	int count = 0;
	Statement stmt;

	public void fetch(HttpServletRequest request) {
		try {
			pname = request.getParameter("txt_productname").toString().trim();
			price = Float.parseFloat(request.getParameter("txt_price").toString());
			stock = Integer.parseInt(request.getParameter("txt_stock").toString().trim());

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
			int k = stmt.executeUpdate(
					"insert into product values('" + pid + "','" + pname + "','" + price + "','" + stock + "')");
			message = "Product Details Added successfully!";
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void Retrieve() {
		try {
			ResultSet resultset = stmt.executeQuery("select count(*),max(pid)from product");
			resultset.next();
			count = resultset.getInt(1);
			if (count == 0) {
				pid = 1;
			} else {
				pid = resultset.getInt(2);
				pid = pid + 1;
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
<title>Add Product Details</title>
</head>
<body>
	<a href="index.html">BACK</a>
	<h1 align="center">Add Product Details</h1>
	<form method="post" action="AddProduct.jsp">
		<table border="1" align="center">
			<tr>
				<td>Product ID</td>
				<td><input type="text" name="txt_pid" value="<%=pid%>"
					readonly="readonly"></td>
			</tr>
			<tr>
				<td>Product Name</td>
				<td><input type="text" name="txt_productname"
					required="required"></td>
			</tr>
			<tr>
				<td>Product Price</td>
				<td><input type="text" name="txt_price" required="required"></td>
			</tr>
			<tr>
				<td>Product Quantity/Stock</td>
				<td><input type="text" name="txt_stock" required="required"></td>
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