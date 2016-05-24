<%@page import="model.User"%>
<%@page import="beans.TestBeanLocal"%>
<%@page import="beans.KursBeanLocal"%>
<%@page import="model.Uradio"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="model.Test"%>
<%@page import="model.Odgovor"%>
<%@page import="model.Pitanje"%>
<%@page import="model.Kurs"%>
<%@page import="java.util.List"%>
<%@page import="beans.UserBeanRemote"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Lista uradjenih</title>
</head>
<body>
<div class="container">
	<% 
	UserBeanRemote user = (UserBeanRemote)request.getSession().getAttribute("user");
	KursBeanLocal kursBean = null;
	InitialContext ic = null;
	List<User> predavaci = null;
	
	try {
		ic = new InitialContext();
		kursBean = (KursBeanLocal) ic.lookup("java:global/PrisEAR/PrisEJB/KursBean!beans.KursBeanLocal");
	} catch (NamingException e) {
		e.printStackTrace();
	}
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
			<form action="/PrisWEB/StartTestServlet" method="post">
			<table class="table table-hover table-bordered">
						<thead>
							<tr>
								<th>Ime i prezime</th>
								<th>Predaje</th>
							</tr>
						</thead>
						<tbody>
							<%	
								Set<User> set = new HashSet<User>(kursBean.getPredavaci()); 
								predavaci = new ArrayList<User>();
								predavaci.addAll(set);
								if(!predavaci.isEmpty()){
									for(User predavac: predavaci){
										%>
										<tr>
											<td><%=predavac.getIme()%>&nbsp<%=predavac.getPrezime()%></td>
											<td>
											<%
											List<Kurs> kursevi = kursBean.getKurseviPredaje(predavac);
											if(!kursevi.isEmpty()){
												for(Kurs k : kursevi){
											%>
													<%=k.getNaziv()%>&nbsp
											<%	
												}
											}
											%>
											</td>
										</tr>
										<%
									}
								}
							%>
						</tbody>
			</form>
	</div>
</div>
</body>
</html>