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
	if (window.XMLHttpRequest) {
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
		xmlhttp1 = new XMLHttpRequest();
		xmlhttp2 = new XMLHttpRequest();
	} else {
		// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp2 = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { 
			document.getElementById("devData").innerHTML = xmlhttp.responseText;  
		}
	};
	xmlhttp1.onreadystatechange = function() {
		if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) { 
			document.getElementById("user").innerHTML = xmlhttp1.responseText;  
		}
	};
	xmlhttp2.onreadystatechange = function() {
		if (xmlhttp2.readyState == 4 && xmlhttp2.status == 200) { 
			document.getElementById("tonerRef").innerHTML = xmlhttp2.responseText;  
		}
	};
	xmlhttp.open("POST", "avail_partData.jsp?q=" + str, true);
	xmlhttp1.open("POST", "userDetails.jsp?q=" + str, true);
	xmlhttp2.open("POST", "GetToner_Refill.jsp?q=" + str, true);
	xmlhttp.send();
	xmlhttp2.send();
	xmlhttp1.send();
};


function validateForm() {                                          
	var dev_name = document.getElementById("dev_name"); 
	var company = document.getElementById("company"); 
	var operation = document.getElementById("operation"); 
	var refilldate = document.getElementById("refilldate"); 
	var count = document.getElementById("count"); 
	var itperson = document.getElementById("itperson"); 
	var amount = document.getElementById("amount"); 
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
		if (operation.value=="0" || operation.value==null || operation.value=="" || operation.value=="null") {
			alert("Operation ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (refilldate.value=="0" || refilldate.value==null || refilldate.value=="" || refilldate.value=="null") {
			alert("Refill Date ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (count.value=="0" || count.value==null || count.value=="" || count.value=="null") {
			alert("Print Count ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (itperson.value=="0" || itperson.value==null || itperson.value=="" || itperson.value=="null") {
			alert("Refilled By ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (amount.value=="0" || amount.value==null || amount.value=="" || amount.value=="null") {
			alert("Amount Paid ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (details.value=="0" || details.value==null || details.value=="" || details.value=="null") {
			alert("Notes ?"); 
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
<title>Printer Toner Details</title> 
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
  	<form action="Add_TonerRefill_Controller" method="post"  onsubmit="return validateForm();">
  	<strong style="font-size: 25px;">Register Printer Toner Refill Data</strong>
  	<br/>
		<table border="0">
			<tr>
				<td>Device Name :</td>
				<td> <select name="dev_name" id="dev_name" style="height: 30px;width: 250px;font-size: 16px;" onchange="showDetails(this.value)">
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
						<td>Select Operation :</td>
						<td colspan="2">
						<select name="operation" id="operation" style="height: 30px;width: 250px;font-size: 16px;">
						<option value="">- - - - - Select - - - - -</option>
						<option value="refill">Toner Refill</option>
						<option value="replace">Toner Replace</option>
						<option value="new">New Toner</option>
						</select>
						</td>  
					</tr>	 
			<tr>
				<td>Refill Date :</td>
				<td> <input type="text" name="refilldate" id="refilldate" readonly="readonly" style="height: 25px;width: 150px;font-size: 14px;"/> </td>
			</tr> 
			<tr>
				<td>Print Count :</td>
				<td> <input type="text" name="count" id="count" style="height: 25px;width: 300px;font-size: 14px;" onkeypress="return validatenumerics(event);"/> </td>
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
				<td>Amount Paid :</td>
				<td> <input type="text" name="amount" id="amount" style="height: 25px;width: 300px;font-size: 14px;" onkeypress="return validatenumerics(event);"/> </td>
			</tr> 		   
			<tr>
				<td>Notes :</td>
				<td><textarea rows="5" cols="40" name="details" id="details"></textarea> </td>
			</tr>  		
			<tr>
			<td colspan="2" align="center"><br/><a href="Add_tonerRefill.jsp" style="text-decoration: none;font-size: 22px;color: blue;"><strong>Reset</strong></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="submit" name="ADD" id="ADD" value="    Save    " style="width: 185px;height: 35px;"/> </td>
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
  <span id="user"></span>
  <span id="tonerRef"></span>  
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