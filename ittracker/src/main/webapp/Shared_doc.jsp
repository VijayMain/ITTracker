<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Get My Docs</title>
</head>
<body>
<span id="new_dms">
   <form action="Add_NewDoc" method="post" onSubmit="return validateForm();">
			<table style="width: 100%;" class="tftable">
				<tr>
					<th colspan="7" align="center">FOLDER NAME</th>
				</tr>
				<tr>
					<td width="23%" align="center"><strong>Subject / File Name</strong></td>
					<td width="4%" align="center"><strong>Shared </strong></td>
			      <td width="12%" align="center"><strong>Companies</strong></td>
				    <td width="15%" align="center"><strong>Departments</strong></td>
				    <td width="18%" align="center"><strong>Documents</strong></td>
				    <td width="18%" align="center"><strong>Note</strong></td>
				    <td width="10%" align="center"><strong>Add / Edit / Delete</strong></td>
				</tr>
				<tr>
				  <td align="left">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				  <td align="left">&nbsp;</td>
				  <td align="center">
				  	<img src="images/Add.png" style="height: 17px;cursor: pointer;" title="Add">
					<img src="images/edit.png" style="height: 17px;cursor: pointer;" title="Edit"> 
					<img src="images/delete.png" style="height: 17px;cursor: pointer;" title="Delete"> 
				  </td>
			  </tr>
			</table>
		</form>
</span>
</body>
</html>