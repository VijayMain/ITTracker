<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>IT Tracker Home</title>
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
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" type="text/css" href="styles.css" /> 
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
    <h3><strong>IT Tracker </strong> </h3> 
  </div>
 <div id="menu">
			<ul>		
				<li><a href="IT_index.jsp">Home</a></li>
				<li><a href="IT_Role_Req.jsp">Log My Issues</a></li>
				<li><a href="IT_New_Requisition.jsp">New</a></li>
				<li><a href="Closed_Requisitions.jsp">Closed</a></li>
				<li><a href="IT_All_Requisitions.jsp">All</a></li>
				<!-- <li><a href="Asset_info.jsp">Asset Info </a></li>
				<li><a href="Asset_Master.jsp">Asset Master </a></li> -->
				<li><a href="Software_Access.jsp">Software Access</a></li>
				<li><a href="MISAccess.jsp">MIS Access</a></li>
				<li><a href="IT_Reports.jsp">Reports</a></li>
				<li><a href="DMS.jsp">DMS</a></li>
				<!-- <li><a href="IT_AssetHUB.jsp">IT Asset</a></li> -->
				<li><a href="IT_Feedback.jsp">Feedback</a></li> 
				<!-- <li><a href="Master.jsp">Master</a></li> -->
				<li><a href="Profile.jsp">My Profile</a></li>
				<li><a href="Logout.jsp">Logout<strong style="color: blue; font-size: 8px;"> <%=uname%></strong></a></li>
			</ul>
  </div>

  <div style="width:100%; height: 100%; padding-left: 5px;padding-bottom: 5px;padding-top: 5px;">
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
						<td>
						<input type="hidden" value="<%=reqno%>"  name="req_no">
						<input type="hidden" value="it_req"  name="it_req">
						<b><%=reqno%></b>
							</td>
					</tr>
					<tr>
						<td align="right"><b>Problem Related To :</b></td>
						<td><select name="rel_to" id="rel_to" onchange="showState(this.value)" style="height: 30px;width: 200px;font-size: 14px;">
								<option value="0">- - - - Select - - - -</option>
								<%
									PreparedStatement ps_relto = con
												.prepareStatement("select * from it_related_problem_tbl");
										ResultSet rs_relto = ps_relto.executeQuery();
										while (rs_relto.next()) {
								%>
								<option value="<%=rs_relto.getInt("Rel_Id")%>"><%=rs_relto.getString("Related_To")%></option>
								<%
									}
										rs_relto.close(); 
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
     <%
   	} catch (Exception e) {
   		e.printStackTrace();
   	}
   %>
  <div id="footer">
    <p class="style2"><a href="IT_index.jsp">Home</a> <a href="IT_New_Requisition.jsp">New Requisition</a> <a href="Closed_Requisitions.jsp">Closed Requisition</a> <a href="IT_All_Requisitions.jsp">All Requisitions</a> <a href="IT_Reports.jsp">Reports</a> <a href="Software_Access.jsp">Software Access</a> <a href="Logout.jsp">Logout</a><br />
    <a href="http://www.muthagroup.com">Mutha Group, Satara </a></p>
  </div>
</div>
</body>
</html>