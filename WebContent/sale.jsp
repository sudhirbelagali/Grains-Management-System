<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%!String date, name;
	Float amount;
	int productid, customerid, quantity;
	String message;

	Connection con;
	int count = 0;
	Statement stmt;

	String status = null;
	Float fetchedbalance, exactbalance;
	PreparedStatement ps = null;

	Vector vec_pid = new Vector();
	Vector vec_pname = new Vector();
	Vector vec_cid = new Vector();
	Vector vec_cname = new Vector();

	public void connection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("Jdbc:mysql://localhost:3306/kumar", "root", "sudhir");
			stmt = con.createStatement();
		} catch (Exception e) {
			message = e.getLocalizedMessage();
		}
	}

	public void fetch(HttpServletRequest request) {
		try {
			productid = Integer.parseInt(request.getParameter("txt_productid").toString().trim());
			customerid = Integer.parseInt(request.getParameter("txt_customerid").toString().trim());
			date = request.getParameter("txt_date").toString().trim();
			quantity = Integer.parseInt(request.getParameter("txt_quantity").toString().trim());
			amount = Float.parseFloat(request.getParameter("txt_amount").toString());
			status = (request.getParameter("txt_paid").toString().trim().toLowerCase());
		} catch (Exception e) {
			message = e.getLocalizedMessage();
		}
	}

	public void insert() {
		try {
			int k = stmt.executeUpdate("insert into orders values('" + productid + "','" + customerid + "','" + date
					+ "','" + quantity + "','" + exactbalance + "','" + status + "')");
			message = "Sale done successfully!";
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void retrieve() {
		try {
			ResultSet resultset = stmt.executeQuery("select pid, productname from product");
			while (resultset.next()) {
				vec_pid.add(resultset.getInt("pid"));
				vec_pname.add(resultset.getString("productname"));
			}
			//resultset.close();
			//			stmt.close();

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
	}
	public void fetchbalance() {
		try {
			ResultSet resultset1 = stmt.executeQuery("select * from customer where account_no =" + customerid);
			resultset1.next();
			fetchedbalance = (resultset1.getFloat("balance"));
			name = resultset1.getString("name");

		} catch (Exception e) {

		}

	}
	public void updatecustomertablebalance() {
		try {
			String sql = "update customer set balance = ?, modifieddate=? where account_no=" + customerid;
			ps = con.prepareStatement(sql);
			ps.setFloat(1, exactbalance);
			ps.setString(2, date.toString().trim());
			int i = ps.executeUpdate();
			if (i > 0) {
				message = "Amount Changed successfully!";
			}
		} catch (Exception e) {
			message = e.getMessage();
		}
	}
	public void updatestock() {
		try {
			String sql = "update product set stock = stock - ? where pid=" + productid;
			ps = con.prepareStatement(sql);
			ps.setInt(1, quantity);
			int i = ps.executeUpdate();
			if (i > 0) {
				message = "Stock Updated successfully!";
			}

		} catch (Exception e) {

		}
	}%>
<%
	connection();
	String notpaid = "notpaid";
	retrieve();
	if (request.getParameter("btn_submit") != null) {
		connection();
		fetch(request);
		fetchbalance();
		try {
			if ("notpaid".equals(status) && status != null) {
				exactbalance = fetchedbalance + amount;
				updatecustomertablebalance();
				updatestock();
				insert();
			} else {
				exactbalance = amount;
				updatestock();
				insert();
			}
		} catch (Exception e) {
			message = e.getLocalizedMessage();
		}
	}
%>
<head>
<meta charset="UTF-8">
<title>Point of Sale</title>
</head>
<body>
	<a href="index.html">BACK</a>

	<form action="sale.jsp" method="post">
		<h1 align="center">Point of Sale</h1>
		<table align="center" border="1">
			<tr>
				<td>Select Product Name and ID</td>
				<td><select name="txt_productid">
						<%
							for (int i = 0; i < vec_pid.size(); i++) {
						%>
						<option value="<%=vec_pid.get(i)%>"><%=vec_pname.get(i)%>
							and
							<%=vec_pid.get(i)%>
							<%
								}
								vec_pid.clear();
								vec_pname.clear();
							%>
						</option>
				</select></td>
			</tr>
			<tr>
				<td>Customer Name and Account No</td>
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
							vec_pname.clear();
						%>
				</select><a href="AddCustomer.jsp" target="_blank">New Customer</a></td>
			</tr>

			<tr>
				<td>Date</td>
				<td><input type="date" name="txt_date" required="required"></td>
			</tr>
			<tr>
				<td>Quantity</td>
				<td><input type="text" name="txt_quantity" required="required"></td>
			</tr>
			<tr>
				<td>Amount</td>
				<td><input type="text" name="txt_amount" required="required"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="radio" name="txt_paid" value="paid"
					required="required" checked="checked">PAID FULL<br> <input
					type="radio" name="txt_paid" value="notpaid">Not PAID FULL</td>
			</tr>

			<tr>
				<td></td>
				<td><input type="submit" name="btn_submit" value="SUBMIT"></td>
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
				<td><%=date%></td>
			</tr>
			<tr>
				<td>Quantity</td>
				<td><%=quantity%></td>
			</tr>
			<tr>
				<td>Amount</td>
				<td><%=amount%></td>
			</tr>
			<tr>
				<td>PAID OR NOT</td>
				<td><%=status%></td>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td><button onclick="printFunction()">Print Report</button></td>
			</tr>
		</table>
	</div>

	<script type="text/javascript">
<%if (request.getParameter("btn_submit") != null) {%>
	alert("<%=message%>");
		var divToPrint = document.getElementById("printTable");
		newWin = window.open("");
		newWin.document.write(divToPrint.outerHTML);
		newWin.print();
		newWin.close();
		printData();
	<%}%>
		
	</script>
	<a href="index.html">BACK</a>
</body>
</html>