<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<span id="issuAttach">
<%
try{
	int i=0;
	Connection con = Connection_Utility.getConnection(); 
	int uid = Integer.parseInt(session.getAttribute("uid").toString()); 
	int isissue=Integer.parseInt(request.getParameter("q")); 		
	PreparedStatement ps_devinfo=con.prepareStatement("select * from it_asset_issuenote_tbl where asset_issueNote_id="+isissue);
	ResultSet rs_devInfo = ps_devinfo.executeQuery(); 
	while(rs_devInfo.next()){
		i = rs_devInfo.getInt("asset_deviceinfo_id");
	}
	PreparedStatement ps_user = con.prepareStatement("select * from it_asset_issuenote_tbl where surrender_flag=1 and asset_deviceinfo_id="+i);
	ResultSet rs_user = ps_user.executeQuery();
	
	rs_user.last();
	int prevUser = rs_user.getRow();
	rs_user.beforeFirst();
	if (prevUser > 0) {
%>
<table border="1" style="font-size: 10px; color: #333333; width: 100%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
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
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_usernm.getString("U_Name") %></td>
<%
}
PreparedStatement ps_comp = con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_user.getInt("Company_Id"));
ResultSet rs_comp = ps_comp.executeQuery();			
while(rs_comp.next()){
%>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_comp.getString("Company_Name") %></td>
<%
}
SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); 
String issueDate = formatter.format(rs_user.getDate("issue_date"));
%>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=issueDate%></td>
<%
PreparedStatement ps_givenby = con.prepareStatement("select * from user_tbl where U_Id="+rs_user.getInt("given_by"));
ResultSet rs_givenby = ps_givenby.executeQuery();
while(rs_givenby.next()){
%>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_givenby.getString("U_Name") %></td>
<%
}
%>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_user.getString("location") %></td>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_user.getString("contact_no") %></td>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_user.getString("Email") %></td>
<%
PreparedStatement ps_surDate = con.prepareStatement("select * from it_asset_device_surrender_tbl where asset_issueNote_id="+rs_user.getInt("asset_issueNote_id")); 
ResultSet rs_surdate = ps_surDate.executeQuery();
while(rs_surdate.next()){
%>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=formatter.format(rs_surdate.getDate("surrender_date")) %></td>
<%
PreparedStatement ps_sur = con.prepareStatement("select * from it_asset_device_surrender_condition_tbl where asset_device_sur_condi_id="+rs_surdate.getInt("asset_device_sur_condi_id"));
ResultSet rs_sur = ps_sur.executeQuery();
while(rs_sur.next()){
%>
<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_sur.getString("device_condition") %></td>
<%
}
}
%>
</tr>
<%
}
%>
</table>
<br/>
<%
	}	
%>
	
<table border="1" style="font-size: 10px; color: #333333; width: 100%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;text-align: center;">
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
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>IMEI No 1 (If any)</b></td>   
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
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_sup.getString("supplier") %></td>
	<%
	}
	ps_sup.close();
	rs_sup.close();
	PreparedStatement ps_devType = con.prepareStatement("select * from it_asset_devicetype_mst_tbl where devicetype_mst_id="+rs_ad.getInt("devicetype_mst_id"));
	ResultSet rs_devType = ps_devType.executeQuery();
	while(rs_devType.next()){ 	
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_devType.getString("device_type") %></td>
	<%
	}
	String os="";
	PreparedStatement ps_os = con.prepareStatement("select * from it_asset_os_mst_tbl where asset_OS_id="+rs_ad.getInt("asset_OS_id"));
	ResultSet rs_os = ps_os.executeQuery();
	while(rs_os.next()){
		os = rs_os.getString("os_name");
	}	
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=os%></td>
	<%
	ps_devType.close();
	rs_devType.close();
	PreparedStatement ps_ip = con.prepareStatement("select * from it_asset_ipaddress_mst_tbl  where asset_ipaddress_id="+rs_ad.getInt("asset_ipaddress_id"));
	ResultSet rs_ip = ps_ip.executeQuery();
	
	rs_ip.last();
	int gData = rs_ip.getRow();
	rs_ip.beforeFirst();
	if (gData > 0) { 
	while(rs_ip.next()){
	
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_ip.getString("ip_address") %></td>
	<%
	}
	}else{
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;">&nbsp;</td>
	<%	
	}
	ps_devType.close();
	rs_devType.close();
	if(rs_ad.getString("description")!=null){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_ad.getString("description") %></td>
	<%	
	}else{
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;">&nbsp;</td>
	<%	
	}
	
	if(rs_ad.getString("hrd_mac_address")!=null){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_ad.getString("hrd_mac_address") %></td>
	<%	
	}else{
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;">&nbsp;</td>
	<%	
	}

	if(rs_ad.getString("model_no")!=null){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_ad.getString("model_no") %></td>
	<%
	}else{
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;">&nbsp;</td>
	<%
	}
 

	if(rs_ad.getString("imei_no")!=null){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rs_ad.getString("imei_no") %></td>
	<%
	}else{
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;">&nbsp;</td>
	<%
	} 
	%>  
	</tr>
	<% 
		}
	ps_ad.close();
	rs_ad.close();
	
	PreparedStatement ps_term=con.prepareStatement("select * from it_asset_issueinfo_attach_tbl where Enable_id=1 and asset_issueNote_id="+isissue);
	ResultSet rs_term = ps_term.executeQuery();
	%>
	</table>
 <br/>
 <table border="1" id="delete" style="font-size: 10px; color: #333333; width: 100%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;text-align: center;">
	<tr>
	<td colspan="5" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Available Documents </b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Issue Note </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>File Description </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Date </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Attachments </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Delete </b></td> 
	</tr>
	<%	
	while(rs_term.next()){
	%>
	<tr>
		<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_term.getInt("asset_issueNote_id") %></td>
		<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_term.getString("description") %></td>
		<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_term.getDate("attached_date") %></td>
		<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;">
		<a href="DisplayIssueNote.jsp?field=<%=rs_term.getInt("asset_Issueinfo_attach_id")%>"><%=rs_term.getString("file_name")%></a>
		</td>		
		<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;">		
		<input type="button" name="delete" value="Delete" onclick="delother('<%=rs_term.getInt("asset_Issueinfo_attach_id")%>')" />			
</td>
	</tr>
	<%
	}	
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	</table>
	</span>	
</body>
</html>