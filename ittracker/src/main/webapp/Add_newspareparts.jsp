<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<script type="text/javascript">
 

function validateForm() {  
	var new_spare = document.getElementById("new_spare");
	var avil_stock = document.getElementById("avil_stock");
	var details = document.getElementById("details");
	 
		if (new_spare.value=="0" || new_spare.value==null || new_spare.value=="" || new_spare.value=="null") {
			alert("Please Provide Spares !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (avil_stock.value=="0" || avil_stock.value==null || avil_stock.value=="" || avil_stock.value=="null") {
			alert("Please Provide Available Stock !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (details.value=="0" || details.value==null || details.value=="" || details.value=="null") {
			alert("Please Provide Spares Detail !!!"); 
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
<title>Add Spare Details</title> 
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
    <h3><strong>Add New Spares</strong> </h3> 
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
  	<form action="Add_NewSpares_Controller" method="post"  onSubmit="return validateForm();">
  	
		<table border="0">
			<tr>
				<td><strong>New Spare Name :</strong> </td>
				<td> <input type="text" name="new_spare" id="new_spare" size="45" style="height: 20px;"/>
				 </td>
			</tr>
			<tr>
				<td><strong>Available stock :</strong> </td>
				<td> <input type="text" name="avil_stock" id="avil_stock" size="45" style="height: 20px;" onKeyPress="return validatenumerics(event);"/>
				 </td>
			</tr> 
			<tr>
				<td><strong>Spares Detail :</strong> </td>
				<td> <textarea rows="6" cols="45" name="details" id="details"></textarea>
				 </td>
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
		<br/> 
	<strong style="font-size: 25px;"><a href="Asset_Master.jsp">BACK</a></strong>
  </div>
  <br/> 
  <div style="width:58%; height: 450px;float: right;padding-left: 10px;padding-bottom: 5px;padding-top: 5px;overflow: scroll;">
  
 	<table border="1" id="Add_newstock_Qty" style="font-size: 11px; color: #333333; width: 100%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
	<tr>
	<td colspan="4" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Available Spares</b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 4px; border-style: solid; border-color: #729ea5; text-align: left;"><b>Spare Name</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 4px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Available Qty</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 4px; border-style: solid; border-color: #729ea5; text-align: left;"><b>Spares Detail</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 4px; border-style: solid; border-color: #729ea5; text-align: left;"><b>Add stock</b></td> 
	</tr>
	 <%
	PreparedStatement ps_sp=con.prepareStatement("select * from it_asset_deviceitem_mst_tbl group by device_parts"); 
	ResultSet rs_sp = ps_sp.executeQuery();
	while(rs_sp.next()){
	 %> 
	<tr align="center">	
	<td style="border-width: 1px; padding: 4px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_sp.getString("device_parts") %></td> 
 	<td style="border-width: 1px; padding: 4px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_sp.getInt("Available_qty") %></td> 
 	<td style="border-width: 1px; padding: 4px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_sp.getString("spares_details") %></td>
 	<td style="border-width: 1px; padding: 4px; border-style: solid; border-color: #729ea5; text-align: left;" width="25%">
 	<form action="AddNewStock_Controller" method="post">
 	<input type="hidden" name="spareId" value="<%=rs_sp.getInt("asset_deviceitem_mst_id")%>"/>
 	<input type="text" name="qty" id="qty" size="4" style="height: 20px;"  onKeyPress="return validatenumerics(event);"/>
 	<input type="submit" name="addStock" value="Add Stock"/>
 	</form>
 	</td>
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
   	} catch (Exception e) {
   		e.printStackTrace();
   	}
   %>
</body>
</html>
