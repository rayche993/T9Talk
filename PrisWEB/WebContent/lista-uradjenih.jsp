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
	Kurs kurs = (Kurs)request.getSession().getAttribute("kurs");
	System.out.println("Opis:bez");
	Test test = (Test)request.getSession().getAttribute("test");
	System.out.println("Opis:"+test.getOpis()+"broj pitanja"+test.getPitanjes().size());
	
	TestBeanLocal testBean = null;
	List<Uradio> uradjeni = null;
	InitialContext ic = null;
	
	try {
		ic = new InitialContext();
		testBean = (TestBeanLocal) ic.lookup("java:global/PrisEAR/PrisEJB/TestBean!beans.TestBeanLocal");
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
								<th>Test</th>
								<th>User</th>
								<th>Bodovi</th>
								<th>Pregledaj</th>
							</tr>
						</thead>
						<tbody>
							<%
							uradjeni = testBean.uradioZaTest(test);
							if(uradjeni != null){
								for (Uradio uradjen : uradjeni){
							%>
							<tr>
								<td><%=test.getNaslov()%></td>
								<td><%=uradjen.getUser().getUsername()%></td>
								<td><%=testBean.getBodovi(uradjen.getUser(), test)%></td>
								<td><input type="submit" class="btn btn-success" value="Pogledaj" name="<%=uradjen.getUradioid() %>"></td>
							</tr>
							<% 
								}
							}
							%>
						</tbody>
					</table>
	</div>
</div>
</body>
</html>