<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<script type="text/javascript">
function validateForm() {
	var new_adapter = document.getElementById("new_adapter");
	var serialno = document.getElementById("serialno");
	var inputoutput = document.getElementById("inputoutput");  
	 
		if (new_adapter.value=="0" || new_adapter.value==null || new_adapter.value=="" || new_adapter.value=="null") {
			alert("Please Enter New Adapter Name !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (serialno.value=="0" || serialno.value==null || serialno.value=="" || serialno.value=="null") {
			alert("Please Enter Serial No !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (inputoutput.value=="0" || inputoutput.value==null || inputoutput.value=="" || inputoutput.value=="null") {
			alert("Please Select Input/Output Voltage !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		document.getElementById("ADD").disabled = true;
		return true;
}		
</script>
<link rel="stylesheet" type="text/css" href="styles.css" /> 
<title>Add New Adapter</title> 
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
				<li><a href="IT_Reports.jsp">Reports</a></li>
				<li><a href="Software_Access.jsp">Software Access</a></li>
				<li><a href="Asset_Master.jsp">Asset Master </a></li>
				<li><a href="Asset_info.jsp">Asset Info </a></li>
				<li><a href="Logout.jsp">Logout</a></li>
				<li><strong style="color: blue; font-size: x-small;"> <%=uname%></strong></li>
			</ul>
		</div>
 
  <div style="width:50%; height: 85%; padding-left: 10px;padding-bottom: 5px;padding-top: 5px;float: left;"> 
  </br> 
  	<form action="Add_NewAdapter_Controller" method="post"  onSubmit="return validateForm();">
		<table border="0">
			<tr>
				<td>New Adapter Name :</td>
				<td> <input type="text" name="new_adapter" id="new_adapter" size="35" style="height: 20px;"/> </td>
			</tr> 
			<tr>
				<td>Serial No :</td>
				<td> <input type="text" name="serialno" id="serialno" size="35" style="height: 20px;"/> </td>
			</tr> 
			<tr>
				<td>Input/Output Voltage :</td>
				<td> <input type="text" name="inputoutput" id="inputoutput" size="35" style="height: 20px;"/> </td>
			</tr> 
			
			<tr> 
			<td colspan="2" align="center"><input type="submit" name="ADD" id="ADD" value="ADD" style="background-color: #BABABA;width: 155px;height: 35px;"/> </td>
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
  <div style="width:40%; height: 85%;float: right;padding-left: 10px;padding-bottom: 5px;padding-top: 5px;overflow: scroll;"> 
 	<table border="1" style="font-size: 12px; color: #333333; width: 80%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
	<tr>
	<td colspan="3" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Available Adapter</b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Adapter Model Name</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Serial No</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Input/Output voltage</b></td> 
	</tr>
	<%
	PreparedStatement ps_ad=con.prepareStatement("select * from it_asset_adapter_mst_tbl");
	ResultSet rs_ad=ps_ad.executeQuery();
	while(rs_ad.next()){  
	%>
	<tr align="center">	
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_ad.getString("adapter_model_name") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_ad.getString("serial_no") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_ad.getString("input_output") %></td> 
	</tr>
	<% 
		}
	ps_ad.close();
	rs_ad.close();
	%>
	</table>	
	 
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