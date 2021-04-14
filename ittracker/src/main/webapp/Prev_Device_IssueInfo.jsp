<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<html>
<head> <title>Previous Issue Info</title>
</head>
<body>
<span id="prevUserData">
<%
try{
	

			String str = request.getParameter("q");

			int i = Integer.parseInt(str);

			Connection con  = Connection_Utility.getConnection();
			
			PreparedStatement ps_user = con.prepareStatement("select * from it_asset_issuenote_tbl where surrender_flag=1 and asset_deviceinfo_id="+i);
			ResultSet rs_user = ps_user.executeQuery();
			
			rs_user.last();
			int prevUser = rs_user.getRow();
			rs_user.beforeFirst();
			if (prevUser > 0) {
%>
<table border="1" style="font-size: 11px; color: #333333; width: 120%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
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
<br/>
	<%
			}	
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