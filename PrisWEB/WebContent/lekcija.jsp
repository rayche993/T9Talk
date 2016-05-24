<%@page import="model.Lekcija"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
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
<title>Lekcija</title>
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
		    	<li><a href="nastavnici-lista.jsp">Nastavnici</a></li>
		    	<%
		    	if (!logged){
		    	%>
		    		<li><a href="login.jsp">Login</a></li>
		    		<li><a href="register.jsp">Register</a></li>
		    	<%
		    	}
		    	if (logged){
		    		if (user.isPredavac()){
		    			%>
				    	<li><a href="test.jsp">Novi Test</a></li>
				    	<%
				    }
		    		if (user.isAdmin()){
		    			%>
		    			<li><a href="admin.jsp">Admin Panel</a></li>
		    			<%
		    		}
		    	}
		    	%>
			</ul>
    	</div>
	</nav>
	<div class="col-sm-12">
		<h2>Header</h2>
		<%
		if (kurs != null && logged){
			Lekcija lekcija = (Lekcija)request.getAttribute("lekcija");
			request.getSession().setAttribute("lekcija", lekcija);
		%>
		
			<!-- Naziv kursa i dugme koje vraca nazad na kurs -->
			<form action="/PrisWEB/KursServlet" method="post" class="form-horizontal">
				<div class="form-group">
				<h3>Kurs <%=kurs.getNaziv() %>
					<input type="submit" class="btn btn-info btn-lg" name="<%=kurs.getKursid() %>" value="Prikazi">
				</h3>
				</div>
			</form>
			
			<form action="/PrisWEB/KursServlet" method="get" class="form-horizontal">
				<div class="form-group">
					<h2>Lekcija <%=lekcija.getNaziv() %></h2>
				</div>
				<div class="form-group">
					<%= lekcija.getText() %>
				</div>
			</form>
			<%
		}else{
			%>
			Doslo je do greske!
			<%
		}
		%>
	</div>
</div>
</body>
</html>