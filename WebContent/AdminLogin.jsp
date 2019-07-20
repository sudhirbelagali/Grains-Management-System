<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<%!String login, password;
	String msg = null;
	int flag;
	String login1, password1;
	Connection con;
	Statement stmt;
	PreparedStatement ps = null;

	public void fetch(HttpServletRequest request) {
		try {
			login = request.getParameter("txt_login");
			password = request.getParameter("txt_password");

		} catch (Exception e) {
			msg = e.getMessage();
		}
	}
	public void connection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("Jdbc:mysql://localhost:3306/kumar", "root", "sudhir");
			stmt = con.createStatement();
		} catch (Exception e) {
			msg = e.getLocalizedMessage();
		}
	}

	public void retrieve() {
		try {
			/* ResultSet resultset1 = stmt.executeQuery("select * from customer where account_no =" + customerid);
			resultset1.next(); */

			/* account = resultset1.getInt("id");
			name = resultset1.getString("name");
			mobile = resultset1.getString("mobile");
			amount = (resultset1.getInt("balance"));
			modifieddate = resultset1.getString("modifieddate"); */

			//resultset1.close();
			//stmt.close();

		} catch (Exception e) {
			//message = e.getMessage();
		}
	}

	public void select(HttpServletResponse response) {
		try {

			/* 	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			
				Query q = new Query("studentDB");
				PreparedQuery pq = datastore.prepare(q);
				List<Entity> res = pq.asList(FetchOptions.Builder.withDefaults());
			
				for (Entity studentDB : pq.asIterable()) {
			
					login1 = (String) studentDB.getProperty("Login_id");
					password1 = (String) studentDB.getProperty("Password");
					if (login1 != null && password1 != null && login.equalsIgnoreCase(login1)
							&& password.equalsIgnoreCase(password1)) {
						flag = 1;
						break;
					}				
					}
				
				if(flag == 1){
					response.sendRedirect("StudentHomePage.jsp");
				}
					else {
						msg = "User Name or Password are mismatched";
					} */
		} catch (Exception e) {
			//msg = e.getMessage();
		}
	}%>
<%
	if (request.getParameter("btn_submit") != null) {
		fetch(request);
		select(response);
	}
%>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
</head>
<body>
	<form method="post" action="AdminLogin.jsp">

		<table border="1" align="center">
			<tr>
				<td>Enter Login Id</td>
				<td><input type="text" name="txt_login" required=""></td>

			</tr>
			<tr>
				<td>Enter Password</td>
				<td><input type="password" name="txt_password" required=""></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" name="btn_submit"></td>
			</tr>
		</table>
	</form>
</body>
<script type="text/javascript">
<%if (request.getParameter("btn_submit") != null) {%>
	alert("<%=msg%>
	");
<%}%>
	
</script>

</html>