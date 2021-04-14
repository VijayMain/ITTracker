<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<html>
<head> 
<title>Insert title here</title>
</head>
<body>
<span id="printData"> 
		<%
 		try {
 		String str = request.getParameter("q");  
 		int i = Integer.parseInt(str);
 		int cnt = 1;
 		Connection con = Connection_Utility.getConnection();
 		PreparedStatement ps_prev = con.prepareStatement("select * from it_asset_printerrefill_tbl where asset_deviceinfo_id=" + i);
 		ResultSet rs_prev = ps_prev.executeQuery();
 		
 		rs_prev.last();
		int mcData = rs_prev.getRow();
		rs_prev.beforeFirst();
		if (mcData > 0) {
			
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
	while(rs_prev.next()){ 
	%>
	<tr align="center">
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=cnt %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=rs_prev.getString("prev_print_count") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=rs_prev.getString("current_print_count") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=rs_prev.getString("avg_count") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=rs_prev.getString("ink_used") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=rs_prev.getString("refillDate") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5;"><%=rs_prev.getString("notes") %></td>
	<%
	PreparedStatement ps_user = con.prepareStatement("select * from user_tbl where U_Id="+rs_prev.getInt("refilled_by"));
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
		con.close();
 		} catch (Exception e) {
 		e.printStackTrace();
	 	}
 		%>
</body>
</html>