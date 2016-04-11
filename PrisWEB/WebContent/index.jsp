<%@page import="javax.naming.NamingException"%>
<%@page import="beans.KursBeanLocal"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="model.Kurs"%>
<%@page import="java.util.List"%>
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
<title>Talk - skola stranih jezika</title>
</head>
<body>
	<div class="container">
		<%
		List<Kurs> courses = (List<Kurs>)request.getAttribute("kursevi");
		if (courses == null){
			InitialContext ic = null;
			KursBeanLocal kursBean = null;
			try {
				ic = new InitialContext();
				kursBean = (KursBeanLocal) ic.lookup("java:global/PrisEAR/PrisEJB/KursBean!beans.KursBeanLocal");
				courses = kursBean.getKursevi();
			} catch (NamingException e) {
				e.printStackTrace();
			}
		}
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
		%>
		<h2>Kursevi</h2><br>
		<form class="form-horizontal" action="/PrisWEB/PretragaServlet" method="post">
			<div class="form-group">
				<div class="col-sm-11">
					<input type="text" class="form-control" width="40" name="pretraga">
				</div>
				<input type="submit" class="col-sm-1" value="Pretrazi">
			</div>
		</form>
		<form action="/PrisWEB/KursServlet" method="post">
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th>Naziv</th>
						<th>Prikaz</th>
						<th>Prijava</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="<%=courses%>" var="kurs">
						<tr>
							<td><c:out value="${kurs.naziv}" /></td>
							<td><input type="submit" name="${kurs.kursid}" value="Prikazi" /></td>
							<td><input type="submit" value="Prijavi se" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>