<%@page import="beans.UserBeanRemote"%>
<%@page import="model.User"%>
<%@page import="beans.UserBean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Panel</title>
</head>
<body>
	<%
	UserBeanRemote user = (UserBeanRemote) request.getSession().getAttribute("user");
	if (user != null){
		User u = user.getMyUser();
		if (u != null){
			if (user.isAdmin()){
				String prazan = "";
				%>
				Admin username:
				<%
				out.print(u.getUsername());
				%>
				&nbsp;&nbsp;&nbsp;<a href="index.jsp">Pocetna strana</a>
				<form action="/PrisWEB/LogoutServlet" method="post">
					<input type="submit" value="Logout">
				</form>
				<br>
				Registracija novog predavaca: <br>
				<form action="/PrisWEB/AddPredavacServlet" method="post">
					Ime: <input type="text" name="ime" value="${ime != null ? ime : prazan}"><br>
					Prezime: <input type="text" name="prezime" value="${prezime != null ? prezime : prazan}"><br>
					Username: <input type="text" name="username" value="${username != null ? username : prazan}"><br>
					Password: <input type="password" name="password"><br>
					<input type="submit" value="Submit">
				</form><br>
				<c:forEach items="${greske}" var="greska">
					${greska}<br>
				</c:forEach>
				<%
				String poruka = (String)request.getAttribute("poruka");
				if (poruka != null)
					out.println(poruka);
				
				%>
				<br>
				<br>
				
				Unos novog kursa:<br>
				<form action="/PrisWEB/AddKursServlet" method="post">
					Naziv: <input type="text" name="naziv" value="${naziv != null ? naziv : prazan}" size="60"><br>
					Opis: <textarea rows="4" cols="60" name="opis" >${opis != null ? opis : prazan}</textarea><br>
					Ishod: <textarea rows="4" cols="60" name="ishod">${ishod != null ? ishod : prazan}</textarea><br>
					<input type="submit" value="Submit">
				</form><br>
				<c:forEach items="${greskeKurs}" var="greska">
					${greska}<br>
				</c:forEach>
				<%
				
				String porukaKurs = (String)request.getAttribute("porukaKurs");
				if (porukaKurs != null)
					out.println(porukaKurs);
			
			}else{
				%> 
				Niste ulogovani kao administrator.<br>
				<a href="index.jsp">Pocetna strana</a><br>
				<form action="/PrisWEB/LogoutServlet" method="post">
					<input type="submit" value="Logout">
				</form>
				<%
			}
		}else{
			%>
			Niste ulogovani. <a href="login.jsp">Login</a>
			<%
		}
	}else{
		%>
		Niste ulogovani. <a href="login.jsp">Login</a>
		<%
	}
	%>
</body>
</html>