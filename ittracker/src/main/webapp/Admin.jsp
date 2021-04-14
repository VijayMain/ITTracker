<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.PreparedStatement"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin</title>
<link rel="stylesheet" type="text/css" href="styles.css" />
<style type="text/css">
.tftable {
	font-size: 12px;
	color: #333333; 
}

.tftable th {
	font-size: 13px;
	background-color: #acc8cc; 
	padding: 8px;  
}

.tftable tr {
	background-color: white; 
	padding: 8px;  
}

.tftable td {
	font-size: 12px; 
	padding: 8px;  
}
</style>
<script type="text/javascript">
function ChangeColor(tableRow, highLight) {
	if (highLight) {
		tableRow.style.backgroundColor = '#CFCFCF';
	} else {
		tableRow.style.backgroundColor = '#FFFFFF';
	}
}
</script>
<script language="javascript">
	function button1(val) {
		var val1 = val; 
		document.getElementById("issueNoteId").value = val1;
		adminId.submit();
	}
</script> 
<script type="text/javascript">
function showStockDetails(str) {
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
			document.getElementById("getSelected_userInfo").innerHTML = xmlhttp.responseText;  
		}
	}; 
	xmlhttp.open("POST", "Get_AllStock_Info.jsp?q=" + str, true); 
	
	xmlhttp.send();  
	
}; 

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
			document.getElementById("getSelected_userInfo").innerHTML = xmlhttp.responseText;  
		}
	};
	xmlhttp.open("POST", "Get_AllUser_Asset_Info.jsp?q=" + str, true); 
	
	xmlhttp.send();  
	
}; 
function showPrinter(str) {
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
			document.getElementById("getSelected_userInfo").innerHTML = xmlhttp.responseText;  
		}
	}; 
	xmlhttp.open("POST", "Get_AllUser_PrinterRefill.jsp?q=" + str, true); 
	
	xmlhttp.send();  
	
}; 
</script>
<%
try { 
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
	String uname="";
	int d_Id=0;
 
	Connection con = Connection_Utility.getConnection();
	PreparedStatement ps_uname=con.prepareStatement("select * from User_tbl where U_Id="+uid);
	ResultSet rs_uname=ps_uname.executeQuery();
	while(rs_uname.next())
	{
		d_Id = rs_uname.getInt("Dept_Id");
		uname=rs_uname.getString("U_Name"); 
	}
%>
</head>
<body>
	<div id="container">
		<div id="top">
			<h3>User Asset Details</h3>

		</div>
		<div id="menu">
			<ul>
				<li><a href="index.jsp">Home</a></li>
				<li><a href="New_Requisition.jsp">New Requisition</a></li>
				<li><a href="Requisition_Status.jsp">Requisition Status</a></li>
				<li><a href="Closed_Req_User.jsp">Closed Requisition</a></li>
				<li><a href="All_Requisitions.jsp">All Requisition</a></li>
				<li><a href="Search_Requisitions.jsp">Search Requisition</a></li>
				<li><a href="User_AssetInfo.jsp">User Asset Info</a></li>
					<%
					if(d_Id==26 || d_Id==21 || d_Id==11){
					%>
					<li><a href="Admin.jsp">Admin</a></li>
					<%
					}
					%>
				<li><a href="Reports_User.jsp">Reports</a></li>
				<li><a href="Change_Password.jsp">Change Password</a></li>
				<li><a href="Logout.jsp">Logout</a></li>
				<li><strong style="color: blue; font-size: small;"> <%=uname%></strong></li>
			</ul> 
		</div> 
		<%
			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", -1); 
		%>
		<div> 
		<table width="100%" class="tftable">
		<tr>
		<td align="left">
		 &nbsp;<strong style="height: 30px;font-size: 15px;">Select any &#8658;&#8658;</strong> &nbsp;&nbsp;&nbsp;&nbsp;<select name="printer" id="printer" style="height: 30px;font-size: 15px;" onchange="showPrinter(this.value)">
						<option value="">Get Printer Refill Data &#8658;&#8658; </option>
						<%
						String nameUser="";
						PreparedStatement ps_devName=con.prepareStatement("select * from it_asset_deviceinfo_tbl where available_flag=0 and scrap_flag=0 and devicetype_mst_id=3");
						ResultSet rs_devName=ps_devName.executeQuery();
						while(rs_devName.next()){		  
							PreparedStatement ps_isueinfoname = con.prepareStatement("select * from it_asset_issuenote_tbl where asset_deviceinfo_id="+rs_devName.getInt("asset_deviceinfo_id"));
							ResultSet rs_issueInfoname = ps_isueinfoname.executeQuery();
							while(rs_issueInfoname.next()){
								PreparedStatement ps_devuser = con.prepareStatement("select * from user_tbl where U_Id="+rs_issueInfoname.getInt("issued_to"));
								ResultSet rs_devuser = ps_devuser.executeQuery();
								while(rs_devuser.next()){
									nameUser = rs_devuser.getString("U_Name");
								}
							}
							if(nameUser.equalsIgnoreCase("")){
								nameUser="Company Asset";
							}
					%>
					<option value="<%=rs_devName.getInt("asset_deviceinfo_id")%>"><%=rs_devName.getString("device_name")%>&nbsp;&nbsp;&nbsp;&#8658;&nbsp;&nbsp;&nbsp;<%=nameUser %></option>
					<% 			
						nameUser ="";
						}
						ps_devName.close();
						rs_devName.close();
					%>	 						 
						</select>
		&nbsp;  
		<select name="get_user" id="get_user" style="height: 30px;font-size: 15px;" onchange="showDetails(this.value)">
		<option value="">Get User Issue Data &#8658;&#8658; </option>
		<%
		String name="",device="";
		int Issueid=0;
		PreparedStatement ps_issue = con.prepareStatement("select * from it_asset_issuenote_tbl where surrender_flag=0 order by issued_to");
		ResultSet rs_issue = ps_issue.executeQuery();
		while(rs_issue.next()){
			PreparedStatement ps_getdevType = con.prepareStatement("select * from it_asset_deviceinfo_tbl where asset_deviceinfo_id="+rs_issue.getInt("asset_deviceinfo_id"));
			ResultSet rs_getdevType = ps_getdevType.executeQuery();
			while(rs_getdevType.next()){
				PreparedStatement ps_getnmType = con.prepareStatement("select * from it_asset_devicetype_mst_tbl where devicetype_mst_id="+rs_getdevType.getInt("devicetype_mst_id"));
				ResultSet rs_getnmType = ps_getnmType.executeQuery();
				while(rs_getnmType.next()){
				device = rs_getnmType.getString("device_type");
				}
			}
			PreparedStatement ps_getuser = con.prepareStatement("select * from user_tbl where U_Id="+rs_issue.getInt("issued_to"));
			ResultSet rs_getuser = ps_getuser.executeQuery();
			while(rs_getuser.next()){
			name=rs_getuser.getString("U_Name"); 
		  } 
		%>
		<option value="<%=rs_issue.getInt("asset_issueNote_id")%>"><%=name %>&nbsp;&nbsp;&nbsp;&#8658;&nbsp;&nbsp;&nbsp;<%=device%>&nbsp;</option>  
		<%
		}
		%>
		</select> &nbsp;
		<select name="dev_name" id="dev_name" style="height: 30px;font-size: 14px;" onchange="showStockDetails(this.value)">
						<option value="">IT Spare Devices &#8658;&#8658;</option>
						<%
						PreparedStatement ps_Name=con.prepareStatement("select * from it_asset_deviceinfo_tbl where available_flag=1 and scrap_flag=0");
						ResultSet rs_Name=ps_Name.executeQuery();
						while(rs_Name.next()){ 	
						%>
						<option value="<%=rs_Name.getInt("asset_deviceinfo_id")%>"><%=rs_Name.getString("device_name")%></option>
						<% 
						}
						rs_Name.close();
						ps_Name.close();
						%>
						</select> &nbsp;
						<%--
						<select name="it_spares" id="it_spares" style="height: 30px;font-size: 14px;" onchange="showSparesDetails(this.value)">
						<option value="">IT Spares List &#8658;&#8658;</option>
						<%
						PreparedStatement ps_sp=con.prepareStatement("select * from it_asset_deviceitem_mst_tbl order by Available_qty desc"); 
						ResultSet rs_sp = ps_sp.executeQuery();
						while(rs_sp.next()){
						
						<option value="<%=rs_sp.getInt("asset_deviceitem_mst_id")%>"><%=rs_sp.getString("device_parts")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8594;&nbsp;<%=rs_sp.getInt("Available_qty")%></option>
						<%
						}
						%>
						</select>
						--%>
		&nbsp; &nbsp; &nbsp; &nbsp; 
		<a href="Admin.jsp" style="text-decoration: none;color: blue;font-size: 15px;"><strong>RESET</strong></a>
		</td>
		</tr> 	
		</table>
		</div>
		<div style="width: 99%; height: 500px;overflow: scroll;">
		<form action="User_AssetDetails.jsp" name="adminId" id="adminId">		
		<input type="hidden" name="issueNoteId" id="issueNoteId">  		
 		<span id="getSelected_userInfo"> 				
 	<table border="0" width="100%" class="tftable">
<tr>
	<td colspan="10" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b style="font-size: 17px;">Issued Device Users List</b></td> 
</tr>
<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;" width="5%"><b>Sr No.</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><b>Device Name</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Device Type</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>User Name</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Department</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Company</b></td> 
</tr>
<%
int srno=1;
PreparedStatement ps_getData = con.prepareStatement("select * from it_asset_issuenote_tbl where surrender_flag=0 order by Company_Id");
ResultSet rs_getData = ps_getData.executeQuery();
while(rs_getData.next()){
%>
<tr  align="center" onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" onclick="button1('<%=rs_getData.getInt("asset_issueNote_id")%>');" style="cursor: pointer;">

	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><strong><%=srno %></strong></td>
	<%
	PreparedStatement ps_devname = con.prepareStatement("select * from it_asset_deviceinfo_tbl where asset_deviceinfo_id="+rs_getData.getInt("asset_deviceinfo_id"));
	ResultSet rs_devname = ps_devname.executeQuery();
	while(rs_devname.next()){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><%=rs_devname.getString("device_name") %></td> 
	<%
	PreparedStatement ps_devtype = con.prepareStatement("select * from it_asset_devicetype_mst_tbl where devicetype_mst_id="+rs_devname.getInt("devicetype_mst_id"));
	ResultSet rs_devtype = ps_devtype.executeQuery();
	while(rs_devtype.next()){ 
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><%=rs_devtype.getString("device_type") %></td>
	<%
	}
	}
	PreparedStatement ps_Uname = con.prepareStatement("select * from user_tbl where U_Id="+rs_getData.getInt("issued_to"));
	ResultSet rs_Uname = ps_Uname.executeQuery();
	while(rs_Uname.next()){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><%=rs_Uname.getString("U_Name") %></td>
	<%	
	PreparedStatement ps_deptname = con.prepareStatement("select * from user_tbl_dept where dept_id="+rs_Uname.getInt("dept_id"));
	ResultSet rs_deptname = ps_deptname.executeQuery();
	while(rs_deptname.next()){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><%=rs_deptname.getString("Department") %></td>
	<%
	}
	PreparedStatement ps_comp = con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_Uname.getInt("Company_Id"));
	ResultSet rs_comp = ps_comp.executeQuery();
	while(rs_comp.next()){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:center;"><%=rs_comp.getString("Company_Name") %></td> 
	<%  
	}
	} 
	%>
</tr>
<%
srno++;
}
%>
	</table>
 		</span>
 		</form>
		</div>
		<%
		}catch(Exception e){
			e.printStackTrace();
		}
		%>
		<div id="footer">
			<p class="style2"><a href="index.jsp">Home</a> <a href="New_Requisition.jsp">New Requisition</a> <a href="Requisition_Status.jsp">Requisition Status</a> <a href="All_Requisitions.jsp">All Requisitions</a> <a href="Reports_User.jsp">Reports</a> <a href="Logout.jsp">Logout</a><br /> <a
					href="http://www.muthagroup.com">Mutha Group, Satara</a>
			</p>
		</div>
	</div>
</body>
</html>