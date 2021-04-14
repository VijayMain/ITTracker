<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Get My Issues</title>
</head>
<body>
<span id="new_dms">
   <%
   try{
	   Connection con = Connection_Utility.getConnection(); 
   %> 
   <div style="float: left;width: 100%">
			<table style="width: 100%;" class="tftable">
				<tr>
					<th colspan="8" align="center">Issue Material</th>
				</tr>
				<tr style="background-color: #acc8cc;">
					<td align="center" width="2%" style="padding: 3px;"><strong>S.No</strong></td>
					<td align="center"><strong>Subject / File Name</strong></td>
					<td align="center"><strong>Shared Rights</strong></td>
			        <td width="12%" align="center"><strong>Companies</strong></td>
				    <td width="15%" align="center"><strong>Departments</strong></td>
				    <td align="center"><strong>Document</strong></td>
				    <td align="center"><strong>Note</strong></td>
				    <td align="center"><strong>Add</strong></td>
				</tr> 
			</table> 
			</div>
	<%
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
</span>
</body>
</html>