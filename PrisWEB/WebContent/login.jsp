<%@page import="model.Kurs"%>
<%@page import="beans.UserBeanRemote"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
	<div class="container">
		<%
		UserBeanRemote user = (UserBeanRemote)request.getSession().getAttribute("user");
		Kurs kurs = (Kurs) request.getSession().getAttribute("kurs");
		if (kurs != null)
			request.getSession().removeAttribute("kurs");
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
			    	<li class="active"><a href="login.jsp">Login</a></li>
			    	<%
			    	if (!logged){
			    	%>
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
		}else{
			%>
			<h2>Login</h2>
			<form class="form-horizontal" action="/PrisWEB/LoginServlet" method="post">
				<div class="form-group">
					<label class="control-label col-sm-2" for="username">Username </label>
					<div class="col-sm-5">
						<input type="text" name="username" class="form-control" id="username">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="pwd">Password </label>
					<div class="col-sm-5">
						<input type="password" name="password" class="form-control" id="pwd">
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<input type="submit" class="btn btn-success" value="Submit">
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