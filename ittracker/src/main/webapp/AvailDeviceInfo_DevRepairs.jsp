<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<html>
<head> <title>Avail Dev Repairs</title>
</head>
<body>
<span id="devRepairsData">
<%
try{
			String str = request.getParameter("q");
			int i = Integer.parseInt(str);
			Connection con  = Connection_Utility.getConnection(); 
%>
<table border="1" style="font-size: 10px; color: #333333; width: 100%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
	<tr>
	<td colspan="9" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Device Details</b></td> 
	</tr>
	<tr>
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
	PreparedStatement ps_ad=con.prepareStatement("select * from it_asset_deviceinfo_tbl where asset_deviceinfo_id="+i);
	ResultSet rs_ad=ps_ad.executeQuery();
	while(rs_ad.next()){  			
	%>
	<tr align="center">	
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
	<br/>
	<table border="1"  style="font-size: 10px; color: #333333; width: 100%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
	<tr>
	<td colspan="3" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Part Details</b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Part Name </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Quantity </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Specification </b></td>
	</tr>
	<%
	PreparedStatement ps_adev=con.prepareStatement("select * from it_asset_deviceitem_rel_tbl where asset_deviceinfo_id="+i +" and avail_flag=1 and scrap_flag=0");
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
	<br/>
	<table border="1"  style="font-size: 10px; color: #333333; width: 100%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
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
	PreparedStatement ps_rep=con.prepareStatement("select * from it_asset_device_partrepair_tbl where asset_deviceinfo_id="+i);
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
	<% 
	con.close();
}catch(Exception e){
	e.printStackTrace();
}
	%>
	<!-- 
	************************************************************************************************************************
	 -->	 
</span>
</body>
</html>