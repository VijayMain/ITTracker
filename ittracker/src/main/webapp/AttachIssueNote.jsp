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
		    $( "#attach_date" ).datepicker({
		      changeMonth: true,//this option for allowing user to select month
		      changeYear: true //this option for allowing user to select from year range
		    });
		  }

		);
 
function validateForm() {  
	var description = document.getElementById("description");
	var terms_file = document.getElementById("terms_file");
	var attach_date = document.getElementById("attach_date"); 
	var noteNo = document.getElementById("noteNo");
	 
		if (description.value=="0" || description.value==null || description.value=="" || description.value=="null") {
			alert("Please Enter File Description !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (terms_file.value=="0" || terms_file.value==null || terms_file.value=="" || terms_file.value=="null") {
			alert("Please add Attachments !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (attach_date.value=="0" || attach_date.value==null || attach_date.value=="" || attach_date.value=="null") {
			alert("Please select attach_date !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (noteNo.value=="0" || noteNo.value==null || noteNo.value=="" || noteNo.value=="null") {
			alert("Please select Issue Note Number !!!"); 
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
			document.getElementById("issuAttach").innerHTML = xmlhttp.responseText;
			//document.getElementById("approvers").innerHTML = xmlhttp.responseText;

		}
	};
	xmlhttp.open("POST", "AvailInfo_noteAttach.jsp?q=" + str, true);
	xmlhttp.send();
};
</script>
<link rel="stylesheet" type="text/css" href="styles.css" /> 
<title>Attach Issue Note</title> 
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
  </br> 
  	<form action="Add_IssueNoteAttach_Controller" method="post"  onSubmit="return validateForm();" enctype="multipart/form-data">
  	<strong style="font-size: 20px;">Attach Issue Note Documents</strong>
		<table border="0" style="font-size: 12px;">
			<tr>
				<td>Device Issued To :</td>
				<td>
				<select name="noteNo" id="noteNo" style="height: 30px;width: 280px;font-size: 12px;" onchange="showDetails(this.value)">
				<option value=""> - - - - - - Select - - - - - - </option>
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
				<td>File Description :</td>
				<td><input type="text" name="description" id="description" size="55" style="height: 20px;"/> </td>
			</tr> 
			<tr>
				<td>Attachments :</td>
				<td><input type="file" id="terms_file" name="terms_file" size="50" style="background-color:white; height: 25px;"/></td>
			</tr>
			<tr>
		
				<td>Date :</td>
				<td><input type="text" name="attach_date" id="attach_date" size="30" style="height: 20px;" readonly="readonly"/>&nbsp;&nbsp;yyyy-mm-dd</td>
			</tr>  		
			<tr> 
			<td colspan="2" align="left"><input type="submit" name="ADD" id="ADD" value="    Save   " style="background-color: #BABABA;width: 185px;height: 35px;"/> </td>
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
		</br> 
	<strong style="font-size: 25px;"><a href="Asset_Master.jsp">BACK</a></strong>
  </div>
  </br> 
  <div style="width:55%; height: 85%;float: right;padding-left: 10px;padding-bottom: 5px;padding-top: 5px;overflow: scroll;">
 <span id="issuAttach"></span>
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