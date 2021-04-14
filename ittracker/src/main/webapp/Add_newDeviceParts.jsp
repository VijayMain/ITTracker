<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<script type="text/javascript">
function removeItem(str){ 
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
			document.getElementById("data_availPart").innerHTML = xmlhttp.responseText;
		}
	};
	xmlhttp.open("POST", "Delete_Intpart.jsp?partId=" + str, true);
	xmlhttp.send();
}

function showDetails(str) {
	var xmlhttp;
	var xmlhttp1;
		
	if (window.XMLHttpRequest) {
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
		xmlhttp1 = new XMLHttpRequest();
	} else {
		// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var a = null;
			document.getElementById("devData").innerHTML = xmlhttp.responseText; 
		}
	};
	xmlhttp1.onreadystatechange = function() {
		if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
			document.getElementById("user").innerHTML = xmlhttp1.responseText;
		}
	};
	xmlhttp.open("POST", "avail_partData.jsp?q=" + str, true);
	xmlhttp1.open("POST", "userDetails.jsp?q=" + str, true);
	xmlhttp.send();
	xmlhttp1.send();
};


function validateForm() {  	          
	var devicename = document.getElementById("devicename");
	var parttype = document.getElementById("parttype");
	var qty = document.getElementById("qty");
	var specification = document.getElementById("specification"); 
	 
		if (devicename.value=="0" || devicename.value==null || devicename.value=="" || devicename.value=="null") {
			alert("Please Select Device Name !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (parttype.value=="0" || parttype.value==null || parttype.value=="" || parttype.value=="null") {
			alert("Please Select Part !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (qty.value=="0" || qty.value==null || qty.value=="" || qty.value=="null") {
			alert("Please Enter Part Quantity !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (specification.value=="0" || specification.value==null || specification.value=="" || specification.value=="null") {
			alert("Please Enter Specifications !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		document.getElementById("ADD").disabled = true;
		return true;
}		
</script>
<script type="text/javascript">
function validatenumerics(key) {
//getting key code of pressed key
var keycode = (key.which) ? key.which : key.keyCode;
//comparing pressed keycodes
 
if (keycode > 31 && (keycode < 48 || keycode > 57) && keycode != 46) {
    alert("Only allow numeric Data entry");
    return false;
}else 
{
	return true;
};
}
</script>
<link rel="stylesheet" type="text/css" href="styles.css" /> 
<title>Add Device Details</title> 
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
 
  <div style="width:35%; height: 500px; padding-left: 10px;padding-bottom: 5px;padding-top: 5px;float: left;"> 
  <br/> 
  	<form action="Add_DeviceParts_Controller" method="post"  onSubmit="return validateForm();">
		<table border="0">
		<tr>
			<th colspan="8" align="left" scope="col"><b style="font-size: 25px; color: green;">Add Device Parts :<br /> </b></th>
		</tr>
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
				<td>Part Name :</td>
				<td> <select name="parttype" id="parttype"  style="height: 30px;width: 250px;">
				<option value=""> - - - - - Select - - - - - </option>
				<%
				PreparedStatement ps_part=con.prepareStatement("select * from it_asset_deviceitem_mst_tbl");
				ResultSet rs_part=ps_part.executeQuery();
				while(rs_part.next()){
				%>
				<option value="<%=rs_part.getInt("asset_deviceitem_mst_id") %>"><%=rs_part.getString("device_parts") %></option>
				<%
				}
				ps_part.close();
				rs_part.close();
				%>
				</select> </td>
			</tr>  
			<tr>
				<td>Quantity :</td>
				<td> <input type="text" name="qty" id="qty" style="height: 20px;width: 250px;" onKeyPress="return validatenumerics(event);"/> 
				</td>
			</tr>
			<tr>
				<td>Specification :</td>
				<td> <input type="text" name="specification" id="specification" style="height: 20px;width: 250px;"/> 
				</td>
			</tr>
			<tr>
			<td> 
			</td><td></td>
			</tr>   		
			<tr> 
			<td colspan="2" align="center"><br/><input type="submit" name="ADD" id="ADD" value="SAVE" style="width: 185px;height: 35px;"/> </td>
			</tr>
			<tr>  
				<td colspan="2">
						<%
						if(request.getParameter("fail")!=null){
						%>
						<span style="color: red;"><%=request.getParameter("fail") %></span>
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
  <div style="width:60%; height: 500px;float: right;padding-left: 10px;padding-bottom: 5px;padding-top: 5px;overflow: scroll;">
  	<span id="user"></span> 
 	<span id="devData"></span>  
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