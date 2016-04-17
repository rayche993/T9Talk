<%@page import="model.Ocena"%>
<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="beans.KursBeanLocal"%>
<%@page import="model.Kurs"%>
<%@page import="beans.UserBeanRemote"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="starrating/jquery.rating.css">
<script src="starrating/jquery.js"></script>
<script src="starrating/jquery.rating.js"></script>
<script src="starrating/jquery.MetaData.js"></script>
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
		KursBeanLocal kursBean = null;
		InitialContext ic = null;
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
				String starDis = (String) request.getAttribute("starDis");
				String disSub = (String) request.getAttribute("disSub");
				String[] arr = (String[]) request.getAttribute("arr");
			%>
				
				<form action="/PrisWEB/KursServlet" method="post" class="form-inline">
					<div class="form-group">
						<h2>${kurs.naziv}</h2>
						<input name="star2" type="radio" value="0.25" class="star {split:4}" <%=starDis %> <%=arr[0] %> />
						<input name="star2" type="radio" value="0.5" class="star {split:4}" <%=starDis %> <%=arr[1] %> />
						<input name="star2" type="radio" value="0.75" class="star {split:4}" <%=starDis %> <%=arr[2] %> />
						<input name="star2" type="radio" value="1" class="star {split:4}" <%=starDis %> <%=arr[3] %> />
						<input name="star2" type="radio" value="1.25" class="star {split:4}" <%=starDis %> <%=arr[4] %> />
						<input name="star2" type="radio" value="1.5" class="star {split:4}" <%=starDis %> <%=arr[5] %> />
						<input name="star2" type="radio" value="1.75" class="star {split:4}" <%=starDis %> <%=arr[6] %> />
						<input name="star2" type="radio" value="2" class="star {split:4}" <%=starDis %> <%=arr[7] %> />
						<input name="star2" type="radio" value="2.25" class="star {split:4}" <%=starDis %> <%=arr[8] %> />
						<input name="star2" type="radio" value="2.5" class="star {split:4}" <%=starDis %> <%=arr[9] %> />
						<input name="star2" type="radio" value="2.75" class="star {split:4}" <%=starDis %> <%=arr[10] %> />
						<input name="star2" type="radio" value="3" class="star {split:4}" <%=starDis %> <%=arr[11] %> />
						<input name="star2" type="radio" value="3.25" class="star {split:4}" <%=starDis %> <%=arr[12] %> />
						<input name="star2" type="radio" value="3.5" class="star {split:4}" <%=starDis %> <%=arr[13] %> />
						<input name="star2" type="radio" value="3.75" class="star {split:4}" <%=starDis %> <%=arr[14] %> />
						<input name="star2" type="radio" value="4" class="star {split:4}" <%=starDis %> <%=arr[15] %> />
						<input name="star2" type="radio" value="4.25" class="star {split:4}" <%=starDis %> <%=arr[16] %> />
						<input name="star2" type="radio" value="4.5" class="star {split:4}" <%=starDis %> <%=arr[17] %> />
						<input name="star2" type="radio" value="4.75" class="star {split:4}" <%=starDis %> <%=arr[18] %> />
						<input name="star2" type="radio" value="5" class="star {split:4}" <%=starDis %> <%=arr[19] %> />
						&nbsp;&nbsp;
						<input type="submit" class="btn btn-success" <%=starDis %> name="glasaj" value="Glasaj">
					</div>
				</form>
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