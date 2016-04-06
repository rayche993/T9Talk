<%@page import="beans.UserBeanRemote"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
	<a href="index.jsp">Pocetna strana</a>
	<%
	UserBeanRemote user = (UserBeanRemote)request.getSession().getAttribute("user");
	if (user == null){
	%>
	<form action="/PrisWEB/LoginServlet" method="post">
		Username: <input type="text" name="username"><br>
		Password: <input type="password" name="password"><br>
		<input type="submit" value="Submit">
	</form>
	<% 
	}else{
		%>
		Ulogovani ste kao <% out.println(user.getMyUser().getUsername()); %> .
		<a href="index.jsp">Pocetna strana</a><br>
		<%
		if (user.isAdmin()){
			%>
			<a href="admin.jsp">Admin Panel</a><br>
			<%
		}
		%>
		<form action="/PrisWEB/LogoutServlet" method="post">
			<input type="submit" value="Logout">
		</form>
		<%
	}
	%>
</body>
</html>