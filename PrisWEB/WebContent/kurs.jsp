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
		<%
		UserBeanRemote user = (UserBeanRemote)request.getSession().getAttribute("user");
		Kurs kurs = (Kurs)request.getSession().getAttribute("kurs");
		boolean logged = false;
		if (user != null){
			logged = true;
		}
		%>
		<nav class="navbar navbar-default navbar-fixed-top">
			<div class="container-fluid">
				<div class="navbar-header">
			    	<a class="navbar-brand" href="index.jsp">Talk</a>
			    </div>
			    <ul class="nav navbar-nav">
			    	<li class="active"><a href="index.jsp">Home</a></li>
			    	<%
			    	if (!logged){
			    	%>
			    		<li><a href="login.jsp">Login</a></li>
			    		<li><a href="register.jsp">Register</a></li>
			    	<%
			    	}
			    	if (logged && user.isAdmin()){
		    		%>
		    			<li><a href="admin.jsp">Admin Panel</a></li>
		    		<%
			    	}
			    	%>
				</ul>
	    	</div>
		</nav>
		<div class="col-sm-12">
			<h2>Header</h2>
			<%
			if (logged){
				%>
				<form class="form-horizontal" action="/PrisWEB/LogoutServlet" method="post">
					<div class="form-group">
						<label class="col-sm-3">Dobrodosli <%=user.getMyUser().getUsername()%> .</label>
						<div class="col-sm-offset-0 col-sm-2">
							<input type="submit" class="btn btn-danger" value="Logout">
						</div>
					</div>
				</form><br>
				<%
			}
			if (kurs != null){
			%>
				<h2>${kurs.naziv}</h2><br>
				<h4>Opis</h4>
				<p>${kurs.opis}</p><br>
				<h4>Ocekivani ishod</h4>
				<p>${kurs.ishod}</p><br>
				
				<h2>Komentari</h2>
				
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
							<div class="form-group">
								<label class="col-sm-3" for="comm">Komentar: </label>
								<textarea rows="5" cols="40" class="form-control" id="comm" name="komentar"></textarea>
							</div>
							<input type="submit" class="btn btn-success" value="Submit">
						</form><br>
						<%
				}
				
				if (request.getAttribute("poruka") != null)
					out.println(request.getAttribute("poruka"));
			}
			%>
		</div>
	</div>
</body>
</html>