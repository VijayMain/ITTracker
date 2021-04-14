<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<script type="text/javascript">
function validateForm() {
	var new_soft = document.getElementById("new_soft");
	var softtype = document.getElementById("softtype");  
	 
		if (new_soft.value=="0" || new_soft.value==null || new_soft.value=="" || new_soft.value=="null") {
			alert("Please Provide New Software Name !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (softtype.value=="0" || softtype.value==null || softtype.value=="" || softtype.value=="null") {
			alert("Please Select License Type !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		document.getElementById("ADD").disabled = true;
		return true;
}		
</script>
<link rel="stylesheet" type="text/css" href="styles.css" /> 
<title>Add New Software</title> 
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
    <h3><strong>Add New Software</strong> </h3> 
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
  	<form action="Add_NewSoftware_Controller" method="post"  onSubmit="return validateForm();">
		<table border="0">
			<tr>
				<td>New Software Name :</td>
				<td> <input type="text" name="new_soft" id="new_soft" size="35" style="height: 20px;"/> </td>
			</tr>
			<tr>
				<td>License Type :</td>
				<td> 
				<select name="softtype" id="softtype" style="height: 30px;width: 280px;">
				<option value="">  - - - - - - - - - - - - - Select - - - - - - - - - - - - -  </option>
				<%
				PreparedStatement ps_type = con.prepareStatement("select * from it_asset_licencetype_mst_tbl");
				ResultSet rs_type = ps_type.executeQuery();
				while(rs_type.next()){
				%>
				<option value="<%=rs_type.getInt("licence_type_id")%>"><%=rs_type.getString("licence_type") %></option>
				<%
				}
				%>
				</select> </td>
			</tr>
			<tr> 
			<td colspan="2" align="center"><br/><input type="submit" name="ADD" id="ADD" value="ADD" style="width: 155px;height: 35px;"/> </td>
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
  <div style="width:48%; height: 500px;float: right;padding-left: 10px;padding-bottom: 5px;padding-top: 5px;overflow: scroll;"> 
 	<table border="1" style="font-size: 12px; color: #333333; width: 80%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
	<tr>
	<td colspan="2" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Available Softwares</b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Name</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>License Types</b></td> 
	</tr>
	<%
	PreparedStatement ps_soft=con.prepareStatement("select * from it_asset_software_mst_tbl");
	ResultSet rs_soft=ps_soft.executeQuery();
	while(rs_soft.next()){  
	%>
	<tr align="center">	
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_soft.getString("software_name") %></td>
	<%
	PreparedStatement ps_get = con.prepareStatement("select * from it_asset_licencetype_mst_tbl where licence_type_id="+rs_soft.getInt("licence_type_id"));
	ResultSet rs_get = ps_get.executeQuery();
	while(rs_get.next()){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_get.getString("licence_type") %></td> 
	<%
	}
	%>	
	</tr>
	<% 
		}
	ps_soft.close();
	rs_soft.close();
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