<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.*"%>
<html>
<head> 
<title>Get All User Info</title>
</head>
<body>
<%
try{
Connection con = Connection_Utility.getConnection();
ArrayList assetname=new ArrayList();
int i=0,devId=0;
String noteId = request.getParameter("q");

if(!noteId.equalsIgnoreCase("")){
i = Integer.parseInt(noteId); 

%>
<span id="getSelected_userInfo"> 
<table border="0" width="100%" class="tftable">
	<tr>
	   <td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>User Name </b></td>
	   <td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Company </b></td>
	   <td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Department </b></td>  
	   <td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>User Access </b></td>  
	</tr>
	<%
	PreparedStatement ps=con.prepareStatement("select * from it_asset_issuenote_tbl where asset_issueNote_id="+i+" and surrender_flag=0");	
	ResultSet rs = ps.executeQuery();
	while(rs.next()){
		devId = rs.getInt("asset_deviceinfo_id");
		PreparedStatement psur=con.prepareStatement("select * from user_tbl where U_Id="+rs.getInt("issued_to"));	
		ResultSet rsur = psur.executeQuery();
		while(rsur.next()){
	%>
	<tr> 
	   <td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rsur.getString("U_Name") %></td>
	   <%
	   String comp ="",dept ="";
	   PreparedStatement pscomp=con.prepareStatement("select * from user_tbl_company where Company_Id="+rs.getInt("Company_Id"));	
		ResultSet rscomp = pscomp.executeQuery();
		while(rscomp.next()){
			comp = rscomp.getString("Company_Name");
			PreparedStatement psdept=con.prepareStatement("select * from user_tbl_dept where dept_id="+rsur.getInt("Dept_Id"));	
			ResultSet rsdept = psdept.executeQuery();
			while(rsdept.next()){
			dept = rsdept.getString("Department");
			}
		}
	   %>
	   <td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=comp %></td>
	   <td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=dept%></td>
	   <%
	   PreparedStatement ps_asset = con.prepareStatement("select * from it_asset_access_tbl where user_name="+rsur.getInt("U_Id"));
	   ResultSet rs_asset = ps_asset.executeQuery();
	   while(rs_asset.next()){
		   PreparedStatement ps_assetlist = con.prepareStatement("select * from it_asset_accesslist_tbl where accesslist_id="+rs_asset.getInt("accesslist_id"));
		   ResultSet rs_assetlist = ps_assetlist.executeQuery();
		   while(rs_assetlist.next()){
		   assetname.add(rs_assetlist.getString("access_name"));
		   }
	   }
	   %>
	   <td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=assetname%></td>
   </tr>
	<%
		} 
	}
	%>
	 </table>	   
	 <table border="0" width="100%" class="tftable">
	<tr> 
	   <td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Software's Provided</b></td>  
	</tr>
	<%
	String soft="";
	PreparedStatement ps_soft = con.prepareStatement("select * from it_asset_issuesoft_rel_tbl where asset_issueNote_id=" + noteId);		
	ResultSet rs_soft = ps_soft.executeQuery();
	while(rs_soft.next()){
		PreparedStatement ps_software = con.prepareStatement("select * from it_asset_software_mst_tbl where asset_software_id="+rs_soft.getInt("asset_software_id"));		
		ResultSet rs_software = ps_software.executeQuery();
		while(rs_software.next()){
		soft = rs_software.getString("software_name") + "&nbsp;,&nbsp;" + soft;
		}
	}
	%>
	<tr> 
	   <td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=soft %></td>  
	</tr> 
	</table> 
	 <%
	 PreparedStatement ps_user = con.prepareStatement("select * from it_asset_issuenote_tbl where surrender_flag=1 and asset_deviceinfo_id="+devId);
		ResultSet rs_user = ps_user.executeQuery();
		
		rs_user.last();
		int prevUser = rs_user.getRow();
		rs_user.beforeFirst();
		if (prevUser > 0) {
	%>
<table border="0" width="100%" class="tftable">
<tr>
<td colspan="9" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Previous User Info</b></td> 
</tr>
<tr>
<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>User Name</b></td>
<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Company</b></td>
<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Issue Date</b></td>
<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Issued By</b></td>

<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Working Location</b></td>
<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Contact</b></td> 
<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Email</b></td>
<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Surrender Date</b></td>
<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Condition</b></td>  
</tr>
<%
while(rs_user.next()){ 
%>
<tr align="center"> 	 
<%
PreparedStatement ps_usernm = con.prepareStatement("select * from user_tbl where U_Id="+rs_user.getInt("issued_to")); 
ResultSet rs_usernm = ps_usernm.executeQuery();
while(rs_usernm.next()){
%>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_usernm.getString("U_Name") %></td>
<%
}
PreparedStatement ps_comp = con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_user.getInt("Company_Id"));
ResultSet rs_comp = ps_comp.executeQuery();			
while(rs_comp.next()){
%>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_comp.getString("Company_Name") %></td>
<%
}
SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); 
String issueDate = formatter.format(rs_user.getDate("issue_date"));
%>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=issueDate%></td>
<%
PreparedStatement ps_givenby = con.prepareStatement("select * from user_tbl where U_Id="+rs_user.getInt("given_by"));
ResultSet rs_givenby = ps_givenby.executeQuery();
while(rs_givenby.next()){
%>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_givenby.getString("U_Name") %></td>
<%
}
%>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_user.getString("location") %></td>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_user.getString("contact_no") %></td>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_user.getString("Email") %></td>
<%
PreparedStatement ps_surDate = con.prepareStatement("select * from it_asset_device_surrender_tbl where asset_issueNote_id="+rs_user.getInt("asset_issueNote_id")); 
ResultSet rs_surdate = ps_surDate.executeQuery();
while(rs_surdate.next()){
%>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=formatter.format(rs_surdate.getDate("surrender_date")) %></td>
<%
PreparedStatement ps_sur = con.prepareStatement("select * from it_asset_device_surrender_condition_tbl where asset_device_sur_condi_id="+rs_surdate.getInt("asset_device_sur_condi_id"));
ResultSet rs_sur = ps_sur.executeQuery();
while(rs_sur.next()){
%>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_sur.getString("device_condition") %></td>
<%
}
}
%>
</tr>
<%
}
%>
</table>
  		<%
		}
  		%>  
<table border="0" width="100%" class="tftable">
	<tr>
	<td colspan="9" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b style="font-size: 20px;">Device Details</b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Device Name</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Supplier Name</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Device Type</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>OS Installed</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>IP Address(if any)</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Description / Particulars</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>MAC Address(if any)</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Model No</b></td>  
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>IMEI No (If any)</b></td> 
	</tr>
	<%
	PreparedStatement ps_ad=con.prepareStatement("select * from it_asset_deviceinfo_tbl where asset_deviceinfo_id="+devId);
	ResultSet rs_ad=ps_ad.executeQuery();
	while(rs_ad.next()){  			
	%>
	<tr align="center">
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><strong><%=rs_ad.getString("device_name")%></strong></td>
	<%
	PreparedStatement ps_sup = con.prepareStatement("select * from it_asset_supplier_mst_tbl where asset_supplier_mst_id="+rs_ad.getInt("asset_supplier_mst_id"));
	ResultSet rs_sup = ps_sup.executeQuery();
	while(rs_sup.next()){		
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_sup.getString("supplier") %></td>
	<%
	}
	ps_sup.close();
	rs_sup.close();
	PreparedStatement ps_devType = con.prepareStatement("select * from it_asset_devicetype_mst_tbl where devicetype_mst_id="+rs_ad.getInt("devicetype_mst_id"));
	ResultSet rs_devType = ps_devType.executeQuery();
	while(rs_devType.next()){ 	
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_devType.getString("device_type") %></td>
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
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=os%></td>
	<%	
	PreparedStatement ps_ip = con.prepareStatement("select * from it_asset_ipaddress_mst_tbl  where asset_ipaddress_id="+rs_ad.getInt("asset_ipaddress_id"));
	ResultSet rs_ip = ps_ip.executeQuery();
	
	rs_ip.last();
	int gData = rs_ip.getRow();
	rs_ip.beforeFirst();
	if (gData > 0) { 
	while(rs_ip.next()){	
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_ip.getString("ip_address") %></td>
	<%
	}
	}else{
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;">&nbsp;</td>
	<%	
	}
	ps_devType.close();
	rs_devType.close();
	if(rs_ad.getString("description")!=null){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_ad.getString("description") %></td>
	<%	
	}else{
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;">&nbsp;</td>
	<%	
	}	
	if(rs_ad.getString("hrd_mac_address")!=null){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_ad.getString("hrd_mac_address") %></td>
	<%	
	}else{
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;">&nbsp;</td>
	<%	
	}
	if(rs_ad.getString("model_no")!=null){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_ad.getString("model_no") %></td>
	<%
	}else{
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;">&nbsp;</td>
	<%
	} 
	if(rs_ad.getString("imei_no")!=null){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_ad.getString("imei_no") %></td>
	<%
	}else{
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;">&nbsp;</td>
	<%
	} 
	%> 	
	</tr>
	<% 
		}
	ps_ad.close();
	rs_ad.close();
	%>
	</table> 
	<div style="float: left;width: 49%">
	<table border="0" width="100%" class="tftable">
	<tr>
	<td colspan="3" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Part Details</b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Part Name </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Quantity </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Specification </b></td>
	</tr>
	<%
	PreparedStatement ps_adev=con.prepareStatement("select * from it_asset_deviceitem_rel_tbl where asset_deviceinfo_id="+devId +" and avail_flag=1 and scrap_flag=0");
	ResultSet rs_adev=ps_adev.executeQuery();
	while(rs_adev.next()){  
	%>
	<tr align="center"> 
	<%
	PreparedStatement ps_partname=con.prepareStatement("select * from it_asset_deviceitem_mst_tbl where asset_deviceitem_mst_id="+rs_adev.getInt("asset_deviceitem_mst_id"));
	ResultSet rs_partname=ps_partname.executeQuery();
	while(rs_partname.next()){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_partname.getString("device_parts") %></td>
	<%
	}
	ps_partname.close();
	rs_partname.close();
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_adev.getString("qty") %></td> 
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_adev.getString("specification") %></td>
	 
	</tr>
	<% 
		}
	ps_ad.close();
	rs_ad.close();
	%>
	</table>
</div><div style="float:right; width: 49%">
	<table border="0" width="100%" class="tftable">
	<tr>
	<td colspan="9" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Device Repair Details</b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Device Name</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Req. No</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Part Repaired</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Part Replaced with Qty</b></td>
	
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Old Part Condition</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Repaired By</b></td> 
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Date Repair</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Details</b></td>   
	</tr> 
	<%
	PreparedStatement ps_rep=con.prepareStatement("select * from it_asset_device_partrepair_tbl where asset_deviceinfo_id="+devId);
	ResultSet rs_rep=ps_rep.executeQuery();
	while(rs_rep.next()){ 
	%>
	<tr align="center">
	<%
	PreparedStatement ps_getdevnm=con.prepareStatement("select * from it_asset_deviceinfo_tbl where asset_deviceinfo_id="+rs_rep.getInt("asset_deviceinfo_id"));
	ResultSet rs_getdevnm=ps_getdevnm.executeQuery();
	while(rs_getdevnm.next()){
	%>  
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_getdevnm.getString("device_name") %></td>
	<%
	}
	ps_getdevnm.close();
	rs_getdevnm.close();
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_rep.getInt("U_Req_Id") %></td>
	<%
	String part="--",partRep="--",partUsed="--",qtyUsed="--";
	PreparedStatement ps_part=con.prepareStatement("select * from it_asset_deviceitem_mst_tbl where asset_deviceitem_mst_id="+rs_rep.getInt("part_repaired"));
	ResultSet rs_part=ps_part.executeQuery();
	while(rs_part.next()){
		part = rs_part.getString("device_parts");
		partUsed = rs_part.getString("device_parts");
	}
	if(rs_rep.getInt("no_of_partused")!=0){ 
		part = "--";
	}
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=part%></td>
	<% 
	ps_part.close();    
	rs_part.close(); 
	if(rs_rep.getInt("no_of_partused")!=0){
		partRep = partUsed;
		qtyUsed = String.valueOf(rs_rep.getInt("no_of_partused"));
	} 
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=qtyUsed%>&nbsp;<%=partRep%></td>
	<%  
	String part_cond = "--";
	PreparedStatement ps_partcond=con.prepareStatement("select * from it_asset_device_surrender_condition_tbl where asset_device_sur_condi_id="+rs_rep.getInt("asset_device_sur_condi_id"));
	ResultSet rs_partcond=ps_partcond.executeQuery();
	while(rs_partcond.next()){
		part_cond = rs_partcond.getString("device_condition"); 
	}
	
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=part_cond%></td>
	<% 
	ps_partcond.close();
	rs_partcond.close();
	PreparedStatement ps_repBy=con.prepareStatement("select * from user_tbl where U_Id="+rs_rep.getInt("repaired_by"));
	ResultSet rs_repBy = ps_repBy.executeQuery();
	while(rs_repBy.next()){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_repBy.getString("U_Name") %></td>
	<% 
	}
	ps_repBy.close();
	rs_repBy.close();
	%>	
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_rep.getDate("repaire_date") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_rep.getString("repaire_details") %></td>
	</tr> 
	<%
	}
	ps_rep.close();   
	rs_rep.close();
	%>
	</table>
	</div> 
</span>
<%
}else{
%>
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
<%
}
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>