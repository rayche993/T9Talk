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
<title>Test</title>
</head>
<body>
<div class="container">
	<% 
	UserBeanRemote user = (UserBeanRemote)request.getSession().getAttribute("user");
	Kurs kurs = (Kurs)request.getSession().getAttribute("kurs");
	System.out.println("Opis:bez");
	Test test = (Test)request.getSession().getAttribute("test");
	System.out.println("Opis:"+test.getOpis()+"broj pitanja"+test.getPitanjes().size());
	
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
		<form action="ResenServlet" method="post" class="form-horizontal">
			<%
			Set<Pitanje> set = new HashSet<Pitanje>(test.getPitanjes()); 
			List<Pitanje> pitanja = new ArrayList<Pitanje>();
			pitanja.addAll(set);
			System.out.println("Stigo sam dovde"+pitanja.size());
			if(!pitanja.isEmpty()){
				for(Pitanje pitanje: pitanja){
				%>
					<p id="<%=pitanje.getPitanjeid()%>" ><h4><%=pitanje.getText()%></h4></p>
					<%
						List<Odgovor> odgovori = pitanje.getOdgovors();
						if(pitanje.getTipodgovora() == 3){
					%>
							<%
								for(Odgovor odgovor : odgovori){
							%>
								<input type="checkbox" name="<%=pitanje.getPitanjeid()%>" value="<%=odgovor.getOdgovorid() %>">&nbsp<%= odgovor.getText() %><br>
							<%
								}
							%>
							<%
						}else if(pitanje.getTipodgovora() == 1){
							%>
							<textarea name="<%=pitanje.getPitanjeid()%>" rows="4" cols="50"></textarea><br>
							<%
						}else{
							for(Odgovor odgovor : odgovori){
								%>
								<input type="radio" name="<%=pitanje.getPitanjeid()%>" value="<%=odgovor.getOdgovorid() %>" >&nbsp<%= odgovor.getText() %><br>
								<%
								}
						}
				}
			}else{
				%>
				Doslo je do greske!
				<%
			}
			System.out.println("kraj dokumenta");
			%>
			<br><br><input type="submit" class="btn btn-success" value="Predaj" name="<%=kurs.getKursid() %>">
		</form>
	</div>
</div>

</body>
</html>