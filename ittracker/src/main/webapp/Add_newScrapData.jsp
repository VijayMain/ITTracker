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
<script type="text/javascript"> 
 
$(document).ready( 
		  function () {
		    $( "#scrap_date" ).datepicker({
		      changeMonth: true,//this option for allowing user to select month
		      changeYear: true //this option for allowing user to select from year range
		    });
		  }

		);
 
function validateForm() {                         
	var dev_name = document.getElementById("dev_name");
	var scrap_date = document.getElementById("scrap_date");
	var reason = document.getElementById("reason");
	var checkedby = document.getElementById("checkedby");  
	 
		if (dev_name.value=="0" || dev_name.value==null || dev_name.value=="" || dev_name.value=="null") {
			alert("Please Provide Device Name !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (scrap_date.value=="0" || scrap_date.value==null || scrap_date.value=="" || scrap_date.value=="null") {
			alert("Please Provide Scrap Date !!!");  
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (reason.value=="0" || reason.value==null || reason.value=="" || reason.value=="null") {
			alert("Reason Why to scrap ?");  
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (checkedby.value=="0" || checkedby.value==null || checkedby.value=="" || checkedby.value=="null") {
			alert("Checked By ?");  
			document.getElementById("ADD").disabled = false;
			return false;
		} 
		document.getElementById("ADD").disabled = true;
		return true;
}		
 
</script>
<script type="text/javascript">
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
</script>
<link rel="stylesheet" type="text/css" href="styles.css" /> 
<title>Add To Scrap</title> 
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
  	<form action="Add_toScrap_Controller" method="post"  onsubmit="return validateForm();">
  	<strong style="font-size: 25px;">Move To Scrap</strong> 
		<table border="0">
			<tr>
				<td>Device Name :</td>
				<td>
				<select name="dev_name" id="dev_name" style="height: 30px;width: 300px;font-size: 14px;" onchange="showDetails(this.value)">
				<option value=""> - - - - - Select - - - - - </option>
				<%
						PreparedStatement ps_devName=con.prepareStatement("select * from it_asset_deviceinfo_tbl where available_flag=0 and scrap_flag=0");
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
				<td>Scrap Date :</td>
				<td> <input type="text" name="scrap_date" id="scrap_date" readonly="readonly" style="height: 22px;width: 180px;font-size: 14px;"/>
				</td>
			</tr> 			
			<tr>
				<td>Reason :</td>
				<td><textarea rows="6" cols="40" name="reason" id="reason"></textarea> </td>
			</tr>
			<tr>
				<td>Checked by :</td> 
				<td>
				<select name="checkedby" id="checkedby" style="height: 30px;width: 300px;font-size: 14px;">
				<option value=""> - - - - - Select - - - - - </option>
				<%
				PreparedStatement ps_it = con.prepareStatement("select * from user_tbl where Dept_Id=18 and Enable_Id=1 order by U_Name");
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
			<td colspan="2" align="center"><br/><input type="submit" name="ADD" id="ADD" value="    Surrender   " style="width: 185px;height: 35px;"/> </td>
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
		</br> 
	<strong style="font-size: 25px;"><a href="Asset_Master.jsp">BACK</a></strong>
  </div>
  </br> 
  <div style="width:55%; height: 450px;float: right;padding-left: 10px;padding-bottom: 5px;padding-top: 5px;overflow: scroll;">
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