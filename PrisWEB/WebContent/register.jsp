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
<title>Register</title>
</head>
<body>
	<div class="container">
		<%
		UserBeanRemote user = (UserBeanRemote)request.getSession().getAttribute("user");
		Kurs kurs = (Kurs) request.getSession().getAttribute("kurs");
		if (kurs != null)
			request.getSession().removeAttribute("kurs");
		String prazan = "";
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
			    	<li><a href="index.jsp">Home</a></li>
			    	<li><a href="nastavnici-lista.jsp">Nastavnici</a></li>
			    	<%
			    	if (!logged){
			    	%>
			    		<li><a href="login.jsp">Login</a></li>
			    		<li class="active"><a href="register.jsp">Register</a></li>
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
			if (!logged){
				%>
				<h2>Registracija polaznika</h2>
				<form class="form-horizontal" action="/PrisWEB/AddPolaznikServlet" method="post">
					<div class="form-group">
						<label for="ime" class="control-label col-sm-2">Ime </label>
						<div class="col-sm-5">
							<input type="text" name="ime" value="${ime != null ? ime : prazan}" id="ime" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label for="prezime" class="control-label col-sm-2">Prezime </label>
						<div class="col-sm-5">
							<input type="text" name="prezime" value="${prezime != null ? prezime : prazan}" id="prezime" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label for="username" class="control-label col-sm-2">Username </label>
						<div class="col-sm-5">
							<input type="text" name="username" value="${username != null ? username : prazan}" id="username" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label for="password" class="control-label col-sm-2">Password </label>
						<div class="col-sm-5">
							<input type="password" name="password" id="password" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" class="btn btn-success" value="Submit">
						</div>
					</div>
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
				<h2>Vec ste ulogovani</h2>
				<form class="form-horizontal" action="/PrisWEB/LogoutServlet" method="post">
					<div class="form-group">
						<label class="control-label col-sm-2">Ulogovani ste kao <%=user.getMyUser().getUsername()%> .</label>
						<div class="col-sm-2">
							<input type="submit" class="btn btn-danger" value="Logout">
						</div>
					</div>
				</form>
				<%
			}
			%>
		</div>
	</div>
</body>
</html>