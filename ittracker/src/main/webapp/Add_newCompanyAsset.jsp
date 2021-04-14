<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>

<html xmlns="http://www.w3.org/1999/xhtml">

<head> 
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script>  
$(document).ready( 
		  function () {
		    $( "#dateinstall" ).datepicker({
		      changeMonth: true,//this option for allowing user to select month
		      changeYear: true //this option for allowing user to select from year range
		    });
		  }

		);	
	
</script>
<script type="text/javascript">
function multiSelectList(){
    var x=document.getElementById("software");
    x.multiple=true;
}
</script>
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
	xmlhttp.open("POST", "AvailDeviceInfo_issuenote.jsp?q=" + str, true);
	xmlhttp.send();
};


function validateForm() {                    
	var dev_name = document.getElementById("dev_name");
	var company = document.getElementById("company");
	var installed_by = document.getElementById("installed_by");
	var location = document.getElementById("location");
	var dateinstall = document.getElementById("dateinstall");
	var details = document.getElementById("details");
	 
		if (dev_name.value=="0" || dev_name.value==null || dev_name.value=="" || dev_name.value=="null") {
			alert("Device Name ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Company ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (installed_by.value=="0" || installed_by.value==null || installed_by.value=="" || installed_by.value=="null") {
			alert("Installed By ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		} 
		if (location.value=="0" || location.value==null || location.value=="" || location.value=="null") {
			alert("Location ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (dateinstall.value=="0" || dateinstall.value==null || dateinstall.value=="" || dateinstall.value=="null") {
			alert("Date Installed ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (details.value=="0" || details.value==null || details.value=="" || details.value=="null") {
			alert("Please provide details ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		document.getElementById("ADD").disabled = true;
		return true;
}		
</script>
<link rel="stylesheet" type="text/css" href="styles.css" /> 
<title>Add Company Asset Details</title> 
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
    <h3><strong>IT Tracker </strong> </h3> 
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
  	<form action="Add_CompanyAssets_Controller" method="post"  onsubmit="return validateForm();">
  	<strong style="font-size: 25px;">Register Company Assets :</strong>
  	<br/>
		<table border="0">
			<tr>
				<td>Device Name :</td>
				<td> <select name="dev_name" id="dev_name" style="height: 30px;width: 250px;font-size: 14px;" onchange="showDetails(this.value)">
						<option value=""> - - - - - Select Material - - - - - </option>
						<%
						PreparedStatement ps_devName=con.prepareStatement("select * from it_asset_deviceinfo_tbl where available_flag=1 and scrap_flag=0");
						ResultSet rs_devName=ps_devName.executeQuery();
						while(rs_devName.next()){ 
						%>
						<option value="<%=rs_devName.getInt("asset_deviceinfo_id")%>"><%=rs_devName.getString("device_name")%></option>
						<%
						}
						ps_devName.close();
						rs_devName.close();
						%>
						</select>	
				</td>
			</tr> 
			<tr>
						<td>Company :</td>
						<td colspan="2">
						<select name="company" id="company" style="height: 30px;width: 250px;font-size: 14px;">
						<option value=""> - - - - - Select User - - - - - </option>
						<%
						PreparedStatement ps_compName=con.prepareStatement("select * from user_tbl_company where Company_Id!=6");
						ResultSet rs_compName=ps_compName.executeQuery();
						while(rs_compName.next()){ 
						%>
						<option value="<%=rs_compName.getInt("Company_Id")%>"><%=rs_compName.getString("Company_Name")%></option>
						<%
						}
						ps_compName.close();
						rs_compName.close();
						%>
						</select>
						</td>  
					</tr>
				<tr>
						<td>Installed By :</td>
						<td colspan="2">
						<select name="installed_by" id="installed_by" style="height: 30px;width: 250px;font-size: 14px;">
						<option value=""> - - - - - Select User - - - - - </option>
						<%
						PreparedStatement ps_givenbyName=con.prepareStatement("select * from user_tbl where Enable_id=1 and Dept_Id=18");
						ResultSet rs_givenbyName=ps_givenbyName.executeQuery();
						while(rs_givenbyName.next()){ 
						%>
						<option value="<%=rs_givenbyName.getInt("U_Id")%>"><%=rs_givenbyName.getString("U_Name")%></option>
						<%
						}
						ps_givenbyName.close();						
						rs_givenbyName.close();
						%>
						</select>  
						</td>  
					</tr>	
			<tr>
				<td>Device Location :</td>
				<td> <input type="text" name="location" id="location" size="50" style="height: 20px;"/> </td>
			</tr>
			<tr>
				<td>Installation Date :</td>
				<td> <input type="text" name="dateinstall" id="dateinstall" readonly="readonly" style="height: 20px;"/> </td>
			</tr>
			<tr>
				<td>Details :</td>
				<td> <textarea rows="5" cols="40" name="details" id="details"></textarea> </td>
			</tr>
			
				<tr>
						<td>Software Installed/Access<br />(Select Multiple) :</td>
						<td colspan="2">
						<select name="software" id="software" onclick="multiSelectList()" size="10" style="width: 380px;font-size: 16px;">
					 
						<%
						PreparedStatement ps_soft=con.prepareStatement("select * from it_asset_software_mst_tbl");
						ResultSet rs_soft=ps_soft.executeQuery();
						while(rs_soft.next()){
						%>
						<option value="<%=rs_soft.getInt("asset_software_id")%>"><%=rs_soft.getString("software_name")%></option>
						<%
						}
						%> 
						</select>
						
						</td>  
					</tr>  		
			<tr> 
			<td colspan="2" align="center"><br/><input type="submit" name="ADD" id="ADD" value="    Save    " style="width: 185px;height: 35px;"/> </td>
			</tr>
			<tr>  
				<td colspan="2">
						<%
						if(request.getParameter("error")!=null){
						%>
						<span style="color: red;"><%=request.getParameter("error") %></span>
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