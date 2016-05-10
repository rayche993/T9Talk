<%@page import="model.Kurs"%>
<%@page import="beans.UserBeanRemote"%>
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
			UserBeanRemote user = (UserBeanRemote) request.getSession().getAttribute("user");
			Kurs kurs = (Kurs) request.getSession().getAttribute("kurs");

			boolean logged = false;
			if (user != null) {
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
					if (!logged) {
				%>
				<li><a href="login.jsp">Login</a></li>
				<li><a href="register.jsp">Register</a></li>
				<%
					}
					if (logged) {
						if (user.isAdmin()) {
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
				if (kurs != null && logged) {
					if (user.isPredavac()) {
			%>
			<h2>Novi Test</h2>
			<script>
				var brPitanja = 0;
				
				var arrOdgovori = [];
				var arrOdgVise = [];
				var arrPitanjeType = [];
				
				var arrOdgTxtValues = [];
				var arrOdgTxtValuesVise = [];

				var arrOdgRadioValues = [];
				var arrOdgRadioValuesVise = [];
				
				function selektRadio(index){
					if (arrPitanjeType[index-1] == 2){
						fillArrOdgTxtValues(index);
						fillArrOdgRadioValues(index);
					}
					else if (arrPitanjeType[index-1] == 3){
						fillArrOdgTxtValuesVise(index);
						fillArrOdgRadioValuesVise(index);
					}
					
					if (document.getElementById('radio-1-pitanje-'+index).checked){
						document.getElementById('odgovori-'+index).innerHTML = "";
						arrPitanjeType[index - 1] = 1;
					}
					else if (document.getElementById('radio-2-pitanje-'+index).checked){
						document.getElementById('odgovori-'+index).innerHTML = '<div class="form-group">'
																					+'<div id="add-odg-btn-'+index+'" class="col-sm-offset-2">'
																						+'<input type="button" value="Dodaj odgovor" class="btn btn-info" onclick="addOdg('+index+')">'
																					+'</div>'
																				+'</div>';
						arrPitanjeType[index - 1] = 2;

						var i = index - 1;

						if (arrOdgTxtValues[index-1] == undefined){
							arrOdgTxtValues[index-1] = [];
						}

						if (arrOdgRadioValues[index-1] == undefined){
							arrOdgRadioValues[index-1] = [];
						}
						
						for (var j = 0; j<arrOdgovori[i]; j++){
							printOdg(j, index, false);
						}
					}
					else if (document.getElementById('radio-3-pitanje-'+index).checked){
						document.getElementById('odgovori-'+index).innerHTML = '<div class="form-group">'
																					+'<div id="add-odg-btn-'+index+'" class="col-sm-offset-2">'
																						+'<input type="button" value="Dodaj odgovor" class="btn btn-info" onclick="addOdgVise('+index+')">'
																					+'</div>'
																				+'</div>';
						arrPitanjeType[index - 1] = 3;

						var i = index - 1;

						if (arrOdgTxtValuesVise[index-1] == undefined){
							arrOdgTxtValuesVise[index-1] = [];
						}

						if (arrOdgRadioValuesVise[index-1] == undefined){
							arrOdgRadioValuesVise[index-1] = [];
						}
						
						for (var j = 0; j<arrOdgVise[i]; j++){
							printOdgVise(j, index, false);
						}
					}
				}

				function fillArrOdgTxtValues(index){
					for (var j = 0; j < arrOdgovori[index-1]; j++){
						arrOdgTxtValues[index-1][j] = document.getElementById('id-txt-odg-'+j+'-pitanje-'+index).value;
					}
				}

				function fillArrOdgTxtValuesVise(index){
					for (var j = 0; j < arrOdgVise[index-1]; j++){
						arrOdgTxtValuesVise[index-1][j] = document.getElementById('id-txt-odg-vise-'+j+'-pitanje-'+index).value;
					}
				}

				function fillArrOdgRadioValues(index){
					for (var j=0; j < arrOdgovori[index-1]; j++){
						arrOdgRadioValues[index-1][j] = document.getElementById('odg-'+j+'-radio-'+index).checked;
					}
				}

				function fillArrOdgRadioValuesVise(index){
					for (var j=0; j < arrOdgVise[index-1]; j++){
						arrOdgRadioValuesVise[index-1][j] = document.getElementById('odg-'+j+'-check-'+index).checked;
					}
				}
				
				function addOdgVise(index){
					fillArrOdgTxtValuesVise(index);
					fillArrOdgRadioValuesVise(index);
					var i = index - 1;
					arrOdgVise[i]++;

					printOdgVise(arrOdgVise[i] - 1, index, true);
				}

				function printOdgVise(j, index, novi){
					var value = "";
					var checked = "";
					if (!novi){
						if (arrOdgTxtValuesVise[index-1][j] != undefined){
							value = arrOdgTxtValuesVise[index-1][j];
						}
						if (arrOdgRadioValuesVise[index-1][j] != undefined){
							if (arrOdgRadioValuesVise[index-1][j])
								checked = "checked";
						}
					}
						
					var odgovor = '<div id="id-odg-vise-'+j+'-pitanje-'+index+'" class="form-group">'
										+'<div id="odg-group-vise-'+ j +'-pitanje-'+index+'" class="col-sm-offset-1 col-sm-7">'
											+'<input type="text" class="form-control" value="'+value+'" id="id-txt-odg-vise-'+j+'-pitanje-'+index+'" name="txt-odg-vise-'+j+'-pitanje-'+index+'">'
										+'</div>'
										+'<input type="checkbox" '+checked+' value="'+j+'" id="odg-'+j+'-check-'+index+'" name="odg-check-'+index+'">'
										+'<div class="col-sm-2" id="id-btn-odg-vise-'+j+'-pitanje-'+index+'">'
											+'<input type="button" value="X" class="btn btn-danger btn-md" onclick="removeOdgVise('+j+', '+index+')">'
										+'</div>'
									+'</div>';
					document.getElementById('odgovori-'+index).innerHTML += odgovor;
					
					if (novi){
						for (var i = 0; i < j; i++){
							var field = document.getElementById('id-txt-odg-vise-'+i+'-pitanje-'+index);
							field.value = arrOdgTxtValuesVise[index-1][i];

							var radio = document.getElementById('odg-'+i+'-check-'+index);
							radio.checked = arrOdgRadioValuesVise[index-1][i];
						}
					}
				}

				function removeOdgVise(j, index){
					var odgovor = document.getElementById('id-odg-vise-'+j+'-pitanje-'+index);
					odgovor.parentNode.removeChild(odgovor);

					for (var i = j+1; i<arrOdgVise; i++){
						var idOdg = document.getElementById('id-odg-vise-'+i+'-pitanje-'+index);
						var odgGroup = document.getElementById('odg-group-vise-'+i+'-pitanje-'+index);
						var odgTxt = document.getElementById('id-txt-odg-vise-'+i+'-pitanje-'+index);
						var odgRadio = document.getElementById('odg-'+i+'-check-'+index);
						var odgBtnGroup = document.getElementById('id-btn-odg-vise-'+i+'-pitanje-'+index);
						odgTxt.name = "txt-odg-vise-"+(i-1)+"-pitanje-"+index;
						odgTxt.id = "id-txt-odg-vise-"+(i-1)+"-pitanje-"+index;
						odgGroup.id = "odg-group-vise-"+(i-1)+"-pitanje-"+index;
						odgRadio.value = "" + (i-1);
						odgRadio.id = "odg-"+(i-1)+"-check-"+index;
						odgBtnGroup.innerHTML = '<input type="button" value="X" class="btn btn-danger btn-md" onclick="removeOdgVise('+(i-1)+', '+index+')">';
						odgBtnGroup.id = "id-btn-odg-vise-"+(i-1)+"-pitanje-"+index;
						idOdg.id = "id-odg-vise-"+(i-1)+'-pitanje-'+index;
					}

					if (arrOdgVise[index-1] > 0)
						arrOdgVise[index-1] = arrOdgVise[index-1] - 1;
				}
				
				function addOdg(index){
					fillArrOdgTxtValues(index);
					fillArrOdgRadioValues(index);
					var i = index - 1;
					arrOdgovori[i]++;

					printOdg(arrOdgovori[i] - 1, index, true);
				}

				function printOdg(j, index, novi){
					var value = "";
					var checked = "";
					
					if (!novi){
						if (arrOdgTxtValues[index-1][j] != undefined){
							value = arrOdgTxtValues[index-1][j] + "";
						}

						if (arrOdgRadioValues[index-1][j] != undefined){
							if (arrOdgRadioValues[index-1][j])
								checked = "checked";
						}
					}
					var odgovor = '<div class="form-group" id="id-odg-'+j+'-pitanje-'+index+'">'
										+'<div id="odg-group-'+ j +'-pitanje-'+index+'" class="col-sm-offset-1 col-sm-7">'
											+'<input type="text" class="form-control" value="'+value+'" id="id-txt-odg-'+j+'-pitanje-'+index+'" name="txt-odg-'+j+'-pitanje-'+index+'">'
										+'</div>'
										+'<input type="radio" value="'+j+'" '+checked+' id="odg-'+j+'-radio-'+index+'" name="odg-radio-'+index+'">'
										+'<div class="col-sm-2" id="id-btn-odg-'+j+'-pitanje-'+index+'">'
											+'<input type="button" value="X" class="btn btn-danger btn-md" onclick="removeOdg('+j+', '+index+')">'
										+'</div>'
									+'</div>';
					document.getElementById('odgovori-'+index).innerHTML += odgovor;

					if (novi){
						for (var i = 0; i < j; i++){
							var field = document.getElementById('id-txt-odg-'+i+'-pitanje-'+index);
							field.value = arrOdgTxtValues[index-1][i] + "";

							var radio = document.getElementById('odg-'+i+'-radio-'+index);
							radio.checked = arrOdgRadioValues[index-1][i];
						}
					}
				}

				function removeOdg(j, index){
					var odgovor = document.getElementById('id-odg-'+j+'-pitanje-'+index);
					odgovor.parentNode.removeChild(odgovor);

					for (var i = j+1; i<arrOdgovori[index-1]; i++){
						console.log(j + ' ' + i + ' ' + index + ' ' + arrOdgovori[index-1]);
						var idOdg = document.getElementById('id-odg-'+i+'-pitanje-'+index);
						var odgGroup = document.getElementById('odg-group-'+i+'-pitanje-'+index);
						var odgTxt = document.getElementById('id-txt-odg-'+i+'-pitanje-'+index);
						var odgRadio = document.getElementById('odg-'+i+'-radio-'+index);
						var odgBtnGroup = document.getElementById('id-btn-odg-'+i+'-pitanje-'+index);
						odgTxt.name = "txt-odg-"+(i-1)+"-pitanje-"+index;
						odgTxt.id = "id-txt-odg-"+(i-1)+"-pitanje-"+index;
						odgGroup.id = "odg-group-"+(i-1)+"-pitanje-"+index;
						odgRadio.value = "" + (i-1);
						odgRadio.id = "odg-"+(i-1)+"-radio-"+index;
						odgBtnGroup.innerHTML = '<input type="button" value="X" class="btn btn-danger btn-md" onclick="removeOdg('+(i-1)+', '+index+')">';
						odgBtnGroup.id = "id-btn-odg-"+(i-1)+"-pitanje-"+index;
						idOdg.id = "id-odg-"+(i-1)+'-pitanje-'+index;
					}

					if (arrOdgovori[index-1] > 0)
						arrOdgovori[index-1] = arrOdgovori[index-1] - 1;
				}
				
				function addPitanje() {
					arrPitanjeType[brPitanja] = 1; 
					arrOdgovori[brPitanja] = 1;
					arrOdgVise[brPitanja] = 1;
					
					brPitanja++;
					var nazivi = [];
					
					if (brPitanja > 1){
						for (var i = 1; i < brPitanja; i++){
							var elem = document.getElementById('tekst-'+i);
							nazivi[i-1] = elem.value;
							
							if (arrPitanjeType[i-1] == 2){
								fillArrOdgTxtValues(i);
								fillArrOdgRadioValues(i);
							}
							else if (arrPitanjeType[i-1] == 3){
								fillArrOdgTxtValuesVise(i);
								fillArrOdgRadioValuesVise(i);
							}
						}
					}
					
					var pitanje = '<div class="panel panel-default" id="pitanje-'+brPitanja+'"> '
										+'<div class="panel-heading" id="heading-'+brPitanja+'"> '
											+ 'Pitanje ' + brPitanja + ' '
											+ '<input type="button" class="btn btn-danger" onclick="removePitanje('+ brPitanja + ')" value="Obrisi"> '
										+'</div> '
										+'<div class="panel panel-body" id="body-'+brPitanja+'"> '
											+'<div id="pitanje-info-'+brPitanja+'" class="form-group"> '
												+'<label class="control-label col-sm-2" id="lbl-tekst-'+brPitanja+'" for="tekst-'+brPitanja+'">Tekst </label> '
												+'<div class="col-sm-6"> '
													+'<input type="text" class="form-control" name="tekst-'+brPitanja+'" id="tekst-'+brPitanja+'"> '
												+'</div> '
											+'</div> '
											+'<div class="form-group"> '
												+'<div id="radio-group-'+brPitanja+'" class="col-sm-offset-1">'
													+'<label class="radio-inline"><input type="radio" value="1" name="radio-pitanje-'+brPitanja+'" id="radio-1-pitanje-'+brPitanja+'" onclick="selektRadio('+brPitanja+')" checked>Tekstualni odgovor</label>'
													+'<label class="radio-inline"><input type="radio" value="2" name="radio-pitanje-'+brPitanja+'" id="radio-2-pitanje-'+brPitanja+'" onclick="selektRadio('+brPitanja+')">Izbor odgovor jedan</label>'
													+'<label class="radio-inline"><input type="radio" value="3" name="radio-pitanje-'+brPitanja+'" id="radio-3-pitanje-'+brPitanja+'" onclick="selektRadio('+brPitanja+')">Izbor odgovor vise</label>'
												+'</div>'
											+'</div> '
											+'<div class="form-group"> '
												+'<span id="odgovori-'+brPitanja+'"></span>'
											+'</div>'
										+'</div> '
									+'</div>';
					document.getElementById('pitanja').innerHTML += pitanje;

					if (brPitanja > 1){
						for (var i = 1; i < brPitanja; i++){
							var naziv = document.getElementById('tekst-' + i);
							naziv.value = nazivi[i-1];
							
							if (arrPitanjeType[i-1] == 1){
								var radio = document.getElementById('radio-1-pitanje-' + i);
								radio.checked = true;
							}
							else if (arrPitanjeType[i-1] == 2){
								for (var j = 0; j < arrOdgTxtValues[i-1].length; j++){
									var ponudjen = document.getElementById('id-txt-odg-' + j + '-pitanje-' + i);
									ponudjen.value = arrOdgTxtValues[i-1][j];
								}

								for (var j = 0; j < arrOdgRadioValues[i-1].length; j++){
									var rad = document.getElementById('odg-'+j+'-radio-'+i);
									rad.checked = arrOdgRadioValues[i-1][j];
								}
								
								var radio = document.getElementById('radio-2-pitanje-' + i);
								radio.checked = true;
							}else if (arrPitanjeType[i-1] == 3){
								for (var j = 0; j < arrOdgTxtValuesVise[i-1].length; j++){
									var ponudjen = document.getElementById('id-txt-odg-vise-' + j + '-pitanje-' + i);
									ponudjen.value = arrOdgTxtValuesVise[i-1][j];
								}

								for (var j = 0; j < arrOdgRadioValuesVise[i-1].length; j++){
									var rad = document.getElementById('odg-'+j+'-check-'+i);
									rad.checked = arrOdgRadioValuesVise[i-1][j];
								}
								
								var radio = document.getElementById('radio-3-pitanje-' + i);
								radio.checked = true;
							}
						}
					}
				}

				function makeInfo(){
					var info = document.getElementById('info');
					info.innerHTML += '<input type="hidden" value="'+brPitanja+'" name="broj_pitanja"/>';

					var answers = "";
					for (var i=1; i<=brPitanja; i++){
						if (arrPitanjeType[i-1] == 1)
							answers += "0 ";
						else if (arrPitanjeType[i-1] == 2)
							answers += arrOdgovori[i-1] + " ";
						else if (arrPitanjeType[i-1] == 3)
							answers += arrOdgVise[i-1] + " ";
					}

					info.innerHTML += '<input type="hidden" value="'+answers+'" name="odgovori"/>';
				}
				
				function removePitanje(index) {
					console.log(arrPitanjeType);
					arrOdgovori.splice(index-1, 1);
					arrOdgVise.splice(index-1, 1);
					arrPitanjeType.splice(index-1, 1);
					
					var pitanje = document.getElementById('pitanje-' + index);
					pitanje.parentNode.removeChild(pitanje);

					for (var i = index + 1; i <= brPitanja; i++) {
						console.log('hehe');
						var elem = document.getElementById('pitanje-' + i);
						elem.id = "pitanje-" + (i - 1);

						console.log('hehe');
						elem = document.getElementById('heading-' + i);
						elem.id = "heading-" + (i - 1);
						elem.innerHTML = 'Pitanje '
								+ (i - 1)
								+ ' <input type="button" class="btn btn-danger" onclick="removePitanje('
								+ (i - 1) + ')" value="Obrisi">';
								
						elem = document.getElementById('body-' + i);
						elem.id = "body-" + (i - 1);

						console.log('hehe');
						elem = document.getElementById('pitanje-info-' + i);
						var txt = document.getElementById('tekst-'+i).value;
						elem.innerHTML = '<label class="control-label col-sm-2" id="lbl-tekst-'+(i-1)+'" for="tekst-'+(i-1)+'">Tekst </label> '
										+'<div class="col-sm-6"> '
											+'<input type="text" class="form-control" value="'+txt+'" name="tekst-'+(i-1)+'" id="tekst-'+(i-1)+'"> '
										+'</div> ';
						elem.id = "pitanje-info-" + (i - 1);

						console.log('hehe');
						elem = document.getElementById('radio-group-' + i);
						var check1 = "";
						var check2 = "";
						var check3 = "";
						if (document.getElementById('radio-1-pitanje-'+i).checked)
							check1 = "checked";
						else if (document.getElementById('radio-2-pitanje-'+i).checked)
							check2 = "checked";
						else if (document.getElementById('radio-3-pitanje-'+i).checked)
							check3 = "checked";
						
						console.log(check1 + " " + check2 + " " + check3 + " ");
						elem.innerHTML = '<label class="radio-inline">'
											+'<input type="radio" name="radio-pitanje-'+(i-1)+'" '+check1+' value="1" id="radio-1-pitanje-'+(i-1)+'" onclick="selektRadio('+(i-1)+')">Tekstualni odgovor</label>'
										+'<label class="radio-inline">'
											+'<input type="radio" name="radio-pitanje-'+(i-1)+'" '+check2+' value="2" id="radio-2-pitanje-'+(i-1)+'" onclick="selektRadio('+(i-1)+')">Izbor odgovor jedan</label>'
										+'<label class="radio-inline">'
											+'<input type="radio" name="radio-pitanje-'+(i-1)+'" '+check3+' value="3" id="radio-3-pitanje-'+(i-1)+'" onclick="selektRadio('+(i-1)+')">Izbor odgovor vise</label>';	
						elem.id = "radio-group-" + (i - 1);

						console.log('hehe');
						elem = document.getElementById('odgovori-' + i);
						elem.id = "odgovori-" + (i - 1);

						console.log('hehe');
						console.log(arrPitanjeType);
						if (arrPitanjeType[i-2] > 1){
							console.log("usao");
							elem = document.getElementById('add-odg-btn-' + i);
							elem.innerHTML = '<input type="button" value="Dodaj odgovor" class="btn btn-info" onclick="addOdg('+(i-1)+')">';
							elem.id = "add-odg-btn-" + (i-1);
						}

						console.log('hehe');
						if (arrPitanjeType[i-2] == 2){
							for (var j = 0; j<arrOdgovori[i-2]; j++){
								console.log(j + ' ' + i);
								var idOdg = document.getElementById('id-odg-'+j+'-pitanje-'+i);
								elem = document.getElementById('odg-group-'+ j +'-pitanje-' + i);
								var txtOdg = document.getElementById('id-txt-odg-'+j+'-pitanje-'+i).value;
								elem.innerHTML = '<input type="text" class="form-control" value="'+txtOdg+'" id="id-txt-odg-'+j+'-pitanje-'+(i-1)+'" name="txt-odg-'+j+'-pitanje-'+(i-1)+'">';
								elem.id = 'odg-group-'+ j +'-pitanje-' + (i - 1);
	
								elem = document.getElementById('odg-'+ j +'-radio-' + i);
								var selected = elem.checked;
								elem.name = "odg-radio-" + (i - 1);
								elem.value = "" + j;
								elem.id = "odg-" + j + "-radio-" + (i - 1);
								elem = document.getElementById("odg-" + j + "-radio-" + (i - 1));
								elem.checked = selected;

								elem = document.getElementById('id-btn-odg-'+j+'-pitanje-'+i);
								elem.innerHTML = '<input type="button" value="X" class="btn btn-danger btn-md" onclick="removeOdg('+j+', '+(i-1)+')">';
								elem.id = "id-btn-odg-"+j+"-pitanje-"+(i-1);
								idOdg.id = "id-odg-"+j+"-pitanje-"+(i-1);
							}
						}
						else if (arrPitanjeType[i-2] == 3){
							for (var j=0; j<arrOdgVise[i-2]; j++){
								console.log(j + ' ' + i);
								elem = document.getElementById('odg-group-vise-'+ j +'-pitanje-' + i);
								var txtOdg = document.getElementById('id-txt-odg-vise-'+j+'-pitanje-'+i).value;
								elem.innerHTML = '<input type="text" class="form-control" value="'+txtOdg+'" id="id-txt-odg-vise-'+j+'-pitanje-'+(i-1)+'" name="txt-odg-vise-'+j+'-pitanje-'+(i-1)+'">';
								elem.id = 'odg-group-vise-'+ j +'-pitanje-' + (i - 1);
	
								elem = document.getElementById('odg-'+ j +'-check-' + i);
								var selected = elem.checked;
								elem.name = "odg-check-" + (i - 1);
								elem.value = "" + j;
								elem.id = "odg-" + j + "-check-" + (i - 1);
								document.getElementById("odg-" + j + "-check-" + (i - 1)).checked = selected;

								var idOdg = document.getElementById('id-odg-vise-'+j+'-pitanje-'+i);
								elem = document.getElementById('id-btn-odg-vise-'+j+'-pitanje-'+i);
								elem.innerHTML = '<input type="button" value="X" class="btn btn-danger btn-md" onclick="removeOdgVise('+j+', '+(i-1)+')">';
								elem.id = "id-btn-odg-vise-"+j+"-pitanje-"+(i-1);
								idOdg.id = "id-odg-vise-"+j+"-pitanje-"+(i-1);
							}
						}
					}
					brPitanja--;
				}
			</script>
			<form class="form-horizontal" action="/PrisWEB/AddTestServlet"
				method="post">
				<div class="form-group">
					<label class="control-label col-sm-2" for="naslov">Naslov </label>
					<div class="col-sm-6">
						<input type="text" class="form-control" id="naslov" name="naslov">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="opis">Opis </label>
					<div class="col-sm-6">
						<input type="text" class="form-control" id="opis" name="opis">
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-6">
						<div class="panel panel-info">
							<div class="panel-heading">
								<label>Pitanja</label> <input type="button"
									class="btn btn-default" onclick="addPitanje()" value="Dodaj">
							</div>
							<div class="panel-body">
								<span id="pitanja"></span>
								<span id="info"></span>
							</div>
						</div>
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<input type="submit" class="btn btn-success" onclick="makeInfo()" value="Sacuvaj">
					</div>
				</div>
			</form>
			<%
				} else {
			%>Doslo je do greske!<%
				}
				} else {
			%>Doslo je do greske!<%
				}
			%>
		</div>
	</div>
</body>
</html>