<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<html>
<head> 
<title>Get Toner Data</title>
</head>
<body>
<span id="tonerRef"> 
		<%
 		try {
 		String str = request.getParameter("q");  
 		int i = Integer.parseInt(str); 
 		Connection con = Connection_Utility.getConnection();
 		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
 		int cnt = 1; 
 		PreparedStatement ps_prev = con.prepareStatement("select * from it_asset_printertoner_tbl where asset_deviceinfo_id=" + i);
 		ResultSet rs_prev = ps_prev.executeQuery(); 
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
		con.close();
 		} catch (Exception e) {
 		e.printStackTrace();
	 	}
 		%> 
</span>  
</body>
</html>