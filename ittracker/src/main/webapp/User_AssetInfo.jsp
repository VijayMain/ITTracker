<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Asset Info</title>
<link rel="stylesheet" type="text/css" href="styles.css" />
<style type="text/css">
.tftable {
	font-family:Arial;
	font-size: 12px;
	color: #333333;
	width: 100%; 
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc; 
	padding: 8px; 
	text-align: center;
}

.tftable tr {
	background-color: white; 
}

.tftable td {
	font-size: 11px; 
	padding: 5px; 
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
		//alert(val1);
		userNotes.submit();
	}
</script> 
<%
try { 
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
	int d_Id=0;
 
	String uname="",company="",department="";
	Connection con = Connection_Utility.getConnection();
	PreparedStatement ps_uname=con.prepareStatement("select * from User_tbl where U_Id="+uid);
	ResultSet rs_uname=ps_uname.executeQuery();
	while(rs_uname.next())
	{
		d_Id = rs_uname.getInt("Dept_Id");
		uname=rs_uname.getString("U_Name");
		
		PreparedStatement pscomp=con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_uname.getInt("Company_Id"));	
		ResultSet rscomp = pscomp.executeQuery();
		while(rscomp.next()){
		company = rscomp.getString("Company_Name");
		}
		
		
		PreparedStatement psdept=con.prepareStatement("select * from user_tbl_dept where dept_id="+rs_uname.getInt("Dept_Id"));	
			ResultSet rsdept = psdept.executeQuery();
			while(rsdept.next()){
			department = rsdept.getString("Department");		
			}
		
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
		<%@page import="java.text.SimpleDateFormat"%>
		<%@page import="java.text.DateFormat"%>
		<%@page import="java.sql.ResultSet"%>
		<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
		<%@page import="java.sql.Connection"%>
		<%@page import="java.util.*"%>
		<%@page import="java.sql.PreparedStatement"%>
		<%
			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", -1);

			
		%>
	  <div style="height: 500px;width:99%; overflow: scroll;">  
  		<table align="center" border="0" class="tftable" width="99%">
  	<tr>
		<th><b>User Name </b></th>
		<th><b>Company </b></th>
		<th><b>Department </b></th>  
		<th><b>User Access </b></th>  
	</tr>
  			 <%
  			String access=""; 
  			   PreparedStatement ps_asset = con.prepareStatement("select * from it_asset_access_tbl where user_name="+uid);
  			   ResultSet rs_asset = ps_asset.executeQuery();
  			   while(rs_asset.next()){
  				   PreparedStatement ps_assetlist = con.prepareStatement("select * from it_asset_accesslist_tbl where accesslist_id="+rs_asset.getInt("accesslist_id"));
  				   ResultSet rs_assetlist = ps_assetlist.executeQuery();
  				   while(rs_assetlist.next()){
  				   access = rs_assetlist.getString("access_name") +"," +access;
  				   }
  			   }  
  			 %>
<tr>
  			 <td align="center"><%=uname %></td>
  			 <td align="center"><%=company %></td>
  			 <td align="center"><%=department %></td>
  			 <td align="center"><%=access %></td>
</tr>
		</table>

<form action="User_AssetDetails.jsp" id="userNotes" name="userNotes">		
<input type="hidden" name="issueNoteId" id="issueNoteId">	 
	<table border="0" width="99%" class="tftable">
	<tr>
	<td colspan="10" style="font-size: 12px; background-color: #acc8cc; padding: 8px; text-align: center;"><b>Issued Device Details</b></td> 
	</tr>
	<tr>
	<th><b>Issue No.</b></th>
	<th><b>Device Name</b></th>
	<th><b>Supplier Name</b></th>
	<th><b>Device Type</b></th>
	<th><b>OS Installed</b></th>
	<th><b>IP Address(if any)</b></th>
	<th><b>Description / Particulars</b></th>
	<th><b>MAC Address(if any)</b></th>
	<th><b>Model No</b></th>  
	<th><b>IMEI No (If any)</b></th> 
	</tr>
	<%
	ArrayList issuelist = new ArrayList();
	PreparedStatement psdev=con.prepareStatement("select * from it_asset_issuenote_tbl where issued_to="+uid+" and surrender_flag=0");	
		ResultSet rsdev = psdev.executeQuery();
		while(rsdev.next()){
	PreparedStatement ps_ad=con.prepareStatement("select * from it_asset_deviceinfo_tbl where asset_deviceinfo_id="+rsdev.getInt("asset_deviceinfo_id"));
	ResultSet rs_ad=ps_ad.executeQuery();
	while(rs_ad.next()){
		issuelist.add(rsdev.getInt("asset_issueNote_id"));
		
	%>
	<tr align="center" onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" onclick="button1('<%=rsdev.getInt("asset_issueNote_id")%>');" style="cursor: pointer;">	
	<td><strong><%=rsdev.getInt("asset_issueNote_id") %></strong></td>
	<td align="left"><strong><%=rs_ad.getString("device_name") %></strong></td>
	<%
	PreparedStatement ps_sup = con.prepareStatement("select * from it_asset_supplier_mst_tbl where asset_supplier_mst_id="+rs_ad.getInt("asset_supplier_mst_id"));
	ResultSet rs_sup = ps_sup.executeQuery();
	while(rs_sup.next()){		
	%>
	<td style="text-align: left;"><%=rs_sup.getString("supplier") %></td>
	<%
	}
	ps_sup.close();
	rs_sup.close();
	PreparedStatement ps_devType = con.prepareStatement("select * from it_asset_devicetype_mst_tbl where devicetype_mst_id="+rs_ad.getInt("devicetype_mst_id"));
	ResultSet rs_devType = ps_devType.executeQuery();
	while(rs_devType.next()){ 	
	%>
	<td style="text-align:left;"><%=rs_devType.getString("device_type") %></td>
	<%
	}
	ps_devType.close();
	rs_devType.close();
	
	String os="";
	PreparedStatement ps_os = con.prepareStatement("select * from it_asset_os_mst_tbl where asset_OS_id="+rs_ad.getInt("asset_OS_id"));
	ResultSet rs_os = ps_os.executeQuery();
	while(rs_os.next()){
		os = rs_os.getString("os_name");
	}
	%>
	<td align="left"><%=os%></td>
	<%	
	PreparedStatement ps_ip = con.prepareStatement("select * from it_asset_ipaddress_mst_tbl  where asset_ipaddress_id="+rs_ad.getInt("asset_ipaddress_id"));
	ResultSet rs_ip = ps_ip.executeQuery();
	
	rs_ip.last();
	int gData = rs_ip.getRow();
	rs_ip.beforeFirst();
	if (gData > 0) { 
	while(rs_ip.next()){	
	%>
	<td align="left"><%=rs_ip.getString("ip_address") %></td>
	<%
	}
	}else{
	%>
	<td>&nbsp;</td>
	<%	
	}
	ps_devType.close();
	rs_devType.close();
	if(rs_ad.getString("description")!=null){
	%>
	<td align="left"><%=rs_ad.getString("description") %></td>
	<%	
	}else{
	%>
	<td>&nbsp;</td>
	<%	
	}	
	if(rs_ad.getString("hrd_mac_address")!=null){
	%>
	<td align="left"><%=rs_ad.getString("hrd_mac_address") %></td>
	<%	
	}else{
	%>
	<td>&nbsp;</td>
	<%	
	}
	if(rs_ad.getString("model_no")!=null){
	%>
	<td align="left"><%=rs_ad.getString("model_no") %></td>
	<%
	}else{
	%>
	<td>&nbsp;</td>
	<%
	} 
	if(rs_ad.getString("imei_no")!=null){
	%>
	<td align="left"><%=rs_ad.getString("imei_no") %></td>
	<%
	}else{
	%>
	<td>&nbsp;</td>
	<%
	} 
	%> 	
	</tr>
	<% 
		}
		} 
	%>
	</table>	 
	</form> 
	<%
			}catch(Exception e)
			{
				e.printStackTrace();
			}
		
		%>
		</div>
		<div id="footer">
			<p class="style2"><a href="index.jsp">Home</a> <a href="New_Requisition.jsp">New Requisition</a> <a href="Requisition_Status.jsp">Requisition Status</a> <a href="All_Requisitions.jsp">All Requisitions</a> <a href="Reports_User.jsp">Reports</a> <a href="Logout.jsp">Logout</a><br /> <a
					href="http://www.muthagroup.com">Mutha Group, Satara</a>
			</p>
		</div>
	</div>
</body>
</html>