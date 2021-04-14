<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>IT Tracker Login</title>
</head>
<body> 

	<div style="float: left; width:50%;margin-left: 7%;">
	<br>
		<img style="height: 400px;" src="images/computer 1.jpg"></img>
		<h1 style="color: lime;" align="left"><img style="height: 50px; width: 400px;" src="images/RT.png"></img></h1>
	</div>
	
	<div style="float: right; width: 30%;margin-right: 7%">
		<form action="Login_Controller" method="post">
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<table align="center" width="100%">
			<tr>
				<td align="left" colspan="2"><img src="images/LoginDetails.png"> </td> 
			</tr>
				<tr>
					<td align="left"><img src="images/LoginName.png"></td>
					<td align="left"><input type="text" name="u_name" style="height: 30px;font-size: 22px;"> </td>
				</tr>
				<tr>
					<td align="left"><img src="images/Password.png"></td>
					<td align="left"><input type="password" name="u_pwd" style="height: 30px;font-size: 22px;"> 
					</td>
				</tr>
				<tr>
					<td colspan="2"><label style="color: red;"> Please check your login details !!!</label></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="Login" style="height: 40px;width:180px; font-size: 22px;"></td>
				</tr>

			</table>
	</form>	
	
	</div>
</body>
</html>