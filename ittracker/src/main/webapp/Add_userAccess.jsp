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
<link rel="stylesheet" type="text/css" href="styles.css" /> 
<script>  
	$(document).ready( 
			  function () {
			    $( "#accessdate" ).datepicker({
			      changeMonth: true,//this option for allowing user to select month
			      changeYear: true //this option for allowing user to select from year range
			    });
			  }

			);	
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
			document.getElementById("accessData").innerHTML = xmlhttp.responseText; 
		}
	};
	xmlhttp.open("POST", "UserAccessData.jsp?q=" + str, true);
	xmlhttp.send();
};

             
function validateForm() {  
	var username = document.getElementById("username");
	var accesslist = document.getElementById("accesslist");
	var accessdate = document.getElementById("accessdate");  
	var notes = document.getElementById("notes");  
	 
		if (username.value=="0" || username.value==null || username.value=="" || username.value=="null") {
			alert("Please Select User Name !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (accesslist.value=="0" || accesslist.value==null || accesslist.value=="" || accesslist.value=="null") {
			alert("Please Select Access List !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (accessdate.value=="0" || accessdate.value==null || accessdate.value=="" || accessdate.value=="null") {
			alert("Please Select Access Date !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (notes.value=="0" || notes.value==null || notes.value=="" || notes.value=="null") {
			alert("Please Enter Notes !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		document.getElementById("ADD").disabled = true;
		return true;
}		
</script>
<script type="text/javascript">
function multiSelectList(){
    var x=document.getElementById("accesslist");
    x.multiple=true;
}
</script>
<link rel="stylesheet" type="text/css" href="styles.css" /> 
<title>User Access</title> 
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
    <h3><strong>Give User Access</strong> </h3> 
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
  	<form action="Add_UserAccess_Controller" method="post" onsubmit="return validateForm();">
		<table border="0">
			<tr>
				<td>User Name :</td>
				<td> <select name="username" id="username"  style="height: 35px;width: 400px;font-size: 17px;" onchange="showDetails(this.value)">
				<option value=""> - - - - - Select - - - - - </option>
				<%
				PreparedStatement ps_username=con.prepareStatement("select * from user_tbl where Enable_id=1 order by U_Name");
				ResultSet rs_username=ps_username.executeQuery();
				while(rs_username.next()){
					PreparedStatement ps_deptname=con.prepareStatement("select * from user_tbl_dept where dept_id="+rs_username.getInt("dept_id"));
					ResultSet rs_deptname=ps_deptname.executeQuery();
					while(rs_deptname.next()){
				%>
				<option value="<%=rs_username.getInt("U_Id") %>"><%=rs_username.getString("U_Name") %>&nbsp;&nbsp;&nbsp;&nbsp;===>&nbsp;&nbsp;<%=rs_deptname.getString("Department") %>&nbsp;&nbsp;&nbsp;&nbsp;</option>
				<%
					}
				}
				ps_username.close();
				rs_username.close();
				%>
				</select> </td>
			</tr>
			<tr>
				<td>Access List<br/>(Press ctrl for multiple) :</td>
				<td><select name="accesslist" id="accesslist" onclick="multiSelectList()" size="10" style="width: 380px;font-size: 17px;">					 
						<%
						PreparedStatement ps_access=con.prepareStatement("select * from it_asset_accesslist_tbl");
						ResultSet rs_access=ps_access.executeQuery();
						while(rs_access.next()){
						%>
						<option value="<%=rs_access.getInt("accesslist_id")%>"><%=rs_access.getString("access_name")%></option>
						<%
						}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>Access Date :</td>				
				<td>
				<input type="text" name="accessdate" id="accessdate" style="height: 25px;width: 180px; font-size: 14px;" readonly="readonly"/>&nbsp;&nbsp;yyyy-mm-dd
				</td>
			</tr>
			<tr>
				<td>Notes :</td>				
				<td>
				<textarea name="notes" id="notes" rows="7" cols="50"></textarea>				
				</td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><br/><input type="submit" name="ADD" id="ADD" value="  SAVE " style="width: 185px;height: 35px;"/> </td>
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
 	<span id="accessData"></span>	 
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