<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<script type="text/javascript">
function showDetails(str) {
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
			document.getElementById("devData").innerHTML = xmlhttp.responseText;
			//document.getElementById("approvers").innerHTML = xmlhttp.responseText;

		}
	};
	xmlhttp.open("POST", "AvailDeviceInfo.jsp?q=" + str, true);
	xmlhttp.send();
};


function validateForm() {  
	var devicename = document.getElementById("devicename");
	var location = document.getElementById("location");
	var provider = document.getElementById("provider");  
	 
		if (devicename.value=="0" || devicename.value==null || devicename.value=="" || devicename.value=="null") {
			alert("Please Select Device Name !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (location.value=="0" || location.value==null || location.value=="" || location.value=="null") {
			alert("Please Enter Device Location !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (provider.value=="0" || provider.value==null || provider.value=="" || provider.value=="null") {
			alert("Please Enter AMC Provider with Place) !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		document.getElementById("ADD").disabled = true;
		return true;
}		
</script>
<link rel="stylesheet" type="text/css" href="styles.css" /> 
<title>Add AMC Details</title> 
</head>
<body>

<%
try {	
	int dept_id=0;
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
	String uname="";
	Connection con = Connection_Utility.getConnection();
	PreparedStatement ps_uname=con.prepareStatement("select * from User_tbl where U_Id="+uid);
	ResultSet rs_uname=ps_uname.executeQuery();
	while(rs_uname.next())
	{
		uname=rs_uname.getString("U_Name");
		dept_id = rs_uname.getInt("Dept_Id");
	}
%>

<div id="container">
  <div id="top">
    <h3><strong>Add AMC Details</strong> </h3> 
  </div>
  <div id="menu">
			<ul>
				<li><a href="IT_index.jsp">Home</a></li>
				<li><a href="IT_New_Requisition.jsp">New Requisitions</a></li>
				<li><a href="Closed_Requisitions.jsp">Closed Requisition</a></li>
				<li><a href="IT_All_Requisitions.jsp">All Requisitions</a></li> 
				<li><a href="Asset_info.jsp">Asset Info </a></li>
				<li><a href="Asset_Master.jsp">Asset Master </a></li> 
				<li><a href="Software_Access.jsp">Software Access</a></li>
				<li><a href="MISAccess.jsp">MIS Access</a></li> 
				<li><a href="IT_Reports.jsp">Reports</a></li>
				<li><a href="Graphs.jsp">Graphs</a></li>
				<li><a href="Logout.jsp">Logout<strong style="color: blue; font-size: x-small;"> <%=uname%></strong></a></li>
			</ul>
		</div>
 
  <div style="width:40%; height: 85%; padding-left: 10px;padding-bottom: 5px;padding-top: 5px;float: left;"> 
  <br/> 
  	<form action="Add_AMCInfo_Controller" method="post"  onSubmit="return validateForm();">
		<table border="0">
			<tr>
				<td>Device Name :</td>
				<td> <select name="devicename" id="devicename"  style="height: 30px;width: 250px;" onchange="showDetails(this.value)">
				<option value=""> - - - - - Select - - - - - </option>
				<%
				PreparedStatement ps_devName=con.prepareStatement("select * from it_asset_deviceinfo_tbl where scrap_flag=0");
				ResultSet rs_devName=ps_devName.executeQuery();
				while(rs_devName.next()){
				%>
				<option value="<%=rs_devName.getInt("asset_deviceinfo_id") %>"><%=rs_devName.getString("device_name") %></option>
				<%
				}
				ps_devName.close();
				rs_devName.close();
				%>
				</select> </td>
			</tr> 
			<tr>
				<td>Device Location :</td>
				<td> <input type="text" name="location" id="location" size="35" style="height: 20px;"/> </td>
			</tr>
			<tr>
				<td>AMC Provider<br/>(Name of Provider / Place) :</td>
				<td> <input type="text" name="provider" id="provider" size="45" style="height: 20px;"/> </td>
			</tr>  		
			<tr> 
			<td colspan="2" align="center"><br/><input type="submit" name="ADD" id="ADD" value="Save & Contact Details" style="width: 185px;height: 35px;"/> </td>
			</tr>
			<tr>  
				<td colspan="2">
						<%
						if(request.getParameter("avail")!=null){
						%>
						<span style="color: red;"><%=request.getParameter("avail") %></span>
						<% 	
						}if(request.getParameter("success")!=null){
						%>
						<span style="color: green;"><%=request.getParameter("success") %></span>	
						<%	
						}
						else{
						%>
						&nbsp;
						<%	
						}
						%>
				</td> 
			</tr>
		</table>
	</form>	 
		<br/> 
	<strong style="font-size: 25px;"><a href="Asset_Master.jsp">BACK</a></strong>
  </div>
  <br/> 
  <div style="width:50%; height: 500px;float: right;padding-left: 10px;padding-bottom: 5px;padding-top: 5px;overflow: scroll;"> 
 	<p id="devData"></p>
	 
  </div>
  <div id="footer">
    <p class="style2"><a href="IT_index.jsp">Home</a> <a href="IT_New_Requisition.jsp">New Requisition</a> <a href="Closed_Requisitions.jsp">Closed Requisition</a> <a href="IT_All_Requisitions.jsp">All Requisitions</a> <a href="IT_Reports.jsp">Reports</a> <a href="Software_Access.jsp">Software Access</a> <a href="Logout.jsp">Logout</a><br />
    <a href="http://www.muthagroup.com">Mutha Group, Satara </a></p>
  </div>
</div>
  <%
  con.close();
   	} catch (Exception e) {
   		e.printStackTrace();
   	}
   %>
</body>
</html>