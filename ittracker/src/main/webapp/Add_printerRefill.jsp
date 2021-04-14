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
		    $( "#refilldate" ).datepicker({
		      changeMonth: true,//this option for allowing user to select month
		      changeYear: true //this option for allowing user to select from year range
		    });
		  }

		);
	
</script>
<script type="text/javascript">
function showDetails(str) {
	var xmlhttp; 
	var xmlhttp1; 
	var xmlhttp2; 
	var xmlhttp3; 
	if (window.XMLHttpRequest) {
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
		xmlhttp1 = new XMLHttpRequest();
		xmlhttp2 = new XMLHttpRequest();
		xmlhttp3 = new XMLHttpRequest();
	} else {
		// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp2 = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp3 = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { 
			document.getElementById("devData").innerHTML = xmlhttp.responseText; 
		}
	}; 
	
	xmlhttp1.onreadystatechange = function() {
		if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) { 
			document.getElementById("userRefill").innerHTML = xmlhttp1.responseText; 
		}
	}; 
	xmlhttp2.onreadystatechange = function() {
		if (xmlhttp2.readyState == 4 && xmlhttp2.status == 200) { 
			document.getElementById("printData").innerHTML = xmlhttp2.responseText; 
		}
	};
	xmlhttp3.onreadystatechange = function() {
		if (xmlhttp3.readyState == 4 && xmlhttp3.status == 200) { 
			document.getElementById("user").innerHTML = xmlhttp3.responseText; 
		}
	};
	
	xmlhttp.open("POST", "AvailDeviceInfo_issuenote.jsp?q=" + str, true);
	xmlhttp1.open("POST", "PrinterRefill_Count.jsp?q=" + str, true);
	xmlhttp2.open("POST", "PrinterRefill_history.jsp?q=" + str, true);
	xmlhttp3.open("POST", "userDetails.jsp?q=" + str, true);
	xmlhttp.send();
	xmlhttp1.send();
	xmlhttp2.send();
	xmlhttp3.send();
};


function validateForm() {                                            
	var dev_name = document.getElementById("dev_name");
	var beforeRefill = document.getElementById("beforeRefill");
	var afterRefill = document.getElementById("afterRefill");
	var inkused = document.getElementById("inkused");
	var refilldate = document.getElementById("refilldate");
	var itperson = document.getElementById("itperson");
	var details = document.getElementById("details"); 
		if (dev_name.value=="0" || dev_name.value==null || dev_name.value=="" || dev_name.value=="null") {
			alert("Device Name ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		} 
		if (beforeRefill.value=="0" || beforeRefill.value==null || beforeRefill.value=="" || beforeRefill.value=="null") {
			alert("Prev. Print Count ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (afterRefill.value=="0" || afterRefill.value==null || afterRefill.value=="" || afterRefill.value=="null") {
			alert("Current Print Count ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		} 
		if (inkused.value=="0" || inkused.value==null || inkused.value=="" || inkused.value=="null") {
			alert("Ink Used(in ml) ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		} 
		if (refilldate.value=="0" || refilldate.value==null || refilldate.value=="" || refilldate.value=="null") {
			alert("Refill Date ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (itperson.value=="0" || itperson.value==null || itperson.value=="" || itperson.value=="null") {
			alert("Refilled By ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (details.value=="0" || details.value==null || details.value=="" || details.value=="null") {
			alert("Notes  ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		
		document.getElementById("ADD").disabled = true;
		return true;
}

function getAverage() {   
	var beforeRefill = document.getElementById("beforeRefill");
	var afterRefill = document.getElementById("afterRefill");
	if (beforeRefill.value == "") {
		beforeRefill.value = 0;
	}
	if (afterRefill.value == "") {
		afterRefill.value = 0;
	}
	var f = parseFloat(afterRefill.value) - parseFloat(beforeRefill.value);

	document.getElementById("avg_count").value = f;
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
<title>Printer Refill</title> 
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
  	<form action="Add_PrinterRefill_Controller" method="post"  onsubmit="return validateForm();">
  	<strong style="font-size: 25px;">Register Printer INK Refill Data</strong>
  	<br/>
		<table border="0">
			<tr>
				<td>Device Name :</td>
				<td> <select name="dev_name" id="dev_name" style="height: 30px;width: 250px;font-size: 14px;" onchange="showDetails(this.value)">
						<option value=""> - - - - - Select Material - - - - - </option>
						<%
						PreparedStatement ps_devName=con.prepareStatement("select * from it_asset_deviceinfo_tbl where available_flag=0 and scrap_flag=0 and devicetype_mst_id=3");
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
						<td>Prev. Print Count :</td>
						<td colspan="2"><span id="userRefill"><input type="text" name="beforeRefill" id="beforeRefill" onkeyup="getAverage()" onkeypress="return validatenumerics(event);"/></span> </td>  
					</tr>
					<tr>
						<td>Current Print Count :</td>
						<td colspan="2"> <input type="text" name="afterRefill" id="afterRefill" onkeyup="getAverage()" onkeypress="return validatenumerics(event);"/></td>  
					</tr>	
			<tr>
				<td>Ink Used(in ml) :</td>
				<td> <input type="text" name="inkused" id="inkused" onkeypress="return validatenumerics(event);"/> </td>
			</tr>
			<tr>
				<td>Prev Refill Avg :</td>
				<td><input type="text" name="avg_count" id="avg_count" readonly="readonly"/> </td>
			</tr>
			<tr>
				<td>Refill Date :</td>
				<td> <input type="text" name="refilldate" id="refilldate" readonly="readonly"/> </td>
			</tr> 
			<tr>
				<td>Refilled By :</td>
				<td>
				<select name="itperson" id="itperson" style="height: 30px;width: 300px;font-size: 14px;">
				<option value=""> - - - - - Select - - - - - </option>
				<%
				PreparedStatement ps_it = con.prepareStatement("select * from user_tbl where Enable_Id=1 order by U_Name");
				ResultSet rs_itper=ps_it.executeQuery();
				while(rs_itper.next()){ 
				%>
				<option value="<%=rs_itper.getInt("U_Id")%>"><%=rs_itper.getString("U_Name")%></option>
				<%
				}
				%>
				</select>
				</td>
			</tr>   
			<tr>
				<td>Notes :</td>
				<td><textarea rows="5" cols="40" name="details" id="details"></textarea> </td>
			</tr>  		
			<tr>
			<td colspan="2" align="center"><br/><a href="Add_printerRefill.jsp" style="text-decoration: none;font-size: 22px;color: blue;"><strong>Reset</strong></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="submit" name="ADD" id="ADD" value="    Save    " style="width: 185px;height: 35px;"/> </td>
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
		<br/> 
	<strong style="font-size: 25px;"><a href="Asset_Master.jsp">BACK</a></strong>
  </div>
  <br/> 
  <div style="width:50%; height: 500px;float: right;padding-left: 10px;padding-bottom: 5px;padding-top: 5px;overflow: scroll;">
  <span id="user"></span>
  	<p id="devData"></p> 
  	<span id="printData"></span>
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