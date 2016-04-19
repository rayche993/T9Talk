<%@page import="model.Ocena"%>
<%@page import="model.User"%>
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
<link rel="stylesheet" href="starrating/jquery.rating.css">
<script src="starrating/jquery.js"></script>
<script src="starrating/jquery.rating.js"></script>
<script src="starrating/jquery.MetaData.js"></script>
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
		KursBeanLocal kursBean = null;
		Kurs ku = (Kurs) request.getSession().getAttribute("kurs");
		if (ku != null)
			request.getSession().removeAttribute("kurs");
		InitialContext ic = null;
		try {
			ic = new InitialContext();
			kursBean = (KursBeanLocal) ic.lookup("java:global/PrisEAR/PrisEJB/KursBean!beans.KursBeanLocal");
		} catch (NamingException e) {
			e.printStackTrace();
		}
		if (courses == null && kursBean != null){
			courses = kursBean.getKursevi();
		}
		boolean logged = false;
		%>
		<nav class="navbar navbar-default navbar-fixed-top">
		  <div class="container-fluid">
		    <div class="navbar-header">
		      <a class="navbar-brand" href="index.jsp">Talk</a>
		    </div>
		    <ul class="nav navbar-nav">
		      <li class="active"><a href="index.jsp">Home</a></li>
		<%
		UserBeanRemote user = (UserBeanRemote)request.getSession().getAttribute("user");
		if (user == null){
			%>
		      <li><a href="login.jsp">Login</a></li>
		      <li><a href="register.jsp">Register</a></li>
			<%
		}else{
			logged = true;
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
		%>
		<h2>Kursevi</h2><br>
		<%
		String prijava = (String)request.getAttribute("prijava");
		if (prijava != null)
			out.println(prijava);
		 %>
		<form class="form-horizontal" action="/PrisWEB/PretragaServlet" method="post">
			<div class="form-group">
				<div class="col-sm-2">
					<select name="parametar" class="form-control">
						<option selected="<%=true%>" value="Naziv">Naziv</option>
						<option value="Opis">Opis</option>
						<option value="Ishod">Ishod</option>
					</select>
				</div>
				<div class="col-sm-9">
					<input type="text" class="form-control" width="40" name="pretraga">
				</div>
				<div class="col-sm-1">
					<input type="submit" class="btn btn-default" value="Pretrazi">
				</div>
			</div>
		</form>
		<form action="/PrisWEB/KursServlet" method="post">
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th>Naziv</th>
						<th>Ocena</th>
						<th>Prikaz</th>
						<th>Prijava</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Kurs kurs : courses){
						boolean disabled = false;
						String nazivK = kurs.getNaziv();
						int idK = kurs.getKursid();
						%>
						<tr>
							<td><%=nazivK %></td>
							<%
							if (logged && user.isPolaznik()){
								User myUser = user.getMyUser();
								if (myUser != null){
									for (Kurs k : myUser.getKurs4()){
										if (k.getKursid() == kurs.getKursid()){
											disabled = true;
											break;
										}
									}
								}
							}else{
								disabled = true;
							}
							float sum = 0;
							float avg = 0;
							List<Ocena> ocene = kursBean.getOcene(kurs);
							for (Ocena o : ocene){
								sum += Float.parseFloat(o.getOpis());
							}
							int size = ocene.size();
							if (size > 0)
								avg = sum / size;
							else
								avg = 0;
							
							String[] arr = new String[20];
							int j = 0;
							for (int i = j; i<arr.length; i++){
								if (avg >= ((i+1) * 0.25) - 0.125 && avg < ((i+1)*0.25) + 0.125){
									arr[i] = "checked";
									j = i + 1;
									break;
								}else
									arr[i] = new String("");
							}
							
							while (j < arr.length){
								arr[j] = new String("");
								j++;
							}
							String dis = disabled ? "disabled" : "";
							String starDis = "disabled";
							%>
							<td>
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
							</td>
							<td><input type="submit" class="btn btn-info" name="<%=idK %>" value="Prikazi" /></td>
							<td><input type="submit" <%=dis %> class="btn btn-success" name="<%=idK %>" value="Prijavi se" /></td>
						</tr>
						<%
					}
					%>
				</tbody>
			</table>
		</form>
		</div>
	</div>
</body>
</html>