<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>IT Tracker Login</title>
<script type="text/javascript">
function ValidationEvent() {
	var newPassword = document.getElementById("newPassword").value;
	var confPassword = document.getElementById("confPassword").value;
	
	var format = /[ !@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;
	
	if (newPassword == "" || confPassword == "" ||
			newPassword == null || confPassword == null ||
					newPassword != confPassword ||
							newPassword.length < 8 || confPassword.length < 8 ||
								format.test(newPassword)==false || format.test(confPassword)==false) {
		alert("New Password and Confirm Password not matched \nOR\nEntered Length of Password is Less than 8 char...!!!");
		return false;
	}  
}
</script>
</head>
<body> 

	<div style="float: left; width:50%;margin-left: 7%;">
	<br>
		<img style="height: 400px;" src="images/computer 1.jpg"></img>
		<h1 style="color: lime;" align="left"><img style="height: 50px; width: 400px;" src="images/RT.png"></img></h1>
	</div>
	<div style="float: right; width: 30%;margin-right: 7%">
		<%
  		if(request.getParameter("flagSet")!=null){
		%>
	  <script type="text/javascript">
	  alert("<%=request.getParameter("flagSet") %>");
	  </script>
		<%
		response.sendRedirect("index_feedbackUser.jsp"); 
		} 
  		if(request.getParameter("flagSet2")!=null){
		%>
	  <script type="text/javascript">
	  alert("<%=request.getParameter("flagSet2") %>");
	  </script>
		<%  
		}
		%>
		<form action="Reset_atLogin_Controller" method="post" onsubmit="return ValidationEvent()">
		<!-- <form action="#" method="post" onsubmit="return ValidationEvent()"> -->
		<input type="hidden" name="uid" id="uid" value="<%=request.getParameter("uid")%>">
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<table align="left" width="100%">
			<tr>
				<td align="left" colspan="2"><!-- <img src="images/LoginDetails.png"> --><h1 style="color : #0d2258">Password Reset Request for <%=request.getParameter("name") %></h1>
				<br>[ Must be greater than 8 Characters ] <br>[ Must Contains special Characters (@#$%) ]</td> 
			</tr>
			<!-- <tr>
				<td align="left"><img src="images/LoginName.png"><h1>User :</h1> </td>
				<td align="left"><input type="text" name="u_name" style="height: 30px;font-size: 22px;"> </td>
			</tr> -->
			<!-- <tr>
				<td align="left"><img src="images/Password.png"> </td>
				<td align="left"><strong style="color : #0d2258">Old Password : <input type="password" name="oldPassword" id="oldPassword"  style="height: 30px;font-size: 22px;width: 200px;"> </strong></td>
			</tr> -->
			<tr>
				<td align="left"><!-- <img src="images/Password.png"> --> </td>
				<td align="left"><strong style="color : #0d2258">New Password : <input type="password" name="newPassword" id="newPassword" style="height: 30px;font-size: 22px;width: 200px;"> </strong></td>
			</tr>
			<tr>
				<td align="left"><!-- <img src="images/Password.png"> --> </td>
				<td align="left"><strong style="color : #0d2258">Confirm New Password : <input type="password" name="confPassword" id="confPassword" style="height: 30px;font-size: 22px;width: 200px;"> </strong></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="Login" style="height: 40px;width:180px; font-size: 22px;"></td>
			</tr>		
		</table>
	</form>	
	</div>
</body>
</html>