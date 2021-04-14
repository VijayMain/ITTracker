<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.ArrayList"%>
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
		    $( "#surrender_date" ).datepicker({
		      changeMonth: true,//this option for allowing user to select month
		      changeYear: true //this option for allowing user to select from year range
		    });
		  }

		);
function validateForm() { 
	var noteNo = document.getElementById("dev_name");
	var dev_cond = document.getElementById("dev_cond");
	var submitby = document.getElementById("submitby");
	var itperson = document.getElementById("itperson"); 
	var surrender_date = document.getElementById("surrender_date");
	var details = document.getElementById("details");
	 
		if (noteNo.value=="0" || noteNo.value==null || noteNo.value=="" || noteNo.value=="null") {
			alert("Please Provide Device Name !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (dev_cond.value=="0" || dev_cond.value==null || dev_cond.value=="" || dev_cond.value=="null") {
			alert("Please Provide Device Condition !!!");  
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (submitby.value=="0" || submitby.value==null || submitby.value=="" || submitby.value=="null") {
			alert("Please Provide Submitted by !!!");  
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (itperson.value=="0" || itperson.value==null || itperson.value=="" || itperson.value=="null") {
			alert("Please Provide Device Accepted By !!!");  
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (surrender_date.value=="0" || surrender_date.value==null || surrender_date.value=="" || surrender_date.value=="null") {
			alert("Please Provide IT Received Date !!!");  
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (details.value=="0" || details.value==null || details.value=="" || details.value=="null") {
			alert("Please Provide Surrender Details !!!");  
			document.getElementById("ADD").disabled = false;
			return false;
		}
		document.getElementById("ADD").disabled = true;
		return true;
}		

function delother(str) {		 
	if(window.confirm("Do you really want to Delete This file ?")){
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
				document.getElementById("delete").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "DeleteIssueNote.jsp?termid=" + str, true);
		xmlhttp.send(); 
		location.reload();
	} 	
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
<title>Device Surrender Note</title> 
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
				<li><a href="IT_New_Requisition.jsp">New</a></li>
				<li><a href="Closed_Requisitions.jsp">Closed</a></li>
				<li><a href="IT_All_Requisitions.jsp">All</a></li> 
				<li><a href="Asset_info.jsp">Asset Info </a></li>
				<li><a href="Asset_Master.jsp">Asset Master </a></li> 
				<li><a href="Software_Access.jsp">Software Access</a></li>
				<li><a href="MISAccess.jsp">MIS Access</a></li> 
				<li><a href="IT_Reports.jsp">Reports</a></li>
				<li><a href="DMS.jsp">DMS</a></li>
				<li><a href="Logout.jsp">Logout<strong style="color: blue; font-size: x-small;"> <%=uname%></strong></a></li>
			</ul>
		</div> 
  <div style="width:40%; height: 85%; padding-left: 10px;padding-bottom: 5px;padding-top: 5px;float: left;"> 
   <br/>
  	<form action="Add_SurrenderNote_Controller" method="post"  onSubmit="return validateForm();">
  	<strong style="font-size: 25px;">Device Surrender Note</strong>
 
		<table border="0">
			<tr>
				<td>Device Name :</td>
				<td>
				<select name="dev_name" id="dev_name" style="height: 30px;width: 300px;font-size: 14px;" onchange="showDetails(this.value)">
				<option value=""> - - - - - Select - - - - - </option>
				<%
				String nameUser = "";
				PreparedStatement ps_no=con.prepareStatement("select * from it_asset_issuenote_tbl where surrender_flag=0");
				ResultSet rs_no=ps_no.executeQuery();
				while(rs_no.next()){
					 PreparedStatement ps_dev=con.prepareStatement("select * from it_asset_deviceinfo_tbl where scrap_flag=0 and available_flag=0 and asset_deviceinfo_id="+rs_no.getInt("asset_deviceinfo_id"));
					 ResultSet rs_dev=ps_dev.executeQuery();
					 while(rs_dev.next()){					 
						 PreparedStatement ps=con.prepareStatement("select * from it_asset_issuenote_tbl where asset_deviceinfo_id="+rs_dev.getInt("asset_deviceinfo_id")+" and surrender_flag=0");	
							ResultSet rs = ps.executeQuery();
							while(rs.next()){
								PreparedStatement psur=con.prepareStatement("select * from user_tbl where U_Id="+rs.getInt("issued_to"));	
								ResultSet rsur = psur.executeQuery();
								while(rsur.next()){
									nameUser = rsur.getString("U_Name");
								}
							}							 
				%>				
				<option value="<%=rs_dev.getInt("asset_deviceinfo_id")%>"><%=rs_dev.getString("device_name")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;----><%=nameUser %> </option>
				<% 
					 }				 
				} 
				ps_no.close();
				rs_no.close();
				%>
				</select>
				</td>
			</tr> 
			<tr>
				<td>Device Condition :</td>
				<td>
				<select name="dev_cond" id="dev_cond" style="height: 30px;width: 300px;font-size: 14px;">
				<option value=""> - - - - - Select - - - - - </option>
				<%
				PreparedStatement ps_devcond = con.prepareStatement("select * from it_asset_device_surrender_condition_tbl");
				ResultSet rs_devcond=ps_devcond.executeQuery();
				while(rs_devcond.next()){ 
				%>
				<option value="<%=rs_devcond.getInt("asset_device_sur_condi_id")%>"><%=rs_devcond.getString("device_condition")%></option>
				<%
				}
				%>
				</select>
				</td>
			</tr> 
			<tr>
				<td>Submitted by :</td>
				<td>
				<select name="submitby" id="submitby" style="height: 30px;width: 300px;font-size: 14px;">
				<option value=""> - - - - - Select - - - - - </option>
				<%
				PreparedStatement ps_sub = con.prepareStatement("select * from user_tbl order by U_Name");
				ResultSet rs_itsub=ps_sub.executeQuery();
				while(rs_itsub.next()){ 
				%>
				<option value="<%=rs_itsub.getInt("U_Id")%>"><%=rs_itsub.getString("U_Name")%></option>
				<%
				}
				%>
				</select>
				</td>
			</tr>   
			<tr>
				<td>Device Accepted By :</td>
				<td>
				<select name="itperson" id="itperson" style="height: 30px;width: 300px;font-size: 14px;">
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
				<td>IT Received Date :</td>
				<td> <input type="text" name="surrender_date" id="surrender_date" readonly="readonly" style="height: 25px;width: 180px;font-size: 14px;"/>
				</td>
			</tr>  
			<tr>
				<td>Surrender Details :</td>
				<td><textarea rows="6" cols="40" name="details" id="details"></textarea> </td>
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
		 <br/> 
	<strong style="font-size: 25px;"><a href="Asset_Master.jsp">BACK</a></strong>
  </div>
   <br/> 
  <div style="width:55%; height: 85%;float: right;padding-left: 10px;padding-bottom: 5px;padding-top: 5px;overflow: scroll;">
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