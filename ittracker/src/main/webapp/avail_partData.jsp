<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<html>
<head> 
<title>Avail Device Info</title> 
</head>
<body> 
<span id="devData">
<%
			String str = request.getParameter("q");
if(!str.equalsIgnoreCase("")){
			int i = Integer.parseInt(str);

			Connection con  = Connection_Utility.getConnection();
%> 
<table border="1" style="font-size: 12px; color: #333333; width: 100%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
	<tr>
	<td colspan="9" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Device Details</b></td> 
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
	PreparedStatement ps_ad=con.prepareStatement("select * from it_asset_deviceinfo_tbl where asset_deviceinfo_id="+i);
	ResultSet rs_ad=ps_ad.executeQuery();
	while(rs_ad.next()){  
	%>
	<tr align="center">	
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_ad.getString("device_name")%></td>
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
	%> 
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_ad.getString("description") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_ad.getString("hrd_mac_address") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_ad.getString("model_no") %></td> 
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_ad.getString("imei_no") %></td> 
	
	
	</tr>
	<% 
		}
	ps_ad.close();
	rs_ad.close();
	%>
	</table>
	<!-- 
	************************************************************************************************************************
	 -->	 
	 <span id="data_availPart">
	 <table border="1"  style="font-size: 12px; color: #333333; width: 90%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
	<tr>
	<td colspan="4" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Part Details</b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Part Name </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Quantity </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Specification </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Remove </b></td>  
	</tr>
	<%
	PreparedStatement ps_adev=con.prepareStatement("select * from it_asset_deviceitem_rel_tbl where asset_deviceinfo_id="+i +" and avail_flag=1 and scrap_flag=0");
	ResultSet rs_adev=ps_adev.executeQuery();
	while(rs_adev.next()){
	%>
	<tr> 
	<%
	PreparedStatement ps_partname=con.prepareStatement("select * from it_asset_deviceitem_mst_tbl where asset_deviceitem_mst_id="+rs_adev.getInt("asset_deviceitem_mst_id"));
	ResultSet rs_partname=ps_partname.executeQuery();
	while(rs_partname.next()){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;text-align: left;"><%=rs_partname.getString("device_parts") %></td>
	<%
	}
	ps_partname.close();
	rs_partname.close();
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;text-align: center;"><%=rs_adev.getString("qty") %></td> 
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;text-align: left;"><%=rs_adev.getString("specification") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;">
<input type="button" id="delete" name="delete" value="Remove" onclick="removeItem('<%=rs_adev.getInt("asset_deviceitem_rel_id")%>')" />
</td>
	</tr>
	<% 
		}
	ps_ad.close();
	rs_ad.close();
	%>
	</table>
	 </span>
	 <%
		}
	%>
	</span>	 
	
</body>
</html>