<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Requisition</title>
<link rel="stylesheet" type="text/css" href="styles.css" />
<style type="text/css">
.tftable {
	font-size: 14px;
	color: #333333;
	width: 100%; 
}

.tftable th {
	font-size: 15px;
	background-color: #acc8cc; 
	padding: 8px; 
	text-align: left;
}

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 14px; 
	padding: 8px; 
}
</style>
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
			}
		};
		xmlhttp.open("POST", "Req_Type.jsp?q=" + str, true);
		xmlhttp.send();
	};
</script>

<script type="text/javascript">  
	// Form validation code will come here.
	function validateForm() {

	var rel_to = document.getElementById("rel_to"); 
	var req_details = document.getElementById("req_details"); 
		if (rel_to.value=="0" || rel_to.value==null || rel_to.value=="" || rel_to.value=="null") {
			alert("Please Provide Problem Related To !!!"); 
			document.getElementById("Save").disabled = false;
			return false;
		}
		if (req_details.value=="0" || req_details.value==null || req_details.value=="" || req_details.value=="null") {
			alert("Please Provide Requisition Details !!!"); 
			document.getElementById("Save").disabled = false;
			return false;
		}
		document.getElementById("Save").disabled = true;
		return true;
	} 
</script>

<%
	try {

		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		int d_Id=0;
		String uname = null;
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
			<h3>Add New Requisition</h3>
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
		<div style="width: 800px; height: 50%;float: left;padding-left: 50px;">
			<form action="new_requisition_controller" method="post" id="myForm" name="myForm" onSubmit="return validateForm();">
				<table align="center" border="0" class="tftable">
					<tr>
						<td align="right"><b>Requisition No :</b></td>
						<%
							int reqno = 0;
								PreparedStatement ps_reqno = con.prepareStatement("select max(U_Req_Id) from IT_User_Requisition");
								ResultSet rs_reqno = ps_reqno.executeQuery();
								while (rs_reqno.next()) {
									reqno = rs_reqno.getInt("max(U_Req_Id)");
									reqno = reqno + 1;
								}
								rs_reqno.close();
						%>
						<td><input type="hidden" value="<%=reqno%>"  name="req_no">
						<b><%=reqno%></b>
							</td>
					</tr>
					<tr>
						<td align="right"><b>Problem Related To :</b></td>
						<td><select name="rel_to" id="rel_to" onchange="showState(this.value)" style="height: 30px;width: 200px;font-size: 14px;">
								<option value="0">- - - - Select - - - -</option>
								<%
									PreparedStatement ps_relto = con.prepareStatement("select * from it_related_problem_tbl");
										ResultSet rs_relto = ps_relto.executeQuery();
										while (rs_relto.next()) {
								%>
								<option value="<%=rs_relto.getInt("Rel_Id")%>"><%=rs_relto.getString("Related_To")%></option>
								<%
									}
										rs_relto.close();
									} catch (Exception e) {
										e.printStackTrace();
									}
								%>
						</select></td>
					</tr>
					<tr>
						<td align="right"><b>Requisition Type :</b></td>
						<td>
							<div id="req_type">Please Select Problem Related To !!!</div>
						</td>
					</tr>
					<tr>
						<td align="right"><b>Requisition Details :</b></td>
						<td><textarea rows="4" cols="50"
								name="req_details" id="req_details"></textarea></td>
					</tr>
					<tr>
					<td></td>
						<td align="left"><input type="submit" value="Save" id="Save" style="width: 150px; height: 30px;"></td>
					</tr>

				</table>

			</form>
		</div>

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
</body>
</html>