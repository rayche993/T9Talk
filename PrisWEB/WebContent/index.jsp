<%@page import="beans.UserBeanRemote"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Talk - skola stranih jezika</title>
</head>
<body>
	<%
	UserBeanRemote user = (UserBeanRemote)request.getSession().getAttribute("user");
	if (user == null){
		%>
		<a href="login.jsp">Login</a><br>
		<a href="register.jsp">Register</a>
		<%
	}else{
		%>
		Dobrodosli <% out.println(user.getMyUser().getUsername()); %> .
		<%
		if (user.isAdmin()){
			%>
			<a href="admin.jsp">Admin Panel</a>
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