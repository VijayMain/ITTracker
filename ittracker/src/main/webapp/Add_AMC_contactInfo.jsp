<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<script type="text/javascript">
function validateForm() {   
	var cont_name = document.getElementById("cont_name");
	var cont_no = document.getElementById("cont_no");  
		if (cont_name.value=="0" || cont_name.value==null || cont_name.value=="" || cont_name.value=="null") {
			alert("Please Enter Contact Name !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (cont_no.value=="0" || cont_no.value==null || cont_no.value=="" || cont_no.value=="null") {
			alert("Please Enter Contact No  !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		document.getElementById("ADD").disabled = true;
		return true;
}		
</script>
<link rel="stylesheet" type="text/css" href="styles.css" /> 
<title>Add Contact Details</title> 
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
	int asset_id =Integer.parseInt(request.getParameter("amcId"));
	
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
  	<form action="Add_ContactDetails_Controller" method="post"  onSubmit="return validateForm();">
  	<input type="hidden" name="asset_id" id="asset_id" value="<%=asset_id%>"/>
		<table border="0">
			<tr>
				<td>Contact Name :</td>
				<td> <input type="text" name="cont_name" id="cont_name" size="35" style="height: 20px;"/> </td>
			</tr>   
			<tr>
				<td>Contact No :</td>
				<td> <input type="text" name="cont_no" id="cont_no" size="35" style="height: 20px;"/> </td>
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
 <table border="1" style="font-size: 12px; color: #333333; width: 50%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
	<tr>
	<td colspan="2" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>AMC Details</b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Device Location </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>AMC Provider<br />
(Name of Provider / Place) </b></td>
	</tr>
	<tr>
	<%
	PreparedStatement ps_amc=con.prepareStatement("select * from it_asset_compasset_tbl where asset_compAsset_id="+asset_id);
	ResultSet rs_amc=ps_amc.executeQuery();
	rs_amc.last();
	int getamc = rs_amc.getRow();
	rs_amc.beforeFirst();
	if (getamc > 0) {
	while(rs_amc.next()){
	%>	
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_amc.getString("location") %></td> 
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_amc.getString("amc_provider") %></td> 
	<%
	}
	ps_amc.close();
	rs_amc.close();
	}else{
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;">&nbsp;</td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;">&nbsp;</td>
	<%
	}
	%>
	</tr>
	</table>
	<!-- 
	****************************************************************************************************************************
	****************************************************************************************************************************
	 -->
	
	 <table border="1" style="font-size: 12px; color: #333333; width: 50%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
	<tr>
	<td colspan="2" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Contact Details</b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Name </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Contact No</b></td>
	</tr>
	
	<%
	int relid=0;
	PreparedStatement ps_rel=con.prepareStatement("select * from it_asset_assetamc_rel_tbl where asset_compAsset_id="+asset_id);
	ResultSet rs_rel=ps_rel.executeQuery();
	rs_rel.last();
	int getrel = rs_rel.getRow();
	rs_rel.beforeFirst();
	if (getrel > 0) {
	while(rs_rel.next()){ 
	PreparedStatement ps_cont = con.prepareStatement("select * from it_asset_amc_tbl where asset_AMC_id="+rs_rel.getInt("asset_AMC_id"));
	ResultSet rs_cont = ps_cont.executeQuery();
	while(rs_cont.next()){
	%>	
	<tr>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_cont.getString("name") %></td> 
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_cont.getString("contact") %></td>
	</tr> 
	<%	
	}
	ps_cont.close();
	rs_cont.close();
	}
	ps_rel.close();
	rs_rel.close();
	}else{
	%>
	<tr>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;">&nbsp;</td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;">&nbsp;</td>
	</tr>
	<%
	}
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