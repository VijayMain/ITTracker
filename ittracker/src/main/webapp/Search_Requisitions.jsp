<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Requisition</title>
<link rel="stylesheet" type="text/css" href="styles.css" />

<script language="javascript" type="text/javascript">
	function showState(str) {
		var xmlhttp;

		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var a = null;
				document.getElementById("req_type").innerHTML = xmlhttp.responseText;
				//document.getElementById("approvers").innerHTML = xmlhttp.responseText;

			}
		};
		xmlhttp.open("POST", "Req_Type.jsp?q=" + str, true);
		xmlhttp.send();
	};
</script>
<script language="javascript" type="text/javascript" src="datetimepicker.js"></script>
<style type="text/css">
.tftable {
	font-family:Arial;
	font-size: 12px;
	color: #333333;
	width: 100%; 
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc; 
	padding: 8px; 
	text-align: center;
}

.tftable tr {
	background-color: white; 
}

.tftable td {
	font-size: 11px; 
	padding: 5px; 
}
</style>
<script type="text/javascript">
<!--
	// Form validation code will come here.
	function validate() {

		if (document.myForm.req_details.value == 0) {
			alert("Please Enter Details..!");
			document.myForm.req_details.focus();
			return false;
		}

		return (true);
	}
//-->
</script>

<%
	try {

		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		String uname = null;
		int d_Id=0;
 	
		Connection con = Connection_Utility.getConnection();
		PreparedStatement ps_uname = con.prepareStatement("select * from User_tbl where U_Id="+ uid);
		ResultSet rs_uname = ps_uname.executeQuery();
		while (rs_uname.next()) {
			d_Id = rs_uname.getInt("Dept_Id");
			uname = rs_uname.getString("U_Name");
		}
%>
</head>
<body>
	<div id="container">
		<div id="top">
			<h3>Search Requisition</h3>
		</div>
		<div id="menu">
			<ul>
				<li><a href="index.jsp">Home</a></li>
				<li><a href="New_Requisition.jsp">Add New</a></li>
				<li><a href="Requisition_Status.jsp">Status</a></li>
				<li><a href="Closed_Req_User.jsp">Closed</a></li>
				<li><a href="All_Requisitions.jsp">All</a></li>
				<li><a href="Search_Requisitions.jsp">Search</a></li>
				<li><a href="DMS.jsp">DMS</a></li> 
				<li><a href="Reports_User.jsp">Reports</a></li>
				<li><a href="Change_Password.jsp">Change Password</a></li>
				<li><a href="Profile.jsp">My Profile</a></li> 
				<li><a href="Logout.jsp">Logout</a></li>
				<li><strong style="color: blue; font-size: small;"> <%=uname%></strong></li>
			</ul>
		</div>
		<%@page import="java.text.SimpleDateFormat"%>
		<%@page import="java.text.DateFormat"%>
		<%@page import="java.sql.ResultSet"%>
		<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
		<%@page import="java.sql.Connection"%>
		<%@page import="java.util.*"%>
		<%@page import="java.sql.PreparedStatement"%>
		<%
			response.setHeader("Cache-Control", "no-cache");
				response.setHeader("Pragma", "no-cache");
				response.setDateHeader("Expires", -1);
		%>
		  <div style="height: 500px;width:99%; overflow: scroll;">  
			<form action="Search_requisition_controller" method="post"
				id="searchForm" name="searchForm" onsubmit="return(validate());">
				<table align="center" border="0" class="tftable">
					<tr>
						<td align="right"><b>User Name</b></td> 
						<td align="left">
						
						<select name="user_id" style="height: 30px;font-size: 14px;">
						<%
						String myQueryString = "select U_Id,U_Name from User_Tbl where U_Id="+uid;
						if(d_Id==26 || d_Id==21 || d_Id==11){
							 myQueryString = "select U_Id,U_Name from User_Tbl order by U_Name";
						%>
						<option value="0">- - - - Select - - - -</option>
						<%
						}
								PreparedStatement ps_UName = con.prepareStatement(myQueryString);
								ResultSet rs_UName = ps_UName.executeQuery(); 
									while (rs_UName.next()) {
								%>
								<option value="<%=rs_UName.getInt("U_Id")%>"><%=rs_UName.getString("U_Name")%></option>
								<%
									}
										rs_UName.close();
								%>
						</select></td>
					</tr>

					<tr>
						<td align="right"><b>Select Problem Related To</b></td>
						<td align="left"><select name="rel_id" style="height: 30px;font-size: 14px;">
								<option value="0">--Select--</option>
								<option value="1">Software</option>
								<option value="2">Hardware</option>
								<option value="3">Mobile</option>
						</select></td>
					</tr>
					
					<tr>
						<td align="right"><b>Select Requisition Type</b></td>
						<td align="left">
						<select name="req_type" style="height: 30px;font-size: 14px;">
								<option value="0">- - - - Select - - - -</option>
							<%
								PreparedStatement ps_reqType=con.prepareStatement("select * from it_requisition_type_tbl");
								ResultSet rs_reqType=ps_reqType.executeQuery();
								while(rs_reqType.next())
								{
							%>
										<option value="<%=rs_reqType.getString("Req_Type_Id") %>"><%=rs_reqType.getString("Req_Type") %></option>
							<%
								}
							%>
							
						</select>
						</td>
					</tr>
					
					<tr>
						<td align="right"><b> From Date :</b></td>
						<td align="left"><input id="demo3" name="first_date"
							type="text" size="25" readonly="readonly"
							TITLE="Click on Date Picker" /> <a
							href="javascript:NewCal('demo3','ddmmyyyy',true,24)"> <img
								src="cal.gif" width="16" height="16" border="0"
								alt="Pick a date" /></a></td>
					</tr>
					<tr>
						<td align="right"><b> To Date :</b></td>
						<td align="left"><input id="demo4" name="last_date"
							type="text" size="25" readonly="readonly"
							TITLE="Click on Date Picker" /> <a
							href="javascript:NewCal('demo4','ddmmyyyy',true,24)"> <img
								src="cal.gif" width="16" height="16" border="0"
								alt="Pick a date" /></a></td>
					</tr>

					<tr>
						<td colspan="2" align="center"><input type="submit" value="Search" style="width: 150px; height: 30px;"></td>
					</tr>

				</table>

			</form>
			<div id="footer">
			<p class="style2">
				<a href="index.jsp">Home</a> <a href="New_Requisition.jsp">New
					Requisition</a> <a href="Requisition_Status.jsp">Requisition Status</a>
				<a href="All_Requisitions.jsp">All Requisitions</a> <a
					href="Reports_User.jsp">Reports</a> <a href="Logout.jsp">Logout</a>
				<br /> <a href="http://www.muthagroup.com">Mutha Group, Satara
				</a>
			</p>
		</div>
		</div>
		<%
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
		
	</div>
</body>
</html>