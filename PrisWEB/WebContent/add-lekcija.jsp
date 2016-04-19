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
<script src='//cdn.tinymce.com/4/tinymce.min.js'></script>
<script>
tinymce.init({
	selector : '#editor',
	height: 300,
	theme: 'modern',
	plugins: [
	          'advlist autolink lists link image charmap print preview hr anchor pagebreak',
	          'searchreplace wordcount visualblocks visualchars code',
	          'insertdatetime media nonbreaking save table contextmenu directionality',
	          'emoticons template paste textcolor colorpicker textpattern imagetools'
	        ],
    toolbar1: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image media',
    toolbar2: 'print preview | forecolor backcolor emoticons',
    image_advtab: true,
    content_css: [
                  '//fast.fonts.net/cssapi/e6dc9b99-64fe-4292-ad98-6974f93cd2a2.css',
                  '//www.tinymce.com/css/codepen.min.css'
                ]
});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Lekcija - Predavac</title>
</head>
<body>
<div class="container">
	<%
	UserBeanRemote user = (UserBeanRemote)request.getSession().getAttribute("user");
	Kurs kurs = (Kurs)request.getSession().getAttribute("kurs");
	InitialContext ic = null;
	try {
		ic = new InitialContext();
		//kursBean = (KursBeanLocal) ic.lookup("java:global/PrisEAR/PrisEJB/KursBean!beans.KursBeanLocal");
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
		if (kurs != null && logged){
			if (user.isPredavac()){
				String prazan = "";
				Lekcija lekcija = (Lekcija)request.getAttribute("lekcija");
				int def = -1;
		%>
		<form action="/PrisWEB/KursServlet" method="post" class="form-horizontal">
			<div class="form-group">
			<h3>Kurs <%=kurs.getNaziv() %>
				<input type="submit" class="btn btn-info btn-lg" name="<%=kurs.getKursid() %>" value="Prikazi">
			</h3>
			</div>
		</form>
		
		<form action="/PrisWEB/KursServlet" method="get" class="form-horizontal">
			<div class="form-group">
				<h2>Lekcija</h2>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="naziv">Naziv </label>
				<div class="col-sm-7">
					<input type="text" name="naziv" class="form-control" id="naziv" value="${naziv != null ? naziv : prazan}">
				</div>
			</div>
			<div class="form-group">
				<textarea name="tekst" id="editor">${text != null ? text : prazan}</textarea>
			</div>
			<div class="form-group">
				<div class="pull-right">
					<input type="submit" value="Sacuvaj" name="${id != null ? id : def }" class="btn btn-success">
				</div>
			</div>
		</form>
		<%
			}
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