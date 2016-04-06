<%@page import="beans.UserBeanRemote"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register</title>
</head>
<body>
	<a href="index.jsp">Pocetna strana</a><br>
	<%
	UserBeanRemote user = (UserBeanRemote)request.getSession().getAttribute("user");
	String prazan = "";
	if (user == null){
		%>
		<form action="/PrisWEB/AddPolaznikServlet" method="post">
			Ime: <input type="text" name="ime" value="${ime != null ? ime : prazan}"><br>
			Prezime: <input type="text" name="prezime" value="${prezime != null ? prezime : prazan}"><br>
			Username: <input type="text" name="username" value="${username != null ? username : prazan}"><br>
			Password: <input type="password" name="password"><br>
			<input type="submit" value="Submit">
		</form>
		<c:forEach items="${greske}" var="greska">
			${greska}<br>
		</c:forEach>
		<%
		String poruka = (String)request.getAttribute("poruka");
		if (poruka != null)
			out.println(poruka);
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