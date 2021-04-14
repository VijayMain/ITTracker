<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<html>
<head> 
<title>Avail User Info</title> 
</head>
<body> 
<span id="user">
<%
		try{
		
		 	String str = request.getParameter("q"); 
		 	String location="";
		 	int i = Integer.parseInt(str);
			int noteId=0;
			Connection con  = Connection_Utility.getConnection();
%> 
	<table border="1"  style="font-size: 10px; color: #333333; width: 90%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
	<tr> 
	   <td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>User Name </b></td>
	   <td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Company </b></td>
	   <td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Department </b></td>
	   <td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Location</b></td>  
	</tr>
	<%
	PreparedStatement ps=con.prepareStatement("select * from it_asset_issuenote_tbl where asset_deviceinfo_id="+i+" and surrender_flag=0");	
	ResultSet rs = ps.executeQuery();
	while(rs.next()){
		PreparedStatement psur=con.prepareStatement("select * from user_tbl where U_Id="+rs.getInt("issued_to"));	
		ResultSet rsur = psur.executeQuery();
		while(rsur.next()){
	%>
	<tr align="left"> 
	   <td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=rsur.getString("U_Name") %></td>
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
		location = rs.getString("location");
	   %>
	   <td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=comp %></td>
	    
	   <td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=dept%></td>
	   <td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: left;"><%=location%></td>
	   <%
		
	   %>  
	</tr>
	<%
		}
	noteId = rs.getInt("asset_issueNote_id");
	}
	%>
	 </table>	 
	  	<input type="hidden" name="noteId" id="noteId" value="<%=noteId%>"/>  
	 <%PreparedStatement ps_user = con.prepareStatement("select * from it_asset_issuenote_tbl where surrender_flag=1 and asset_deviceinfo_id="+i);
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
<tr align="left"> 	 
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
<%
	}		
		}catch(Exception e){
			e.printStackTrace();
		}
%>
	 </span>
	 
</body>
</html>