<%@page import="model.Kurs"%>
<%@page import="beans.UserBeanRemote"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Prikaz kursa</title>
</head>
<body>
	<div class="container">
		<a href="index.jsp">Pocetna Strana</a><br>
		<%
		Kurs kurs = (Kurs)request.getSession().getAttribute("kurs");
		boolean logged = false;
		UserBeanRemote user = (UserBeanRemote)request.getSession().getAttribute("user");
		if (user == null){
			%>
			<a href="login.jsp">Login</a><br>
			<a href="register.jsp">Register</a>
			<%
		}else{
			%>
			Dobrodosli <% out.println(user.getMyUser().getUsername()); logged = true;%> .
			<%
			if (user.isAdmin()){
				%>
				<a href="admin.jsp">Admin Panel</a>
				<%
			}
			%>
			<form action="/PrisWEB/LogoutServlet" method="post">
				<input type="submit" value="Logout">
			</form><br>
			<%
		}
		if (kurs != null){
		%>
			<h2>${kurs.naziv}</h2><br>
			<h4>Opis:</h4>
			<p>${kurs.opis}</p><br>
			<h4>Ocekivani ishod:</h4>
			<p>${kurs.ishod}</p><br>
			
			<h2>Komentari:</h2>
			
			<table class="table table-hover">
				<c:forEach items="${komentari}" var="komentar">
				<tr>
					<td>${komentar.user.username}  :</td>
					<td>${komentar.opis}</td>
				</tr>
				</c:forEach>
			</table>
			
			<%
			if (logged){
				%>
				<form action="/PrisWEB/AddKomentarServlet" method="post">
					Komentar: <input type="text" name="komentar"><br>
					<input type="submit" value="Submit">
				</form>
				<%
			}
			
			if (request.getAttribute("poruka") != null)
				out.println(request.getAttribute("poruka"));
			%>
		<%
		}
		%>
	</div>
</body>
</html>