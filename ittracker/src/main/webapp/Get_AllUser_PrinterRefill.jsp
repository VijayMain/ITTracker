<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
<title>Printer Refill</title>
</head>
<body>
<%
try{
String str = request.getParameter("q");
SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
if(!str.equalsIgnoreCase("")){
	int i = Integer.parseInt(str);

	Connection con  = Connection_Utility.getConnection();
%>
<span id="getSelected_userInfo">
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
	<%
	 
 		int cnt = 1; 
 		PreparedStatement ps_prev = con.prepareStatement("select * from it_asset_printertoner_tbl where asset_deviceinfo_id=" + i);
 		ResultSet rs_prev = ps_prev.executeQuery(); 
 		rs_prev.last();
		int mcData = rs_prev.getRow();
		rs_prev.beforeFirst();
		if (mcData > 0) {
 		%> 
 <table border="1" style="font-size: 14px; color: #333333; width: 100%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
	<tr>
	<td colspan="9" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Toner Updates</b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Sr No</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Operation</b></td>	
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Print Count</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Refilled By </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Refill Date</b></td>	
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Amount Paid </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Notes</b></td>  
	</tr>
	<%
	while(rs_prev.next()){
	%>
	<tr align="center">
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=cnt %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=rs_prev.getString("toner_operation") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=rs_prev.getString("reading") %></td>
	<%
	PreparedStatement ps_user = con.prepareStatement("select * from user_tbl where U_Id="+rs_prev.getInt("refilled_by"));
	ResultSet rs_user = ps_user.executeQuery();
	while(rs_user.next()){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_user.getString("U_Name") %></td>
	<%
	}
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=formatter.format(rs_prev.getDate("refill_date") ) %></td> 
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=rs_prev.getString("amount_paid") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=rs_prev.getString("notes") %></td>	
	</tr>
	<%
	cnt++;
	} 
	%>
 </table>
 <%
} 
 PreparedStatement ps_prevrefill = con.prepareStatement("select * from it_asset_printerrefill_tbl where asset_deviceinfo_id=" + i);
 		ResultSet rs_prevrefill = ps_prevrefill.executeQuery();
 		
 		rs_prevrefill.last();
		int mcDatarefill = rs_prevrefill.getRow();
		rs_prevrefill.beforeFirst();
		if (mcDatarefill > 0) {
			
 		%> 
 <table border="1" style="font-size: 14px; color: #333333; width: 100%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
	<tr>
	<td colspan="9" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Printing Details</b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Sr No</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Before fill Count</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>After fill Count</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Avg. Count</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Ink Used (in ml)</b></td>
	
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Refill Date</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Notes</b></td> 
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>refilled_by</b></td>  
	</tr>
	<%
	while(rs_prevrefill.next()){ 
	%>
	<tr align="center">
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=cnt %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=rs_prevrefill.getString("prev_print_count") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=rs_prevrefill.getString("current_print_count") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=rs_prevrefill.getString("avg_count") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=rs_prevrefill.getString("ink_used") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=rs_prevrefill.getString("refillDate") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=rs_prevrefill.getString("notes") %></td>
	<%
	PreparedStatement ps_user = con.prepareStatement("select * from user_tbl where U_Id="+rs_prevrefill.getInt("refilled_by"));
	ResultSet rs_user = ps_user.executeQuery();
	while(rs_user.next()){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_user.getString("U_Name") %></td>
	<%
	}
	%>
	</tr>
	<%
	cnt++;
	} 
	%>
 </table>
 <%
		}
 %>
 
</span>
<%
}
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>